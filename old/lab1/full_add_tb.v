`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module full_add_tb;

	reg a = 0,b = 0, carry = 0;
	wire sum, carry_out;

	full_add full_add_mod0
	(
		.a(a),
		.b(b),
		.cin(carry),
		.cout(carry_out),
		.sum(sum)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, full_add_tb);		// dump variable changes in the testbench
									// and all modules under it

		#5 b = 1;
		#5 a = 1; b = 0;
		#5 b = 1;
		#5 a = 0; b = 0;
		#5 carry = 1;
		#5 a = 1;
		#5 a = 0; b = 1;


	
		$finish();
	end

	initial begin
		$monitor("t=%-4d: sum = %d, cout = %d", $time, sum, carry_out);
	end
endmodule