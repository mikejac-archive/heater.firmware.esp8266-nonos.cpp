/* 
 * The MIT License (MIT)
 * 
 * ESP8266 Non-OS Firmware
 * Copyright (c) 2015 Michael Jacobsen (github.com/mikejac)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#include <github.com/mikejac/misc.esp8266-nonos.cpp/espmissingincludes.h>
#include <github.com/mikejac/misc.esp8266-nonos.cpp/uart.h>
#include <github.com/mikejac/date_time.esp8266-nonos.cpp/system_time.h>
#include <github.com/mikejac/timer.esp8266-nonos.cpp/timer.h>
#include <github.com/mikejac/rpcmqtt.esp8266-nonos.cpp/service_device.h>
#include <github.com/mikejac/blinker.esp8266-nonos.cpp/blinker.h>
#include <github.com/mikejac/button.esp8266-nonos.cpp/button.h>
#include <github.com/mikejac/esp-open-rtos.gpio.esp8266-nonos.cpp/gpio/gpio.h>
#include <github.com/mikejac/wifi.esp8266-nonos.cpp/wifi.h>
#include <github.com/mikejac/upgrader.esp8266-nonos.cpp/upgrader.h>
#include <github.com/mikejac/raburton.rboot.esp8266-nonos.cpp/appcode/rboot-api.h>
#include <github.com/mikejac/dht.esp8266-nonos.cpp/dht22.hpp>
#include <github.com/mikejac/br3ttb.pid.esp8266-nonos.cpp/Arduino-PID-Library/PID_v1.h>
#include "user_config.h"
#include "package.h"
#include "wifi.h"

#define DTXT(...)   os_printf(__VA_ARGS__)

// tasks
#define TASK0_ID            0
#define TASK1_ID            1
#define TASK2_ID            2

#define QUEUE_SIZE          2

/******************************************************************************************************************
 * global variables
 *
 */

const char          m_PkgId[]   = PKG_ID;
const uint32_t      m_Version   = PKG_VERSION;
char                m_Pkg[16];

os_event_t          task0_queue[QUEUE_SIZE];

MqttOptions*        mqttOptions;
Mqtt*               mqtt;
MqttDevice*         device;

AccThermometer*     outdoorThermometer = NULL;
AccHumidity*        outdoorHumidity    = NULL;
AccHumidity*        indoorHumidity     = NULL;
AccThermostat*      thermostat         = NULL;
AccText*            message            = NULL;

UPGRADER            m_Upgrader;
BLINKER             m_BlueLED;

Timer               m_DhtCountdown = Timer_initializer;

WIFI_AP             wifi_list[] = {
    { SSID1, PSW1 },
    { SSID2, PSW2 },
    { NULL,         NULL}
};

// DHT sensors
esp_nonos::dht::dht22_t         m_Dht1;
esp_nonos::dht::dht22_t         m_Dht2;

// PID controller
PID                 m_Pid;
int                 m_PidEnable;
int                 m_PidFan;
int                 m_PidHeater1;
int                 m_PidHeater2;
Timer               m_PidFanCountdown = Timer_initializer;
esp_time_t          m_PidStage2;

// DHT sensor results
double              m_Temp1;
double              m_Hum1;
double              m_Temp2;
double              m_Hum2;

/******************************************************************************************************************
 * prototypes
 *
 */

/**
 * 
 */
static void onConnect(void);
/**
 * 
 * @param mqtt
 * @param ptr
 * @param nodename
 * @param actorId
 * @param platformId
 * @param feedId
 * @param payload
 */
static void onCommandCallback(  Mqtt*       mqtt, 
                                void*       ptr,
                                const char* nodename,
                                const char* actorId,
                                const char* platformId,
                                const char* feedId,
                                const char* payload);
/**
 * 
 * @param mode
 */
static void setPidMode(uint8_t mode);
/**
 * 
 * @param mode
 */
static void setPidSetpoint(double value);
/**
 * 
 */
static void runPid(void);
/**
 * 
 */
