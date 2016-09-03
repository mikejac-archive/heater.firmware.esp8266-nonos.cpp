#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=xtensa-lx106-elf-gcc
CCC=xtensa-lx106-elf-g++
CXX=xtensa-lx106-elf-g++
FC=gfortran
AS=xtensa-lx106-elf-as

# Macros
CND_PLATFORM=GNU_ESP_Open_SDK_NONOS-MacOSX
CND_DLIB_EXT=dylib
CND_CONF=Debug
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/_ext/4be9d9a1/blinker.o \
	${OBJECTDIR}/_ext/9541081a/bluemix.o \
	${OBJECTDIR}/_ext/eaa889f7/PID_v1.o \
	${OBJECTDIR}/_ext/bf515088/button.o \
	${OBJECTDIR}/_ext/966b41d6/system_time.o \
	${OBJECTDIR}/_ext/85b97dc8/dht22.o \
	${OBJECTDIR}/_ext/2519c309/esp_iomux.o \
	${OBJECTDIR}/_ext/af9ca382/hexdump.o \
	${OBJECTDIR}/_ext/af9ca382/uart.o \
	${OBJECTDIR}/_ext/a456a3ba/mqtt_client.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTConnectClient.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTConnectServer.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTDeserializePublish.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTFormat.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTPacket.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTSerializePublish.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTSubscribeClient.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTSubscribeServer.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTUnsubscribeClient.o \
	${OBJECTDIR}/_ext/c1038f1e/MQTTUnsubscribeServer.o \
	${OBJECTDIR}/_ext/6706c22e/rboot-api.o \
	${OBJECTDIR}/_ext/6706c22e/rboot-bigflash.o \
	${OBJECTDIR}/_ext/fde774af/rboot-stage2a.o \
	${OBJECTDIR}/_ext/fde774af/rboot.o \
	${OBJECTDIR}/_ext/fde774af/testload1.o \
	${OBJECTDIR}/_ext/fde774af/testload2.o \
	${OBJECTDIR}/_ext/9c585b9/AllocatorIntf.o \
	${OBJECTDIR}/_ext/9c585b9/BaAtoi.o \
	${OBJECTDIR}/_ext/9c585b9/BufPrint.o \
	${OBJECTDIR}/_ext/9c585b9/JDecoder.o \
	${OBJECTDIR}/_ext/9c585b9/JEncoder.o \
	${OBJECTDIR}/_ext/9c585b9/JParser.o \
	${OBJECTDIR}/_ext/9c585b9/JVal.o \
	${OBJECTDIR}/_ext/9c585b9/atof.o \
	${OBJECTDIR}/_ext/b4aba721/mqtt_connector.o \
	${OBJECTDIR}/_ext/b4aba721/mqtt_options.o \
	${OBJECTDIR}/_ext/b4aba721/service_device.o \
	${OBJECTDIR}/_ext/b4aba721/svc_accessory.o \
	${OBJECTDIR}/_ext/b4aba721/svc_characteristics.o \
	${OBJECTDIR}/_ext/b4aba721/svc_container.o \
	${OBJECTDIR}/_ext/b4aba721/svc_services.o \
	${OBJECTDIR}/_ext/b4aba721/topics.o \
	${OBJECTDIR}/_ext/7a785d1d/timer.o \
	${OBJECTDIR}/_ext/3064526c/upgrader.o \
	${OBJECTDIR}/_ext/ff9c556b/wifi.o \
	${OBJECTDIR}/main.o


# C Compiler Flags
CFLAGS=-Os -Wall -Werror -Wpointer-arith -Wundef -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -std=gnu99 -D__ets__

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libheater.firmware.esp8266-nonos.cpp.a

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libheater.firmware.esp8266-nonos.cpp.a: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libheater.firmware.esp8266-nonos.cpp.a
	${AR} -rv ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libheater.firmware.esp8266-nonos.cpp.a ${OBJECTFILES} 
	$(RANLIB) ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libheater.firmware.esp8266-nonos.cpp.a

