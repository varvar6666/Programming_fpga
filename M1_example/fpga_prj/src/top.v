module top(
    inout [15:0] GPIO_io, //inout [15:0] GPIO
    inout JTAG_7_io, //inout JTAG_7
    inout JTAG_9_io, //inout JTAG_9
    input HCLK_i


);

	wire pll_clk_200_o;
	wire pll_clk_2_o;
	wire pll_lock_o;

    Gowin_rPLL PLL_200(
        .clkout(pll_clk_200_o), //output clkout
        .lock(pll_lock_o), //output lock
        .clkoutd(pll_clk_2_o), //output clkoutd
        .clkin(HCLK_i) //input clkin
    );

    assign hwRstn_i = pll_lock_o;

	Gowin_EMPU_M1_Top M1_cpu(
		.LOCKUP(LOCKUP_o), //output LOCKUP
		.HALTED(HALTED_o), //output HALTED
		.GPIO(GPIO_io), //inout [15:0] GPIO
		.JTAG_7(JTAG_7_io), //inout JTAG_7
		.JTAG_9(JTAG_9_io), //inout JTAG_9
		.HCLK(pll_clk_200_o), //input HCLK
		.hwRstn(hwRstn_i) //input hwRstn
	);
endmodule