cmake_minimum_required(VERSION 3.20)
################################## BASE SETUP ###############################################################
include(base_setup.cmake)

# message(STATUS "ttt \"${TEST}\"")
################################## COMPILER SETUP ###############################################################
# file(GLOB TOOLCHAIN_DIRECTORIES
# "C:/Program Files (x86)/Arm GNU Toolchain arm-none-eabi/*/bin/"
# "C:/ST/STM32CubeIDE_*/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.*/tools/bin/"
# "/opt/st/stm32cubeide_*/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.*/tools/bin/"
# "/Applications/STM32CubeIDE.app/Contents/Eclipse/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.*/tools/bin/"
# )

# list(LENGTH TOOLCHAIN_DIRECTORIES TOOLCHAIN_DIRECTORIES_COUNT)

# if(TOOLCHAIN_DIRECTORIES_COUNT LESS 1)
#     message(WARNING "Could not find an STM32CubeIDE installation. Falling back to tools available on PATH.")
# else()
#     list(GET TOOLCHAIN_DIRECTORIES 0 TOOLCHAIN_DIRECTORY)
#     if (TOOLCHAIN_DIRECTORIES_COUNT GREATER 1)
#         message(STATUS "Found multiple STM32CubeIDE installations. Using \"${TOOLCHAIN_DIRECTORY}\".")
#     endif()
# endif()

if(WIN32)
    set(TOOLCHAIN_SUFFIX ".exe")
endif()

set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          arm)

set(TOOLCHAIN_PREFIX                "arm-none-eabi-")
if(DEFINED TOOLCHAIN_DIRECTORY)
    set(TOOLCHAIN_PREFIX            "${TOOLCHAIN_DIRECTORY}/${TOOLCHAIN_PREFIX}")
endif()
set(FLAGS                           "-fdata-sections -ffunction-sections --specs=nano.specs --specs=nosys.specs -Wl,--gc-sections")
set(ASM_FLAGS                       "-x assembler-with-cpp")
set(CPP_FLAGS                       "-fno-rtti -fno-exceptions -fno-threadsafe-statics")

set(CMAKE_C_COMPILER                ${TOOLCHAIN_PREFIX}gcc${TOOLCHAIN_SUFFIX} ${FLAGS})
set(CMAKE_ASM_COMPILER              ${CMAKE_C_COMPILER} ${ASM_FLAGS})
set(CMAKE_CXX_COMPILER              ${TOOLCHAIN_PREFIX}g++${TOOLCHAIN_SUFFIX} ${FLAGS} ${CPP_FLAGS})
set(CMAKE_OBJCOPY                   ${TOOLCHAIN_PREFIX}objcopy${TOOLCHAIN_SUFFIX})
set(CMAKE_SIZE                      ${TOOLCHAIN_PREFIX}size${TOOLCHAIN_SUFFIX})

set(CMAKE_EXECUTABLE_SUFFIX_ASM     ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C       ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX     ".elf")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

################################## PORJECT SETUP ###############################################################

project(${PROJECT_NAME} 	VERSION ${VER}
							DESCRIPTION ${DESC}
							LANGUAGES C CXX ASM)

SET(CMAKE_CXX_STANDARD ${CXX_STD_VERSION})

add_executable("${PROJECT_NAME}")

################################## TARGET DEFINITIONS ###############################################################

target_compile_definitions(
	${PROJECT_NAME} PRIVATE
	"DEBUG"
	${DEVICE_FAMILY}
	${PreProc_Fl}
)

################################## TARGET INCLUDE ###############################################################

# file(GLOB_RECURSE HEADERS "Drivers/CMSIS/Include/*.h"  "Drivers/CMSIS/Device/ST/STM32F4xx/Include/*.h" "Drivers/src/*.hpp" "inc/*.hpp")
# set (INCLUDE_DIRS "")
# foreach (_headerFile ${HEADERS})
#     get_filename_component(_dir ${_headerFile} PATH)
#     list (APPEND INCLUDE_DIRS ${_dir})
# endforeach()
# list(REMOVE_DUPLICATES INCLUDE_DIRS)

# target_include_directories(${PROJECT_NAME} PRIVATE ${INCLUDE_DIRS})

target_include_directories(${PROJECT_NAME} PRIVATE ${inc_dirs})


################################## TARGET SOURCES ###############################################################

# set(SRCs "")
# foreach (_srcdir ${src_dirs})
# 	file(GLOB _src_c ${_srcdir}/*.c ${_srcdir}/*.cpp ${_srcdir}/*.s)
# 	list (APPEND SRCs ${_src_c})
# endforeach()

target_sources(
	${PROJECT_NAME} PRIVATE	${SRCs}
)

################################## COMPILE OPTIONS ###############################################################

target_compile_options(
	${PROJECT_NAME} PRIVATE
	# CPU specific
	"-mcpu=cortex-m1"
	# "-mfloat-abi=hard"
	"-mthumb"
	# "-mfpu=fpv4-sp-d16"
	# Other options
	"-g3"
	"-c"
	"-O0"
	"-Wall"
	"-Wextra"
	"-Wpedantic"
	"-Wno-unused-parameter"
	"-Wno-deprecated"
)

################################## LINK OPTIONS ###############################################################

target_link_options(
	${PROJECT_NAME} PRIVATE
	"-mcpu=cortex-m1"
	"-mthumb"
	# "-mfpu=fpv4-sp-d16"
	# "-mfloat-abi=hard"
	# "-u _printf_float"
	# "-Wl,--start-group"
	# "-lc"
	# "-lm"
	# "-lstdc++"
	# "-lsupc++"
	# "-Wl,--end-group"
	"-Wl,-z,max-page-size=8"
	"-Wl,--print-memory-usage"
	${linker_params}
	-T ${linker_script}
)

################################## POST ###############################################################

add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}>
)

# add_custom_command(
#     TARGET ${PROJECT_NAME} POST_BUILD
#     COMMAND ${CMAKE_OBJCOPY} -O ihex
#     $<TARGET_FILE:${PROJECT_NAME}> ${PROJECT_NAME}.hex
# )

add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary
    $<TARGET_FILE:${PROJECT_NAME}> ${PROJECT_NAME}.bin
)

################################## POST ###############################################################
message(STATUS "Project Name: ${PROJECT_NAME}")
