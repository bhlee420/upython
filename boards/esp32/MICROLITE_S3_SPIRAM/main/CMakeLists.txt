# Include MicroPython ESP32 component.

get_filename_component(CURRENT_DIR "." ABSOLUTE)

message(STATUS "microlite/main/cmake: CURRENT_DIR=${CURRENT_DIR}")

if (${CURRENT_DIR} EQUAL "/home/runner/work/upython/upython/dependencies/micropython/ports/esp32/build-MICROLITE_S3_SPIRAM") 
  message (STATUS "first case : ${CURRENT_DIR}")
  get_filename_component(MICROPY_DIR "../../../../../dependencies/micropython" ABSOLUTE)
  
else()
  message (STATUS "second case : ${CURRENT_DIR}")
  get_filename_component(MICROPY_DIR "../../../../dependencies/micropython" ABSOLUTE)
endif()

message (STATUS "microlite/main/cmake: MICROPY_DIR=${MICROPY_DIR}")

set(PROJECT_DIR ${MICROPY_DIR}/ports/esp32)
include(${PROJECT_DIR}/main_esp32s3/CMakeLists.txt)
