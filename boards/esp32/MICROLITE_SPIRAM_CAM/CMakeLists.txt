# Top-level cmake file for building MicroPython on ESP32.
# Nothing in here needs to be customised, it will work for any board.

cmake_minimum_required(VERSION 3.12)

# Set the location of MicroPython, the esp32 port, and the board directory.
#get_filename_component(PROJECT_DIR "../../.." ABSOLUTE)
set(PROJECT_DIR /home/runner/work/upython/upython)
set(MICROPY_PORT_DIR ${PROJECT_DIR}/dependencies/micropython/ports/esp32)
set(MICROPY_BOARD_DIR ${PROJECT_DIR}/boards/esp32/MICROLITE_SPIRAM_CAM)
#get_filename_component(MICROPY_BOARD_DIR "." ABSOLUTE)

# set(EXTRA_COMPONENT_DIRS ../../../tflm_esp_kernels/components/esp32-camera)



# set(EXTRA_COMPONENT_DIRS ${PROJECT_DIR}/micropython-modules/micropython-camera-driver)



list(APPEND EXTRA_COMPONENT_DIRS ${PROJECT_DIR}/micropython-modules/microlite)
list(APPEND EXTRA_COMPONENT_DIRS ${PROJECT_DIR}/micropython-modules/audio_frontend)

message (STATUS "EXTRA_COMPONENT_DIRS=${EXTRA_COMPONENT_DIRS}")
message (STATUS "PROJECT_DIR=${PROJECT_DIR}")
message (STATUS "MICROPY_PORT_DIR=${MICROPY_PORT_DIR}")
message (STATUS "MICROPY_BOARD_DIR=${MICROPY_BOARD_DIR}")

# Define the output sdkconfig so it goes in the build directory.
set(SDKCONFIG ${CMAKE_BINARY_DIR}/sdkconfig)

# Include board config; this is expected to set SDKCONFIG_DEFAULTS (among other options).
include(${MICROPY_BOARD_DIR}/mpconfigboard.cmake)

# Concatenate all sdkconfig files into a combined one for the IDF to use.
file(WRITE ${CMAKE_BINARY_DIR}/sdkconfig.combined.in "")
foreach(SDKCONFIG_DEFAULT ${SDKCONFIG_DEFAULTS})
    file(READ ${SDKCONFIG_DEFAULT} CONTENTS)
    file(APPEND ${CMAKE_BINARY_DIR}/sdkconfig.combined.in "${CONTENTS}")
endforeach()
configure_file(${CMAKE_BINARY_DIR}/sdkconfig.combined.in ${CMAKE_BINARY_DIR}/sdkconfig.combined COPYONLY)
set(SDKCONFIG_DEFAULTS ${CMAKE_BINARY_DIR}/sdkconfig.combined)

# Include main IDF cmake file and define the project.
include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(micropython)
