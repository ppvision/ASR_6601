cmake_minimum_required(VERSION 3.5)

# TARGET_PROCESSOR >m0,m0plus,m4,m4f,m33,m7,m0plus,riscv32
SET(TARGET_PROCESSOR m4)

set(ASR_SDK_DIR ${CMAKE_CURRENT_LIST_DIR}/asr_6601_sdk)
set(ASR_EXAMP_DIR ${ASR_SDK_DIR}/projects/ASR6601SE-EVAL/examples)



include(cmake/util.cmake)
include(cmake/toolchain/toolchain.cmake)
include(lora_lib.cmake)
include(soc_lib.cmake)


project(ASR C ASM)




get_sub_dirs(sub_dirs ${ASR_EXAMP_DIR})
message("subdir :  ${ASR_SDK_DIR}/projects/ASR661SE-EVAL/examples --> ${sub_dirs}")

foreach(subdir ${sub_dirs})
    message("subdir :  ${subdir}")

    if (EXISTS "${ASR_EXAMP_DIR}/${subdir}/Makefile")
        add_subdirectory(${subdir})
    endif()

    get_sub_dirs(child_dirs ${ASR_EXAMP_DIR}/${subdir})

    foreach(app ${child_dirs})
		file( GLOB SRC_LIST "${ASR_EXAMP_DIR}/${subdir}/${app}/src/*.c" )
		list(LENGTH SRC_LIST  file_num)

		if( file_num GREATER 0)

			message("App: ${subdir}/${app} Source list: ${file_num} > ${SRC_LIST}")

			set(EXE_NAME "${app}")
			add_executable   ("${EXE_NAME}" ${SRC_LIST})
			add_map_output   ("${EXE_NAME}" )
			add_extra_outputs("${EXE_NAME}" )
			target_include_directories(${EXE_NAME} PUBLIC 
			    "${ASR_EXAMP_DIR}/${subdir}/${app}/inc"
			)
			target_compile_definitions(${EXE_NAME} PRIVATE CONFIG_DEBUG_UART=UART0)
			
			target_link_libraries(${EXE_NAME} "TOOLCHAIN_gcc_${TARGET_PROCESSOR}" soc_lib lora crypto)
			target_linker_file(${EXE_NAME} ${CMAKE_SOURCE_DIR}/cmake/ld/asr6601se_gcc.ld)

		    # string(REPLACE "/" ";" APP_DIR "${subdir}")
		#     list(GET APP_DIR -1 APP_NAME_)

		#     message("Dir: ${subdir} (${APP_NAME_})  Source list: ${file_num}")

		#     set(EXE_NAME "${APP_NAME_}")
		#     add_executable   ("${EXE_NAME}" ${SRC_LIST})
		#     add_map_output   ("${EXE_NAME}" )
		#     add_extra_outputs("${EXE_NAME}" )
		#     target_include_directories(${EXE_NAME} PRIVATE 
		#         "${CMAKE_CURRENT_LIST_DIR}/${subdir}"
		#     )
		#     target_link_libraries(${EXE_NAME} "TOOLCHAIN_gcc_${TARGET_PROCESSOR}" WCH_Lib)
		endif()
    endforeach()

endforeach()





if(BUILD_TYPE)
	SET(CMAKE_BUILD_TYPE ${BUILD_TYPE})
endif()


