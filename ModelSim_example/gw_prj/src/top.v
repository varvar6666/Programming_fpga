module top (
	input clk_i,
	output lock_o,
	output clk_1m_o,
	output clk_100m_o,
	input wire [7:0] a,
	input wire [7:0] b,
	output [15:0] multi_soft_o
);


	Gowin_rPLL pll_100_1(
		.clkout(clk_100m_o), //output clkout
		.lock(lock_o), //output lock
		.clkoutd(clk_1m_o), //output clkoutd
		.clkin(clk_i) //input clkin
	);

	Integer_Multiplier_Top multi_soft(
		.mul_a(a), //input [7:0] mul_a
		.mul_b(b), //input [7:0] mul_b
		.product(multi_soft_o) //output [15:0] product
	);

endmodule