${OBJECTDIR}/_ext/4be9d9a1/blinker.o: ../blinker.esp8266-nonos.cpp/blinker.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/4be9d9a1
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/4be9d9a1/blinker.o ../blinker.esp8266-nonos.cpp/blinker.c

${OBJECTDIR}/_ext/9541081a/bluemix.o: ../bluemix.esp8266-nonos.cpp/bluemix.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/9541081a
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/9541081a/bluemix.o ../bluemix.esp8266-nonos.cpp/bluemix.c

${OBJECTDIR}/_ext/eaa889f7/PID_v1.o: ../br3ttb.pid.esp8266-nonos.cpp/Arduino-PID-Library/PID_v1.cpp 
	${MKDIR} -p ${OBJECTDIR}/_ext/eaa889f7
	${RM} "$@.d"
	$(COMPILE.cc) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/eaa889f7/PID_v1.o ../br3ttb.pid.esp8266-nonos.cpp/Arduino-PID-Library/PID_v1.cpp

${OBJECTDIR}/_ext/bf515088/button.o: ../button.esp8266-nonos.cpp/button.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/bf515088
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/bf515088/button.o ../button.esp8266-nonos.cpp/button.c

${OBJECTDIR}/_ext/966b41d6/system_time.o: ../date_time.esp8266-nonos.cpp/system_time.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/966b41d6
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/966b41d6/system_time.o ../date_time.esp8266-nonos.cpp/system_time.c

${OBJECTDIR}/_ext/85b97dc8/dht22.o: ../dht.esp8266-nonos.cpp/dht22.cpp 
	${MKDIR} -p ${OBJECTDIR}/_ext/85b97dc8
	${RM} "$@.d"
	$(COMPILE.cc) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/85b97dc8/dht22.o ../dht.esp8266-nonos.cpp/dht22.cpp

${OBJECTDIR}/_ext/2519c309/esp_iomux.o: ../esp-open-rtos.gpio.esp8266-nonos.cpp/gpio/esp_iomux.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/2519c309
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/2519c309/esp_iomux.o ../esp-open-rtos.gpio.esp8266-nonos.cpp/gpio/esp_iomux.c

${OBJECTDIR}/_ext/af9ca382/hexdump.o: ../misc.esp8266-nonos.cpp/hexdump.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/af9ca382
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/af9ca382/hexdump.o ../misc.esp8266-nonos.cpp/hexdump.c

${OBJECTDIR}/_ext/af9ca382/uart.o: ../misc.esp8266-nonos.cpp/uart.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/af9ca382
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/af9ca382/uart.o ../misc.esp8266-nonos.cpp/uart.c

${OBJECTDIR}/_ext/a456a3ba/mqtt_client.o: ../mqtt.esp8266-nonos.cpp/mqtt_client.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/a456a3ba
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/a456a3ba/mqtt_client.o ../mqtt.esp8266-nonos.cpp/mqtt_client.c

${OBJECTDIR}/_ext/c1038f1e/MQTTConnectClient.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTConnectClient.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTConnectClient.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTConnectClient.c

${OBJECTDIR}/_ext/c1038f1e/MQTTConnectServer.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTConnectServer.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTConnectServer.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTConnectServer.c

${OBJECTDIR}/_ext/c1038f1e/MQTTDeserializePublish.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTDeserializePublish.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTDeserializePublish.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTDeserializePublish.c

${OBJECTDIR}/_ext/c1038f1e/MQTTFormat.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTFormat.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTFormat.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTFormat.c

${OBJECTDIR}/_ext/c1038f1e/MQTTPacket.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTPacket.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTPacket.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTPacket.c

${OBJECTDIR}/_ext/c1038f1e/MQTTSerializePublish.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTSerializePublish.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTSerializePublish.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTSerializePublish.c

${OBJECTDIR}/_ext/c1038f1e/MQTTSubscribeClient.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTSubscribeClient.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTSubscribeClient.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTSubscribeClient.c