static void updatePidStatus(void);

/******************************************************************************************************************
 * functions
 *
 */

/**
 * 
 * @param e
 */
void ICACHE_FLASH_ATTR task1(os_event_t* e)
{
    /******************************************************************************************************************
     * run PID controller
     * 
     */
    runPid();

    /******************************************************************************************************************
     * read DHT sensors
     * 
     */
    if(expired(&m_DhtCountdown)) {
        Info(mqtt, "Read DHT sensors");
        
        double temp, hum;

        if(m_Dht1.read(temp, hum) == 0) {
            m_Hum1  = hum;
            m_Temp1 = temp;

            // tell the PID controller
            m_Pid.Input(m_Temp1);

            AccThermostatCurrentTemperatureSetValue(thermostat, m_Temp1);
            AccHumidityCurrentRelativeHumiditySetValue(indoorHumidity, m_Hum1);
        } else {
            Warning(mqtt, "Failed to read DHT1 sensor");
        }
        
        if(m_Dht2.read(temp, hum) == 0) {
            m_Temp2 = temp;
            m_Hum2  = hum;
            
            AccThermometerCurrentTemperatureSetValue(outdoorThermometer, m_Temp2);
            AccHumidityCurrentRelativeHumiditySetValue(outdoorHumidity, m_Hum2);
        } else {
            Warning(mqtt, "Failed to read DHT2 sensor");
        }

        countdown(&m_DhtCountdown, DHT_INTERVAL);
    }
    
    /******************************************************************************************************************
     * deal with MQTT
     * 
     */
    int event = ConnectorRun(mqtt);
    if(event == RUN_CONNECTED) {
        onConnect();
    }
    
    /******************************************************************************************************************
     * deal with incoming value updates
     * 
     */
    Device_Message* dm;
    
    switch(DeviceGetEventType(dm = DeviceGetEvent(device))) {
        case FormatString:  
            break;
        case FormatBool:
            DTXT("Bool; aid = %lld, iid = %lld, value = %s\n", Device_GetAid(dm), Device_GetIid(dm), (Device_GetValueBool(dm) == true) ? "True" : "False");
            break;
        case FormatUInt8:   
            DTXT("UInt8; aid = %lld, iid = %lld, value = %d\n", Device_GetAid(dm), Device_GetIid(dm), Device_GetValueUInt8(dm));
            if(dm->acc == thermostat->Accessory) {
                DTXT("thermostat\n");
                
                if(Device_GetIid(dm) == AccThermostatTargetHeatingCoolingStateIid) {
                    setPidMode(Device_GetValueUInt8(dm));
                }
            }
            break;
        case FormatInt8:    
            break;
        case FormatUInt16:  
            break;
        case FormatInt16:   
            break;
        case FormatUInt32:  
            break;
        case FormatInt32:   
            break;
        case FormatUInt64:  
            break;
        case FormatFloat:   
            DTXT("Float; aid = %lld, iid = %lld\n", Device_GetAid(dm), Device_GetIid(dm));
            if(dm->acc == thermostat->Accessory) {
                if(Device_GetIid(dm) == AccThermostatTargetTemperatureIid) {
                    setPidSetpoint(Device_GetValueFloat(dm));
                }
            }
            break;
        case FormatNone:
            break;
    }
    
    DeviceDeleteEvent(dm);

    /******************************************************************************************************************
     * show we're alive
     * 
     */
    if(WIFI_IsConnected()) {
        if(IsConnected(mqtt)) {
            Blinker_Set(&m_BlueLED, 200, 3000);
        } else {
            Blinker_Set(&m_BlueLED, 1000, 1000);
        }
    } else {
        Blinker_Set(&m_BlueLED, 200, 200);
    }
    
    Blinker_Run(&m_BlueLED);

    /******************************************************************************************************************
     * firmware upgrader
     * 
     */
    if(Upgrader_NewPkg(&m_Upgrader)) {
        if(Close(mqtt)) {
            Upgrader_Run(&m_Upgrader);
        }
    }
    
    system_os_post(TASK1_ID, 0, 0);
}
/**
 * 
 */
