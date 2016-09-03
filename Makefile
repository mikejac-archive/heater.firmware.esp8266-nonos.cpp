#
#  There exist several targets which are by default empty and which can be 
#  used for execution of your targets. These targets are usually executed 
#  before and after some main targets. They are: 
#
#     .build-pre:              called before 'build' target
#     .build-post:             called after 'build' target
#     .clean-pre:              called before 'clean' target
#     .clean-post:             called after 'clean' target
#     .clobber-pre:            called before 'clobber' target
#     .clobber-post:           called after 'clobber' target
#     .all-pre:                called before 'all' target
#     .all-post:               called after 'all' target
#     .help-pre:               called before 'help' target
#     .help-post:              called after 'help' target
#
#  Targets beginning with '.' are not intended to be called on their own.
#
#  Main targets can be executed directly, and they are:
#  
#     build                    build a specific configuration
#     clean                    remove built files from a configuration
#     clobber                  remove all built files
#     all                      build all configurations
#     help                     print help mesage
#  
#  Targets .build-impl, .clean-impl, .clobber-impl, .all-impl, and
#  .help-impl are implemented in nbproject/makefile-impl.mk.
#
#  Available make variables:
#
#     CND_BASEDIR                base directory for relative paths
#     CND_DISTDIR                default top distribution directory (build artifacts)
#     CND_BUILDDIR               default top build directory (object files, ...)
#     CONF                       name of current configuration
#     CND_PLATFORM_${CONF}       platform name (current configuration)
#     CND_ARTIFACT_DIR_${CONF}   directory of build artifact (current configuration)
#     CND_ARTIFACT_NAME_${CONF}  name of build artifact (current configuration)
#     CND_ARTIFACT_PATH_${CONF}  path to build artifact (current configuration)
#     CND_PACKAGE_DIR_${CONF}    directory of package (current configuration)
#     CND_PACKAGE_NAME_${CONF}   name of package (current configuration)
#     CND_PACKAGE_PATH_${CONF}   path to package (current configuration)
#
# NOCDDL


# Environment 
MKDIR=mkdir
CP=cp
CCADMIN=CCadmin

ifeq ($(OS),Windows_NT)
    XTENSA_BASE = 
    ROOT        = 
    ESPTOOL     = 
    ESPPORT     = 
    ESPTOOL2    = 
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        XTENSA_BASE = /opt/esp-open-sdk/xtensa-lx106-elf
        ROOT        = /opt/esp-open-sdk
        ESPTOOL     = /opt/esp-open-sdk/xtensa-lx106-elf/bin/esptool.py
        ESPPORT     = /dev/ttyUSB0
	ESPTOOL2    = /opt/esptool2/esptool2
    endif
    ifeq ($(UNAME_S),Darwin)
        XTENSA_BASE = /Volumes/case-sensitive-espressif/esp-open-sdk/xtensa-lx106-elf
        ROOT        = /Volumes/case-sensitive-espressif/esp-open-sdk
        ESPTOOL     = /Volumes/case-sensitive-espressif/esp-open-sdk/xtensa-lx106-elf/bin/esptool.py
        ESPPORT     = /dev/tty.SLAB_USBtoUART
	ESPTOOL2    = /Volumes/case-sensitive-espressif/esptool2/esptool2
    endif
endif

FLASH_SIZE     = 8m

XTENSA_BIN     = ${XTENSA_BASE}/bin
SIZE           = ${XTENSA_BIN}/xtensa-lx106-elf-size

LD             = ${XTENSA_BIN}/xtensa-lx106-elf-g++

RBOOT          = ../raburton.rboot.esp8266-nonos.cpp/firmware/rboot.bin
BLANK4         = ../raburton.rboot.esp8266-nonos.cpp/blank4.bin
LD_SCRIPT1     = ../raburton.rboot.esp8266-nonos.cpp/rom0.ld
LD_SCRIPT2     = ../raburton.rboot.esp8266-nonos.cpp/rom1.ld
MAP_FILE       = ${CND_ARTIFACT_PATH_${CONF}}.map
ENTRY_SYMBOL   = call_user_start
INC_DIR        = ${ROOT}/sdk/include
LIB_DIR        = ${ROOT}/sdk/lib
LIB_GROUP      = ${XTENSA_BASE}/xtensa-lx106-elf/sysroot/usr/lib/libhal.a ${XTENSA_BASE}/lib/gcc/xtensa-lx106-elf/4.8.2/libgcc.a ${XTENSA_BASE}/xtensa-lx106-elf/sysroot/lib/libc.a -lmesh -lpp -lssl -lwpa2 -lcrypto -llwip -lnet80211 -lpwm -lupgrade -lmain -lphy -lwpa

# esptool defaults
#ESPBAUD        = 115200
ESPBAUD        = 230400

FW_SECTS       = .text .data .rodata
FW_USER_ARGS   = -quiet -bin -boot2

UPGRADER_PKGID  = "WSCT"
UPGRADER_CLIENT = "../../../../../Go/bin/client.esp8266upgrader.golang"
UPGRADER_SERVER	= "192.168.1.82"
UPGRADER_URL	= "192.168.1.82"

# build
build: .build-post

.build-pre:
# Add your pre 'build' code here...

.build-post: .build-impl
# Add your post 'build' code here...
	${ESPTOOL2} ${FW_USER_ARGS} ${CND_ARTIFACT_DIR_${CONF}}/rom0.elf ${CND_ARTIFACT_DIR_${CONF}}/rom0.bin ${FW_SECTS}


# clean
clean: .clean-post

.clean-pre:
# Add your pre 'clean' code here...

.clean-post: .clean-impl
# Add your post 'clean' code here...


# clobber
clobber: .clobber-post

.clobber-pre:
# Add your pre 'clobber' code here...

.clobber-post: .clobber-impl
# Add your post 'clobber' code here...


# all
all: .all-post

.all-pre:
# Add your pre 'all' code here...

.all-post: .all-impl
# Add your post 'all' code here...


# build tests
build-tests: .build-tests-post

.build-tests-pre:
# Add your pre 'build-tests' code here...

.build-tests-post: .build-tests-impl
# Add your post 'build-tests' code here...


# run tests
test: .test-post

.test-pre: build-tests
# Add your pre 'test' code here...

.test-post: .test-impl
# Add your post 'test' code here...


# help
help: .help-post

.help-pre:
# Add your pre 'help' code here...

.help-post: .help-impl
# Add your post 'help' code here...



# include project implementation makefile
include nbproject/Makefile-impl.mk

# include project make variables
include nbproject/Makefile-variables.mk