${OBJECTDIR}/_ext/c1038f1e/MQTTSubscribeServer.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTSubscribeServer.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTSubscribeServer.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTSubscribeServer.c

${OBJECTDIR}/_ext/c1038f1e/MQTTUnsubscribeClient.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTUnsubscribeClient.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTUnsubscribeClient.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTUnsubscribeClient.c

${OBJECTDIR}/_ext/c1038f1e/MQTTUnsubscribeServer.o: ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTUnsubscribeServer.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/c1038f1e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/c1038f1e/MQTTUnsubscribeServer.o ../paho.mqtt.esp8266-nonos.cpp/MQTTPacket/src/MQTTUnsubscribeServer.c

${OBJECTDIR}/_ext/6706c22e/rboot-api.o: ../raburton.rboot.esp8266-nonos.cpp/appcode/rboot-api.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/6706c22e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/6706c22e/rboot-api.o ../raburton.rboot.esp8266-nonos.cpp/appcode/rboot-api.c

${OBJECTDIR}/_ext/6706c22e/rboot-bigflash.o: ../raburton.rboot.esp8266-nonos.cpp/appcode/rboot-bigflash.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/6706c22e
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/6706c22e/rboot-bigflash.o ../raburton.rboot.esp8266-nonos.cpp/appcode/rboot-bigflash.c

${OBJECTDIR}/_ext/fde774af/rboot-stage2a.o: ../raburton.rboot.esp8266-nonos.cpp/rboot-stage2a.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/fde774af
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/fde774af/rboot-stage2a.o ../raburton.rboot.esp8266-nonos.cpp/rboot-stage2a.c

${OBJECTDIR}/_ext/fde774af/rboot.o: ../raburton.rboot.esp8266-nonos.cpp/rboot.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/fde774af
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/fde774af/rboot.o ../raburton.rboot.esp8266-nonos.cpp/rboot.c

${OBJECTDIR}/_ext/fde774af/testload1.o: ../raburton.rboot.esp8266-nonos.cpp/testload1.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/fde774af
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/fde774af/testload1.o ../raburton.rboot.esp8266-nonos.cpp/testload1.c

${OBJECTDIR}/_ext/fde774af/testload2.o: ../raburton.rboot.esp8266-nonos.cpp/testload2.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/fde774af
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/fde774af/testload2.o ../raburton.rboot.esp8266-nonos.cpp/testload2.c

${OBJECTDIR}/_ext/9c585b9/AllocatorIntf.o: ../realtimelogic.json.esp8266-nonos.cpp/AllocatorIntf.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/9c585b9
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/9c585b9/AllocatorIntf.o ../realtimelogic.json.esp8266-nonos.cpp/AllocatorIntf.c

${OBJECTDIR}/_ext/9c585b9/BaAtoi.o: ../realtimelogic.json.esp8266-nonos.cpp/BaAtoi.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/9c585b9
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/9c585b9/BaAtoi.o ../realtimelogic.json.esp8266-nonos.cpp/BaAtoi.c

${OBJECTDIR}/_ext/9c585b9/BufPrint.o: ../realtimelogic.json.esp8266-nonos.cpp/BufPrint.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/9c585b9
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/9c585b9/BufPrint.o ../realtimelogic.json.esp8266-nonos.cpp/BufPrint.c

${OBJECTDIR}/_ext/9c585b9/JDecoder.o: ../realtimelogic.json.esp8266-nonos.cpp/JDecoder.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/9c585b9
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/9c585b9/JDecoder.o ../realtimelogic.json.esp8266-nonos.cpp/JDecoder.c

${OBJECTDIR}/_ext/9c585b9/JEncoder.o: ../realtimelogic.json.esp8266-nonos.cpp/JEncoder.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/9c585b9
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/9c585b9/JEncoder.o ../realtimelogic.json.esp8266-nonos.cpp/JEncoder.c

