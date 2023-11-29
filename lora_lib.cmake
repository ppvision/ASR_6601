add_library(lora INTERFACE)

set(LORA_DIR ${ASR_SDK_DIR}/lora)


file( GLOB SRC_SYS_LIST "${LORA_DIR}/system/*.c" )    
file( GLOB SRC_CRY_LIST "${LORA_DIR}/system/crypto/*.c" )    
file( GLOB SRC_SX126X_LIST "${LORA_DIR}/radio/sx126x/*.c" )    
file( GLOB SRC_DRV_LIST "${LORA_DIR}/driver/*.c" )    

    # list(LENGTH SRC_LIST  file_num)

target_include_directories(lora INTERFACE 
    ${CMAKE_SOURCE_DIR}
    ${LORA_DIR}/driver
    ${LORA_DIR}/system
    ${LORA_DIR}/radio
    ${LORA_DIR}/radio/sx126x
)

target_sources(lora INTERFACE
    ${SRC_SYS_LIST}
    ${SRC_CRY_LIST}
    ${SRC_SX126X_LIST}
    ${SRC_DRV_LIST}
)

target_link_libraries(lora INTERFACE "TOOLCHAIN_gcc_${TARGET_PROCESSOR}" m)
