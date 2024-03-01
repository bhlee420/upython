set(IDF_TARGET esp32s3)

message (STATUS "LEE : MICROPY_PORT_DIR=${MICROPY_PORT_DIR}")

set(SDKCONFIG_DEFAULTS

    ${MICROPY_BOARD_DIR}/sdkconfig.base
    ${MICROPY_PORT_DIR}/boards/sdkconfig.ble
    ${MICROPY_PORT_DIR}/boards/sdkconfig.spiram_sx
    ${MICROPY_PORT_DIR}/boards/sdkconfig.240mhz
    ${MICROPY_BOARD_DIR}/sdkconfig.board
    ${MICROPY_BOARD_DIR}/sdkconfig-8m.partition
)

message (STATUS "mpconfigboard.cmake: PROJECT_DIR=${PROJECT_DIR}")

set(USER_C_MODULES
    ${PROJECT_DIR}/micropython-modules/micropython.cmake
)

list(APPEND EXTRA_COMPONENT_DIRS ${CMAKE_CURRENT_LIST_DIR}/../../../dependencies/esp-tflite-micro/components/esp-tflite-micro)

if(NOT MICROPY_FROZEN_MANIFEST)
    set(MICROPY_FROZEN_MANIFEST ${MICROPY_PORT_DIR}/boards/manifest.py)
endif()