void ICACHE_FLASH_ATTR onConnect(void)
{
    DTXT("onConnect():\n");

    // firmware upgrade service
    Upgrader_Subscribe_Package(&m_Upgrader);
    Upgrader_Publish_Package(&m_Upgrader);
}
/**
 * 
 * @param mqtt
 * @param ptr
 * @param nodename
 * @param actorId
 * @param platformId
 * @param feedId
 * @param payload
 */
void ICACHE_FLASH_ATTR onCommandCallback(Mqtt*          mqtt, 
                                         void*          ptr,
                                         const char*    nodename,
                                         const char*    actorId,
                                         const char*    platformId,
                                         const char*    feedId,
                                         const char*    payload)
{
    if(Upgrader_Check(&m_Upgrader, nodename, actorId, platformId, feedId, payload)) {
        
    } else {
        DTXT("onCommandCallback(): command message\n");
        DTXT("onCommandCallback(): nodename          = %s\n", nodename);
        DTXT("onCommandCallback(): actor_id          = %s\n", actorId);
        DTXT("onCommandCallback(): platform_id       = %s\n", platformId);
        DTXT("onCommandCallback(): feed_id           = %s\n", feedId);
        DTXT("onCommandCallback(): payload           = %s\n", payload);
    }
}
/**
 * 
 * @param mode
 */
void ICACHE_FLASH_ATTR setPidMode(uint8_t mode)
{
    switch(mode) {
        case TargetHeatingCoolingStateOff:
            DTXT("setPidMode(): thermostat off\n");
            
            if(m_PidEnable == 1) {
                DTXT("setPidMode(): PID disabled\n");
                m_Pid.SetMode(MANUAL);      // turn it off
                m_PidEnable = 0;
                
                AccThermostatCurrentHeatingCoolingStateSetValue(thermostat, CurrentHeatingCoolingStateOff);
            }

            if(m_PidHeater1 == 1) {
                DTXT("setPidMode(): heater 1 off (disable)\n");
                gpio_write(GPIO_HEATER1, HEATER_OFF);
                m_PidHeater1 = 0;

                countdown(&m_PidFanCountdown, FANTIMEOUT);
            }

            if(m_PidHeater2 == 1) {
                DTXT("setPidMode(): heater 2 off (disable)\n");
                gpio_write(GPIO_HEATER2, HEATER_OFF);
                m_PidHeater2 = 0;

                countdown(&m_PidFanCountdown, FANTIMEOUT);
            }

            // publish the change
            updatePidStatus();
            break;

        case TargetHeatingCoolingStateAuto:
            DTXT("setPidMode(): thermostat heat\n");
            if(m_PidEnable == 0) {
                m_Pid.SetMode(AUTOMATIC);      // turn it on
                m_PidEnable = 1;
            }
            break;

        case TargetHeatingCoolingStateHeat:
        case TargetHeatingCoolingStateCool:
            DTXT("setPidMode(): thermostat heat/cool\n");
            break;
    }
}
/**
 * 
 * @param mode
 */
void ICACHE_FLASH_ATTR setPidSetpoint(double value)
{
    m_Pid.Setpoint(value);
}
/**
 * 
 */
