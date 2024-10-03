`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_5_top_tb;
	reg [31:0]a = 0,b = 0;
	reg sub = 0;
	wire [31:0]sum;

	part_5_top_module top0
	(
		.a(a),
		.b(b),
		.sub(sub),
		.sum(sum)
	);


	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_5_top_tb);		// dump variable changes in the testbench
									// and all modules under it
		
		#5 a = 1; b = 0;
		#5 a = 2;
		#5 b = 1; sub = 1;
		#5 b = 2;
		#5 a = 32'hffff; b = 1; sub = 0;
		#5 a = 32'h10000; sub = 1;
		#5 a = 32'hffff_ffff; b = 32'hffff_ffff; sub = 0;
		#5
	
		$finish();
	end

	initial begin
		$monitor("t=%-4d: a = %h, b = %h, sub = %h, s = %h", $time, a, b, sub,sum);
	end
endmodule