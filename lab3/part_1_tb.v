`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_1_tb;
	reg a;
	reg b;
	reg c;
	reg d;
	wire q;

	part_1 top0
	(
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .q(q)
	);

	initial begin
		$dumpfile("out/part_1_tb.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_1_tb);		// dump variable changes in the testbench
		
		a = 0; b = 0; c = 0; d = 0;
		#15 d = 1;
		#5 d = 0; c = 1;
		#5 d = 1;
		#5 b = 1; c = 0; d = 0; 
		#5 d = 1;
		#5 c = 1; d = 0; 
		#5 d = 1;
		#5 a = 1; b = 0; c = 0; d = 0; 
		#5 d = 1;
		#5 c = 1; d = 0;
		#5 d = 1;
		#5 b = 1; c = 0; d = 0;
		#5 d = 1;
		#5 c = 1; d = 0; 
		#5 d = 1;
		#5 a = 0; b = 0; c = 0; d = 0;
		#5 d = 1;

		$finish;
	end

	initial begin
		$monitor("t=%-4d: a=%b, b=%b, c=%b, d=%b, q=%b", $time, a, b, c, d, q);
	end
endmodule