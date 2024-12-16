
set(PROJECT_NAME ${prj_name})

set(CXX_STD_VERSION 20)
set(VER 1.0)
set(DESC "Base for Gowin EMPU M1 cmake")
set(DEVICE_FAMILY	"CM1")
set(PreProc_Fl		"__STARTUP_CLEAR_BSS")
# set(DEVICE 			"STM32G431C8")

set(inc_dirs 
	"inc/"
	"libraries/cmsis/cm1/core_support"
	"libraries/cmsis/cm1/device_support"
	"libraries/drivers/inc"
	)

# set(src_dirs
# 	"src/"
# 	"startup/"
# 	"drivers/src/"
# 	"cmsis/cm1/device_support/"
# 	)
set(SRCs
	"startup/startup_GOWIN_M1.S"
	"src/main.c"
	"libraries/drivers/src/GOWIN_M1_gpio.c"
	"libraries/drivers/src/GOWIN_M1_misc.c"
	"libraries/drivers/src/GOWIN_M1_psram.c"
	"libraries/drivers/src/GOWIN_M1_trng.c"
	"libraries/cmsis/cm1/device_support/system_GOWIN_M1.c"
	
	)

# set(linker_script "${CMAKE_CURRENT_LIST_DIR}/GOWIN_M1_flash_burn.ld") 
set(linker_script "${CMAKE_CURRENT_LIST_DIR}/GOWIN_M1_flash_xip.ld")

set(linker_params "-Wl,--no-warn-rwx-segment")