void ICACHE_FLASH_ATTR runPid(void)
{
    if(m_Temp1 == INVALID_TEMP) {
        return;         // no valid reading from DHT sensor
    }
    
    m_Pid.Compute();
    
    if(m_PidEnable == 1) {
        if(m_Pid.Output() > 1.0) {
            countdown(&m_PidFanCountdown, FANTIMEOUT);
            
            if(m_PidHeater1 == 0) {
                m_PidHeater1 = 1;
                m_PidFan     = 1;
                m_PidStage2  = esp_uptime(0);           // get ready for stage 2
                
                DTXT("runPid(): fan on\n");
                DTXT("runPid(): heater 1 on\n");
                
                gpio_write(GPIO_FAN,     FAN_ON);
                gpio_write(GPIO_HEATER1, HEATER_ON);
                
                // publish the change
                AccThermostatCurrentHeatingCoolingStateSetValue(thermostat, CurrentHeatingCoolingStateHeat);

                updatePidStatus();
            }

            // is it time to turn on heater 2?
            if(esp_uptime(0) - m_PidStage2 >= STAGE_2_TIME) {
                if(m_PidHeater2 == 0) {
                    m_PidHeater2 = 1;

                    DTXT("runPid(): heater 2 on\n");

                    gpio_write(GPIO_HEATER2, HEATER_ON);

                    // publish the change
                    updatePidStatus();
                }
            }
        } else {
            if(m_PidHeater1 == 1) {
                m_PidHeater1 = 0;
                
                DTXT("runPid(): heater 1 off\n");

                gpio_write(GPIO_HEATER1, HEATER_OFF);

                // publish the change
                AccThermostatCurrentHeatingCoolingStateSetValue(thermostat, CurrentHeatingCoolingStateOff);

                updatePidStatus();
            }
            
            if(m_PidHeater2 == 1) {
                m_PidHeater2 = 0;
                
                DTXT("runPid(): heater 2 off\n");

                gpio_write(GPIO_HEATER2, HEATER_OFF);

                // publish the change
                updatePidStatus();
            }
        }
    }
    
    //
    // turn fan off after some time
    //
    if(expired(&m_PidFanCountdown)) {
        if(m_PidFan == 1) {
            m_PidFan = 0;
            
            DTXT("runPid(): fan off\n");
            
            gpio_write(GPIO_FAN, FAN_OFF);
            
            // publish the change
            updatePidStatus();
        }
    }
}
/**
 * 
 */
void ICACHE_FLASH_ATTR updatePidStatus(void)
{
    char buffer[64];
    
    os_sprintf(buffer, "Varme 1: %s, Varme 2: %s, Blæser: %s",  (m_PidHeater1 == 1) ? "ON" : "OFF",
                                                                (m_PidHeater2 == 1) ? "ON" : "OFF",
                                                                (m_PidFan == 1) ?     "ON" : "OFF");
    
    AccTextSetValue(message, buffer);
}
/**
 * 
 */
