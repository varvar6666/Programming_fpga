//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.9 Beta-1
//Part Number: GW2A-LV18PG256C8/I7
//Device: GW2A-18
//Device Version: C
//Created Time: Fri Oct 25 08:57:25 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Gowin_EMPU_M1_Top your_instance_name(
		.LOCKUP(LOCKUP_o), //output LOCKUP
		.HALTED(HALTED_o), //output HALTED
		.GPIO(GPIO_io), //inout [15:0] GPIO
		.JTAG_7(JTAG_7_io), //inout JTAG_7
		.JTAG_9(JTAG_9_io), //inout JTAG_9
		.HCLK(HCLK_i), //input HCLK
		.hwRstn(hwRstn_i) //input hwRstn
	);

//--------Copy end-------------------
