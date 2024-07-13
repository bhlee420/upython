#!/bin/bash

MAKEIMG_PATH=$1
BASE_DIR=$2
BUILD_DIR=$3

if test -z "$BASE_DIR"; then
	echo "USAGE: <Absolute Path to micropython/ports/esp32> <name of build dir>"
	exit 1
fi

if test -z "$BUILD_DIR"; then
	echo "USAGE: <Absolute Path to micropython/ports/esp32> <name of build dir>"
	exit 1
fi

python3 ${MAKEIMG_PATH}/makeimg.py \
${BASE_DIR}/${BUILD_DIR}/sdkconfig \
${BASE_DIR}/${BUILD_DIR}/bootloader/bootloader.bin \
${BASE_DIR}/${BUILD_DIR}/partition_table/partition-table.bin \
${BASE_DIR}/${BUILD_DIR}/micropython.bin \
${BASE_DIR}/${BUILD_DIR}/firmware.bin \
${BASE_DIR}/${BUILD_DIR}/micropython.uf2