void ICACHE_FLASH_ATTR main_init_done(void)
{
    DTXT("main_init_done(): begin\n");

    os_sprintf(m_Pkg, "%s %lu", m_PkgId, m_Version);
    
    Container* cont    = NewContainer(WIFI_GetMAC(), "Vaerksted", "001", "github.com/mikejac", m_Pkg, 6 * 1024);

    outdoorThermometer = NewAccThermometer("Udendørs Temperatur", "001-01", "github.com/mikejac", "ESP8266", 0, -10, 50, 0.1);
    outdoorHumidity    = NewAccHumidity("Udendørs Luftfugtighed", "001-02", "github.com/mikejac", "ESP8266", 0, 0, 100, 1);
    indoorHumidity     = NewAccHumidity("Værksted Luftfugtighed", "001-03", "github.com/mikejac", "ESP8266", 0, 0, 100, 1);
    thermostat         = NewAccThermostat("Værksted Termostat", "001-04", "github.com/mikejac", "ESP8266", 0, -10, 50, 0.1, PID_DEFAULT_SETPOINT, PID_MIN_SETPOINT, PID_MAX_SETPOINT, 1);
    message            = NewAccText("Værksted Besked", "001-05", "github.com/mikejac", "ESP8266", "Lige startet");
    
    AddAccessory(cont, outdoorThermometer->Accessory);
    AddAccessory(cont, outdoorHumidity->Accessory);
    AddAccessory(cont, indoorHumidity->Accessory);
    AddAccessory(cont, thermostat->Accessory);
    AddAccessory(cont, message->Accessory);

    WIFI_Run();
    
    mqttOptions = NewMqttOptions();
    if(mqttOptions != 0) {
        MqttOptions_SetServer(mqttOptions,          MQTT_BROKER_IP);
        MqttOptions_SetPort(mqttOptions,            MQTT_BROKER_PORT);
        MqttOptions_SetClientId(mqttOptions,        WIFI_GetMAC());
        MqttOptions_SetKeepalive(mqttOptions,       MQTT_KEEPALIVE);
        MqttOptions_SetRootTopic(mqttOptions,       FABRIC_ROOT_TOPIC);
        MqttOptions_SetNodename(mqttOptions,        WIFI_GetMAC());
        MqttOptions_SetActorPlatformId(mqttOptions, MY_PLATFORM_ID);
        MqttOptions_SetClassType(mqttOptions,       ClassTypeDeviceSvc);
        MqttOptions_SetBufferSize(mqttOptions,      6 * 1024);
        
        mqtt = Connector(mqttOptions);
        if(mqtt != 0) {
            InstallCallbacks(   mqtt,
                                NULL,
                                onCommandCallback);

            EnableChronos(mqtt, NODENAME_CHRONOS);

            device = NewDevice(mqtt);

            // 'device' takes ownership of container when set
            SetAccessories(device, cont);

            Upgrader_Initialize(&m_Upgrader, mqtt, NODENAME_UPGRADER, m_PkgId, &m_Version);
        }
    }
            
    Blinker_Initialize(&m_BlueLED, GPIO_BLUE);
    Blinker_Set(&m_BlueLED, 200, 200);
    Blinker_Enable_on(&m_BlueLED);

    gpio_enable(GPIO_FAN,     GPIO_OUTPUT);
    gpio_enable(GPIO_HEATER1, GPIO_OUTPUT);
    gpio_enable(GPIO_HEATER2, GPIO_OUTPUT);

    gpio_write(GPIO_FAN,     FAN_OFF);
    gpio_write(GPIO_HEATER1, HEATER_OFF);
    gpio_write(GPIO_HEATER2, HEATER_OFF);
    
    m_Dht1.init(GPIO_DHT1);
    m_Dht2.init(GPIO_DHT2);
    
    double temp, hum;

    // do DHT first readings - they will probably fail, so let's get it over with
    m_Dht1.read(temp, hum);
    m_Dht2.read(temp, hum);

    // PID constroller
    m_Pid.init(PID_Kp, PID_Ki, PID_Kd, DIRECT);
    m_Pid.SetSampleTime(60 * 1000);
    m_Pid.Setpoint(PID_DEFAULT_SETPOINT);
    m_Pid.SetOutputLimits(0, 30);
    m_Pid.SetMode(AUTOMATIC);                           // start it
    
    m_Temp1      = INVALID_TEMP;
    m_Hum1       = INVALID_TEMP;
    m_Temp2      = INVALID_TEMP;
    m_Hum2       = INVALID_TEMP;
    
    m_PidEnable  = 0;
    m_PidFan     = 0;
    m_PidHeater1 = 0;
    m_PidHeater2 = 0;
    
    setPidMode(TargetHeatingCoolingStateAuto);
    updatePidStatus();

    countdown(&m_DhtCountdown, DHT_INTERVAL);
    
    // create the so-called task
    system_os_task(task1, TASK1_ID, task0_queue, QUEUE_SIZE);

    system_os_post(TASK1_ID, 0, 0);

    DTXT("main_init_done(): end\n");
}
/*
 * 
 */
extern "C" void ICACHE_FLASH_ATTR user_init(void)
{
    uart_init(BIT_RATE_115200, BIT_RATE_115200);
    os_delay_us(3000000);
    
    DTXT("\n\n");
    DTXT("user_init(): begin\n");
    
    os_printf("Current ROM ....: %d\n",  rboot_get_current_rom());
    os_printf("Package ID .....: %s\n",  m_PkgId);
    os_printf("Package version : %lu\n", m_Version);
    
    esp_start_system_time();                                                    // start our 1 second clock
    
    WIFI_InitializeEx(wifi_list);
    
    system_init_done_cb(main_init_done);
    
    DTXT("user_init(): end\n");
}
