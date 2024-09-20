`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module full_add_3b_tb;

	reg [2:0] a = 0, b = 0;
	reg carry = 0;
	wire [2:0] sum, carry_out;

	full_add_3b full_add_mod0
	(
		.a(a),
		.b(b),
		.cin(carry),
		.cout(carry_out),
		.sum(sum)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, full_add_3b_tb);		// dump variable changes in the testbench
									// and all modules under it

		#5 a = 2; b = 3;
		#5 carry = 1;
		#5 b = 2; carry = 0;
		#5 a = 0; b = 0; carry = 1;
		#5 b = 4;
		#5 a = 6; b = 1;
		#5 a = 0; b = 6;
		#5 a = 6; b = 2;
		#5 a = 1; b = 1; carry = 0;
		#5 a = 0; b = 0; carry = 1;
		#5 b = 6;
		#5 a = 7; b = 3; carry = 0;


	
		$finish();
	end

	initial begin
		$monitor("t=%-4d: cout = %d, sum = %d", $time, carry_out, sum);
	end
endmodule