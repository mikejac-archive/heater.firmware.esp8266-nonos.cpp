# ESP8266 Non-OS Firmware - Heater
## Introduction
### Hardware
The hardware for this project is an ESP-12. It has two DHT21 sensors and three relays connected. One of the DHT21 sensors is located outdoor and the second is located in my workshop. The relays controls two heating elements and a fan in the workshop. A software PID controller regulate the temperature in the workshop by turning the heating elements (and fan) on and off. When to turn them on or off is based on feedback from the indoor DHT21 sensors temperature measurement.

### Application
* The application uses MQTT to communicate with the world. I have an Hardkernel ODROID-C1 running Linux with the [Mosquitto](http://mosquitto.org) MQTT Broker.
* The MQTT topics are *based* on [IBM Fabric for Sensor Network](https://www.ibm.com/developerworks/community/groups/service/html/communityview?communityUuid=46c1a49f-a9fb-4d82-bbd6-66d67f0fdb2c). The structure can at first seem a bit complicated but it works well.
* Data transferred is in JSON format. There is always a "d" object at the top - this should enable the data to be compatible with IBM BlueMix.
* To be able to see the temperatures, humidities and relay status, the application announces some [Apple HomeKit Accessories](https://developer.apple.com/homekit/) (Thermometer, Humidity and Thermostat). This is sent via MQTT to an [HomeKit to MQTT Server](https://github.com/mikejac/homekit.mqtt.golang) (written in 'Go' - not yet on github). Then on an iOS device I can see the data and control the thermostat.
* When the application connects to the MQTT broker it announces all it's accessories. When the application detects that an [HomeKit to MQTT Server](https://github.com/mikejac/homekit.mqtt.golang) goes online, it announces all it's accessories. Then the [HomeKit to MQTT Server](https://github.com/mikejac/homekit.mqtt.golang) will announce this to the Apple HomeKit world - plug'n play :-)

### *Caveats*
* DNS lookup does not yet work. For the time being only an ip-address can be used for connecting to the MQTT broker. Defined in ```user_config.h```
* You must create a header file named ```wifi.h``` with your SSIDs and passwords. Then adjust the ```wifi_list[]``` variable in ```main.cpp``` accordingly.
* There's probably more, but hey, I've spend a lot of time with this so I can't remember it all.

### Other
The way all the HomeKit stuff is constructed is heavily based on the work done by Matthias Hochgatterer in his [HomeControl](https://github.com/brutella/hc) project (written in Go).

## Toolchain
1. I'm using GCC from the esp-open-sdk [https://github.com/pfalcon/esp-open-sdk] project. Will be updated to latest version at some point. My version is currently ```gcc version 4.8.2 (crosstool-NG 1.20.0)```.
2. Using Esptool2 [https://github.com/raburton/esptool2] for creating multiple ROM images. This in order to support Over-The-Air (OTA) updates of the firmware.
3. Using version 1.5.1 of the [Espressif ESP8266 NONOS SDK](https://espressif.com/en/support/download/sdks-demos?keys=&field_type_tid%5B%5D=14). This too needs to be updated.

## Build System
I prefer to use the [NetBeans IDE](https://netbeans.org) for working with C/C++, so this project is created using NetBeans. That means it differs quite alot from the nested make system that Espressif uses for their demo code. I'm running NetBeans on OSX and the toolchain is also running on OSX.

Now then, in order to use the OTA functionality a firmware ROM must be built for two diffrent ROM locations. I'm using the 'main' NetBeans makefile to make one of the ROMs as well as setting up some variables (please, do study [rBoot](https://github.com/raburton/rboot)). Then the ```deploy.sh``` script uses those variables and create the second ROM. ```deploy.sh``` will also install the firmware via USB or OTA. The OTA system is another project (made in Go). That still need a bit of love before I'll publish that :-)

You'll **have to adjust some paths/variables in the makefile to fit your system**. If this can work on Windows I really don't know.

## Get The Files
```
mkdir -p src/github.com/mikejac; cd src/github.com/mikejac
git clone https://github.com/mikejac/blinker.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/bluemix.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/br3ttb.pid.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/button.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/date_time.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/dht.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/esp-open-rtos.gpio.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/misc.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/mqtt.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/paho.mqtt.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/raburton.rboot.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/realtimelogic.json.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/rpcmqtt.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/timer.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/upgrader.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/wifi.esp8266-nonos.cpp.git
git clone https://github.com/mikejac/heater.firmware.esp8266-nonos.cpp.git
```
## External Libraries
* [Real Time Logic JSON](https://realtimelogic.com/ba/doc/en/C/reference/html/md_en_C_md_JSON.html)
* [rBoot](https://github.com/raburton/rboot)
* [Paho Eclipse Embedded MQTT C/C++ Client Libraries](https://eclipse.org/paho/clients/c/embedded/)
* [esp-open-rtos](https://github.com/SuperHouse/esp-open-rtos) for the GPIO functions
* [Arduino PID Library](https://github.com/br3ttb/Arduino-PID-Library)

## Related Projects
* [HomeKit to MQTT Server](https://github.com/mikejac/homekit.mqtt.golang)
* [ESP8266 OTA Upgrader](https://github.com/mikejac/esp8266upgrader.golang)