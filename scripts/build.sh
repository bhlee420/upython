#!bin/bash

MAKEOPTS=

# if which nproc > /dev/null; then
#     MAKEOPTS="-j$(nproc)"
# else
#     MAKEOPTS="-j$(sysctl -n hw.ncpu)"
# fi

function prepare_dependencies {

    rm -rf dependencies

    mkdir dependencies

    cd dependencies

    ULAB_VERSION=6.0.12
    MICRO_PYTHON_VERSION=v1.21.0
    #MICRO_PYTHON_VERSION=master
    MICROPYTHON_ESP32_CAMERA_DRIVER=master
    ESP32_TFLITE_VERSION=v1.0.0

    # ulab
    git clone --depth 1 https://github.com/v923z/micropython-ulab --branch $ULAB_VERSION

    # micropython
    git clone --depth 1 https://github.com/micropython/micropython --branch $MICRO_PYTHON_VERSION

    # esp32 - https://github.com/mocleiri/tensorflow-micropython-examples.git
    git clone --depth 1 https://github.com/espressif/esp-tflite-micro --branch $ESP32_TFLITE_VERSION

    # esp32-camera actually comes through esp package manager but we need it for the headers
    git clone --depth 1 https://github.com/espressif/esp32-camera --branch master

    # micropypthon camera driver
    git clone --depth 1 https://github.com/lemariva/micropython-camera-driver --branch $MICROPYTHON_ESP32_CAMERA_DRIVER

    # other platforms - get tflite-micro and run create_tflm_tree.py
    # refer to 
    git clone --depth 1 https://github.com/tensorflow/tflite-micro

    # build : 
    # $ cd dependencies/micropython/ports/esp32
    # $ 
    # cd micropython
    # git submodule init
    # git submodule update --recursive

    # cd ../..
    cd ..
}

function build_esp32 {
    BOARD=$1
    if test -z "$BOARD"; then
    	echo "USAGE: build_esp32 <microlite board name>"
	    exit 1;
    fi
    pwd
    python --version
    which python
    # xargs --show-limits
    source esp-idf/export.sh
    cd dependencies/micropython
    make -C mpy-cross V=1 clean all
    cd ports/esp32
#    make submodules
    make USER_C_MODULES=/home/runner/work/upython/upython/micropython-modules/micropython.cmake submodules
   
    echo "LEE PROMPT : cd ../../boards/esp32/${BOARD}"
    cd ../../../../boards/esp32/${BOARD}

    echo "LEE PROMPT : BUILDING ${BOARD}.."
    idf.py add-dependency "espressif/mdns^1.2.4"
    idf.py add-dependency "esp_tinyusb^1.0.0"
    idf.py add-dependency "espressif/esp32-camera"
    rm -rf builds
    PWd=$(pwd)
    echo "Lee dir :${PWd} !"
     
    
    echo "make ${MAKEOPTS} V=1 BOARD_DIR=$(pwd)/../../../../boards/esp32/${BOARD} BOARD=${BOARD} FROZEN_MANIFEST=$PWD/boards/manifest.py"

    echo "make${MAKEOPTS} V=1 BOARD_DIR=$(pwd) BOARD=${BOARD} USER_C_MODULES=../../../micropython-modules/micropython-camera-driver/micropython.cmake"

    


    ls

    
    #idf.py clean build
    
    idf.py USER_C_MODULES=/home/runner/work/upython/upython/micropython-modules/micropython.cmake build

    #idf.py USER_C_MODULES=../../../micropython-modules/micropython-camera-driver/micropython.cmake 
    #make -C /home/runner/work/upython/upython/dependencies/micropython/ports/esp32   BOARD_DIR=$(pwd) BOARD=${BOARD} USER_C_MODULES=../../../micropython-modules/micropython-camera-driver/micropython.cmake
    
    #make ${MAKEOPTS} V=1 \
        #-d \
       # BOARD_DIR=$(pwd) \
       # BOARD=${BOARD} 

    
    #idf.py -B ../../../dependencies/micropython/ports/esp32/build-${BOARD} build

    cd ../../../
    #PWD=$(pwd)
    #echo "make ${MAKEOPTS} V=1 BOARD_DIR=$(pwd)/../../../../boards/esp32/${BOARD} BOARD=${BOARD} FROZEN_MANIFEST=$PWD/boards/manifest.py"

    #make clean all
    #make ${MAKEOPTS} V=1 \
        #BOARD_DIR= $(pwd)/../../../../boards/esp32/${BOARD} \
        #BOARD=${BOARD} 

    # creates the build into dependencies/micropython/ports/esp32/build-MICROLITE
    # find build-${BOARD} -ls
    #cd ../../../
}