${OBJECTDIR}/_ext/9c585b9/JParser.o: ../realtimelogic.json.esp8266-nonos.cpp/JParser.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/9c585b9
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/9c585b9/JParser.o ../realtimelogic.json.esp8266-nonos.cpp/JParser.c

${OBJECTDIR}/_ext/9c585b9/JVal.o: ../realtimelogic.json.esp8266-nonos.cpp/JVal.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/9c585b9
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/9c585b9/JVal.o ../realtimelogic.json.esp8266-nonos.cpp/JVal.c

${OBJECTDIR}/_ext/9c585b9/atof.o: ../realtimelogic.json.esp8266-nonos.cpp/atof.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/9c585b9
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/9c585b9/atof.o ../realtimelogic.json.esp8266-nonos.cpp/atof.c

${OBJECTDIR}/_ext/b4aba721/mqtt_connector.o: ../rpcmqtt.esp8266-nonos.cpp/mqtt_connector.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/b4aba721
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/b4aba721/mqtt_connector.o ../rpcmqtt.esp8266-nonos.cpp/mqtt_connector.c

${OBJECTDIR}/_ext/b4aba721/mqtt_options.o: ../rpcmqtt.esp8266-nonos.cpp/mqtt_options.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/b4aba721
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/b4aba721/mqtt_options.o ../rpcmqtt.esp8266-nonos.cpp/mqtt_options.c

${OBJECTDIR}/_ext/b4aba721/service_device.o: ../rpcmqtt.esp8266-nonos.cpp/service_device.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/b4aba721
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/b4aba721/service_device.o ../rpcmqtt.esp8266-nonos.cpp/service_device.c

${OBJECTDIR}/_ext/b4aba721/svc_accessory.o: ../rpcmqtt.esp8266-nonos.cpp/svc_accessory.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/b4aba721
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/b4aba721/svc_accessory.o ../rpcmqtt.esp8266-nonos.cpp/svc_accessory.c

${OBJECTDIR}/_ext/b4aba721/svc_characteristics.o: ../rpcmqtt.esp8266-nonos.cpp/svc_characteristics.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/b4aba721
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/b4aba721/svc_characteristics.o ../rpcmqtt.esp8266-nonos.cpp/svc_characteristics.c

${OBJECTDIR}/_ext/b4aba721/svc_container.o: ../rpcmqtt.esp8266-nonos.cpp/svc_container.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/b4aba721
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/b4aba721/svc_container.o ../rpcmqtt.esp8266-nonos.cpp/svc_container.c

${OBJECTDIR}/_ext/b4aba721/svc_services.o: ../rpcmqtt.esp8266-nonos.cpp/svc_services.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/b4aba721
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/b4aba721/svc_services.o ../rpcmqtt.esp8266-nonos.cpp/svc_services.c

${OBJECTDIR}/_ext/b4aba721/topics.o: ../rpcmqtt.esp8266-nonos.cpp/topics.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/b4aba721
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/b4aba721/topics.o ../rpcmqtt.esp8266-nonos.cpp/topics.c

${OBJECTDIR}/_ext/7a785d1d/timer.o: ../timer.esp8266-nonos.cpp/timer.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/7a785d1d
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/7a785d1d/timer.o ../timer.esp8266-nonos.cpp/timer.c

${OBJECTDIR}/_ext/3064526c/upgrader.o: ../upgrader.esp8266-nonos.cpp/upgrader.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/3064526c
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/3064526c/upgrader.o ../upgrader.esp8266-nonos.cpp/upgrader.c

${OBJECTDIR}/_ext/ff9c556b/wifi.o: ../wifi.esp8266-nonos.cpp/wifi.c 
	${MKDIR} -p ${OBJECTDIR}/_ext/ff9c556b
	${RM} "$@.d"
	$(COMPILE.c) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/_ext/ff9c556b/wifi.o ../wifi.esp8266-nonos.cpp/wifi.c

${OBJECTDIR}/main.o: main.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main.o main.cpp

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libheater.firmware.esp8266-nonos.cpp.a

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
