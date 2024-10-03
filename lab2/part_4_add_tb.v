`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_4_top_tb;
	reg [31:0]a = 0,b = 0;
	wire [31:0]sum;

	part_4_top_module top0
	(
		.a(a),
		.b(b),
		.sum(sum)
	);


	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_4_top_tb);		// dump variable changes in the testbench
									// and all modules under it
		
		#5 a = 0; b = 1;
		#5 b = 2;
		#5 a = 1;
		#5 a = 32'hffff; b = 0;
		#5 b = 1;
		#5 b = 32'h2ccc1;
		#5
	
		$finish();
	end

	initial begin
		$monitor("t=%-4d: a = %h, b = %h, s = %h", $time, a, b,sum);
	end
endmodule