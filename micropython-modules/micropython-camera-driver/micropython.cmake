# we have only integrated with esp32-camera so require
if (CAMERA_TYPE STREQUAL "esp32")


# Create an INTERFACE library for our C module.
add_library(usermod_esp32camera INTERFACE)

# Add our source files to the lib
target_sources(usermod_esp32camera INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/modcamera.c
)

#get_filename_component(ESP32_CAMERA_DIR ${PROJECT_DIR}/dependencies/esp32-camera ABSOLUTE)
get_filename_component(ESP32_CAMERA_DIR ${PROJECT_DIR}/../../../esp32-camera ABSOLUTE)

message (STATUS  " LEE BO Display : CMAKE_CURRENT_LIST_DIR = ${CMAKE_CURRENT_LIST_DIR}")
message (STATUS  " LEE BO Display : PROJECT_DIR = ${PROJECT_DIR}")
message (STATUS  " LEE BO Display : ESP32_CAMERA_DIR = ${ESP32_CAMERA_DIR}")


list(APPEND COMPONENTS esp32-camera) 

# message (STATUS "mpconfigboard.cmake: PROJECT_DIR=${PROJECT_DIR}")
# echo " ***********************LEE********************************* "



# Add the current directory as an include directory.
target_include_directories(usermod_esp32camera INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}
    ${ESP32_CAMERA_DIR}/driver/include
    ${ESP32_CAMERA_DIR}/driver/private_include
    ${ESP32_CAMERA_DIR}/conversions/include
    ${ESP32_CAMERA_DIR}/conversions/private_include
    ${ESP32_CAMERA_DIR}/sensors/private_include
)

target_compile_definitions(usermod_esp32camera INTERFACE)

# Link our INTERFACE library to the usermod target.
target_link_libraries(usermod INTERFACE usermod_esp32camera)

endif()
