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

#ifndef _USER_CONFIG_H_
#define _USER_CONFIG_H_

#define CLIENT_SSL_ENABLE

#define DHT_INTERVAL            60

/******************************************************************************************************************
 * MQTT
 *
 */
#define MQTT_BROKER_IP          "192.168.1.82"
#define MQTT_BROKER_PORT        1883
#define MQTT_KEEPALIVE          60
#define MQTT_CLEAN_SESSION      1

#define MQTT_QOS                0

#define FABRIC_ROOT_TOPIC       "fabric"

/******************************************************************************************************************
 * fabric
 *
 */
#define MY_PLATFORM_ID          "heater"

// external nodenames
#define NODENAME_CHRONOS        "e03fe8f6-ad55-455f-9039-2a9fd7d9eec5"
#define NODENAME_UPGRADER       "f330b8cb-e559-4590-bae0-d079b1b5e7e4"

/******************************************************************************************************************
 * PID
 *
 */
#define PID_DEFAULT_SETPOINT    9.0
#define PID_MIN_SETPOINT        5
#define PID_MAX_SETPOINT        25

#define PID_Kp                  2
#define PID_Ki                  5
#define PID_Kd                  1

/******************************************************************************************************************
 * GPIO
 *
 */
// blue LED on ESP-12(E)
#define GPIO_BLUE               2

// relays
#define GPIO_REL1               14
#define GPIO_REL2               12
#define GPIO_REL3               13
#define GPIO_REL4               16

// DHT sensors
#define GPIO_DHT1               5
#define GPIO_DHT2               4

#define GPIO_FAN                GPIO_REL1
#define GPIO_HEATER1            GPIO_REL2
#define GPIO_HEATER2            GPIO_REL3

/******************************************************************************************************************
 * various
 *
 */
#define FAN_ON                  false
#define FAN_OFF                 true
#define HEATER_ON               false
#define HEATER_OFF              true

#define FANTIMEOUT              (3 * 60)    // seconds
#define STAGE_2_TIME            (30 * 60)   // seconds

#define INVALID_TEMP            -100
#define INVALID_HUM             0

#endif
