# Include MicroPython ESP32 component.

get_filename_component(CURRENT_DIR "." ABSOLUTE)

message(STATUS "microlite/main/cmake: CURRENT_DIR=${CURRENT_DIR}")

#get_filename_component(MICROPY_DIR "../../../../micropython" ABSOLUTE)
#get_filename_component(MICROPY_DIR "../../../../../dependencies/micropython" ABSOLUTE)

if (${CURRENT_DIR} STREQUAL "/home/runner/work/upython/upython/dependencies/micropython/ports/esp32/build-MICROLITE_SPIRAM_CAM") 
  message (STATUS "first case : ${CURRENT_DIR}")
  get_filename_component(MICROPY_DIR "../../../../../dependencies/micropython" ABSOLUTE)
  
else()
  message (STATUS "second case : ${CURRENT_DIR}")
  get_filename_component(MICROPY_DIR "../../../../dependencies/micropython" ABSOLUTE)
endif()

message (STATUS "microlite/main/cmake: MICROPY_DIR=${MICROPY_DIR}")
#set(PROJECT_DIR ${MICROPY_DIR}/dependencies/ports/esp32) 
set(PROJECT_DIR ${MICROPY_DIR}/ports/esp32) 

include(${MICROPY_DIR}/ports/esp32/main_esp32s3/CMakeLists.txt)
