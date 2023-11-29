
add_library(soc_lib INTERFACE)

set(PLATFORM_DIR ${ASR_SDK_DIR}/platform)
link_directories(${ASR_SDK_DIR}/drivers/crypto/lib)

file( GLOB SRC_peripheral_LIST "${ASR_SDK_DIR}/drivers/peripheral/src/*.c" )    

target_include_directories(soc_lib INTERFACE 
    ${PLATFORM_DIR}/CMSIS
    ${PLATFORM_DIR}/common
    ${PLATFORM_DIR}/system
    ${ASR_SDK_DIR}/drivers/crypto/inc
    ${ASR_SDK_DIR}/drivers/peripheral/inc
)

target_sources(soc_lib INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/_std_libc.c
    ${PLATFORM_DIR}/system/printf-stdarg.c
    ${PLATFORM_DIR}/system/system_cm4.c
    ${PLATFORM_DIR}/system/startup_cm4.S
    ${SRC_peripheral_LIST}
)
