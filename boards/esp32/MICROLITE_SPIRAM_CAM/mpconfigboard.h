//#define MICROPY_HW_BOARD_NAME "ESP32-cam module (microlite)"
#define MICROPY_HW_BOARD_NAME "ESP32S3-cam module (microlite-spiram)"
#define MICROPY_HW_MCU_NAME "ESP32S3"
 
#define MICROPY_PY_BLUETOOTH                (0)
#define MICROPY_PY_MACHINE_DAC              (0)
#define MODULE_CAMERA_ENABLED               (1)


#define MICROPY_HW_I2C0_SCL                 (9)
#define MICROPY_HW_I2C0_SDA                 (8)

// The offset only has an effect if a board has psram
// it allows the start of the range allocated to 
#define MICROPY_ALLOCATE_HEAP_USING_MALLOC (1)
#define MICROPY_HEAP_SIZE_REDUCTION (512 * 1024)
