`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_3_tb;
	reg [3:0] a;
	reg [3:0] b; 
	reg [3:0] d;
	reg [3:0] e;
    reg [3:0] c;
    wire [3:0] q;

	part_3 top0
	(
    .a(a),
	.b(b),
	.d(d),
	.e(e),
	.c(c),
	.q(q)
	);

	initial begin
		$dumpfile("out/part_3_tb.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_3_tb);		// dump variable changes in the testbench
		
		#10;
        a = 4'ha; b = 4'hb; d = 4'hd; e = 4'he; c = 4'h0;
		#5 c = 4'h1; 
		#5 c = 4'h2; 
		#5 c = 4'h3; 
		#5 c = 4'h4; 
		#5 c = 4'h5; 
		#5 c = 4'h6; 
		#5 c = 4'h7; 
		#5 c = 4'h8;
		#5 c = 4'h9;
		#5 c = 4'ha;
		#5 c = 4'hb; 
		#5 c = 4'hc;
		#5 c = 4'hd;  
		#5 c = 4'he;
		#5 c = 4'hf;
		#5 c = 4'h0;
		#5 c = 4'h1;
		#5 c = 4'h1; 
		#5 c = 4'h2; 

		#5
		a = 4'h1; b = 4'h2; d = 4'h3; e = 4'h4; c = 4'h0;
		#5 c = 4'h1; 
		#5 c = 4'h2; 
		#5 c = 4'h3; 
		#5 c = 4'h4; 
		#5 c = 4'h5; 
		#5 c = 4'h6; 
		#5 c = 4'h7; 
		#5 c = 4'h8;

		#10 
		a = 4'h5; b = 4'h6; d = 4'h7; e = 4'h8; c = 4'h0;
		#5 c = 4'h1; 
		#5 c = 4'h2; 
		#5 c = 4'h3; 
		#5 c = 4'h4; 
		#5 c = 4'h5; 
		#5 c = 4'h6; 
		#5 c = 4'h7; 
		#5
		
		$finish;
	end

	initial begin
		$monitor("t=%-4d: a=%b, b=%b, c=%b, d=%b, e=%b, q=%b", $time, a, b, c, d, e, q);
	end
endmodule