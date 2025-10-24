`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_6_tb;
	reg clk = 1;
	always #5 clk = !clk;
    reg a;
    reg b;
    wire q;
    wire state;

	part_6 top0
	(
    .clk(clk),
	.a(a),
	.b(b),
	.q(q),
	.state(state)
	);

	initial begin
		$dumpfile("out/part_6_tb.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_6_tb);		// dump variable changes in the testbench
		
        a = 0;
        b = 0;

		#40;
        
        a = 0; b = 1;
        #10; 
        
        a = 1; b = 0;
        #10; 
        
        a = 1; b = 1;
        #10; 
        
        a = 0; b = 0;
        #10; 
        
        a = 1; b = 1;
        #30; 

        a = 1; b = 0;
        #10;

        a=0; b=1;
        #10;

        a=0; b=0;
        #25; 
		#10;

		$finish;
	end

	initial begin
		$monitor("t=%-4d: clk = %b, a=%b, b=%b, q=%b, state=%b", $time, clk, a, b, q, state);
	end
endmodule