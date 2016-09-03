#/bin/bash
# 
# The MIT License (MIT)
# 
# ESP8266 Non-OS Firmware
# Copyright (c) 2015 Michael Jacobsen (github.com/mikejac)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
#

#
# http://stackoverflow.com/questions/13928550/variables-from-makefile-to-bash
#
function get_make_var()
{
    echo 'unique123:;@echo ${'"$1"'}' | 
      make -f - -f "$2" --no-print-directory unique123
}

#
# extract variables from makefile
#
LD=`get_make_var LD nbproject/Makefile-Release.mk`

OBJECTFILES=`get_make_var OBJECTFILES nbproject/Makefile-Release.mk`
LIB_DIR=`get_make_var LIB_DIR nbproject/Makefile-Release.mk`
LD_SCRIPT2=`get_make_var LD_SCRIPT2 nbproject/Makefile-Release.mk`
ENTRY_SYMBOL=`get_make_var ENTRY_SYMBOL nbproject/Makefile-Release.mk`
LIBS=`get_make_var LIBS nbproject/Makefile-Release.mk`
LIB_GROUP=`get_make_var LIB_GROUP nbproject/Makefile-Release.mk`
CND_ARTIFACT_DIR_Release=`get_make_var CND_ARTIFACT_DIR_Release nbproject/Makefile-Release.mk`

ESPTOOL=`get_make_var ESPTOOL nbproject/Makefile-Release.mk`
ESPTOOL2=`get_make_var ESPTOOL2 nbproject/Makefile-Release.mk`
ESPPORT=`get_make_var ESPPORT nbproject/Makefile-Release.mk`
ESPBAUD=`get_make_var ESPBAUD nbproject/Makefile-Release.mk`

FLASH_SIZE=`get_make_var FLASH_SIZE nbproject/Makefile-Release.mk`

FW_USER_ARGS=`get_make_var FW_USER_ARGS nbproject/Makefile-Release.mk`
FW_SECTS=`get_make_var FW_SECTS nbproject/Makefile-Release.mk`

RBOOT=`get_make_var RBOOT nbproject/Makefile-Release.mk`
BLANK4=`get_make_var BLANK4 nbproject/Makefile-Release.mk`

UPGRADER_PKGID=`get_make_var UPGRADER_PKGID nbproject/Makefile-Release.mk`
UPGRADER_CLIENT=`get_make_var UPGRADER_CLIENT nbproject/Makefile-Release.mk`
UPGRADER_SERVER=`get_make_var UPGRADER_SERVER nbproject/Makefile-Release.mk`
UPGRADER_URL=`get_make_var UPGRADER_URL nbproject/Makefile-Release.mk`

#echo "OBJECTFILES: $OBJECTFILES"
#echo "LIB_DIR: $LIB_DIR"
#echo "LD_SCRIPT2: $LD_SCRIPT2"
#echo "ENTRY_SYMBOL: $ENTRY_SYMBOL"
#echo "CND_ARTIFACT_DIR_Release: $CND_ARTIFACT_DIR_Release"

echo "$LD -o $CND_ARTIFACT_DIR_Release/rom1.elf $OBJECTFILES -Wl,--no-check-sections -L$LIB_DIR -nostdlib -fno-rtti -T$LD_SCRIPT2 -u $ENTRY_SYMBOL -Wl,-static -Wl,--start-group $LIB_GROUP -Wl,--end-group"

# run linker for ROM slot 1 (NetBeans takes care of ROM slot 0)
$LD -o $CND_ARTIFACT_DIR_Release/rom1.elf $OBJECTFILES -Wl,--no-check-sections -L$LIB_DIR -nostdlib -fno-rtti -T$LD_SCRIPT2 -u $ENTRY_SYMBOL -Wl,-static -Wl,--start-group $LIB_GROUP -Wl,--end-group

#
echo Running $ESPTOOL2 ...
$ESPTOOL2 $FW_USER_ARGS $CND_ARTIFACT_DIR_Release/rom1.elf $CND_ARTIFACT_DIR_Release/rom1.bin $FW_SECTS

if [ ! $# == 2 ]; then
	echo Running $ESPTOOL ...
        $ESPTOOL -p $ESPPORT read_mac
	$ESPTOOL -p $ESPPORT write_flash -fs $FLASH_SIZE 0x00000 $RBOOT 0x02000 $CND_ARTIFACT_DIR_Release/rom0.bin 0x82000 $CND_ARTIFACT_DIR_Release/rom1.bin 0xfc000 $BLANK4
#	$ESPTOOL -p $ESPPORT --baud $ESPBAUD write_flash -fs $FLASH_SIZE 0x00000 $RBOOT 0x02000 $CND_ARTIFACT_DIR_Release/rom0.bin 0x82000 $CND_ARTIFACT_DIR_Release/rom1.bin 0xfc000 $BLANK4
elif [[ "$1" == "ota" ]]; then
        echo Running OTA tool ...
	$UPGRADER_CLIENT --ip=$UPGRADER_SERVER update pkgid $UPGRADER_PKGID version $2 server $UPGRADER_URL bin0 $CND_ARTIFACT_DIR_Release/rom0.bin bin1 $CND_ARTIFACT_DIR_Release/rom1.bin
fi

