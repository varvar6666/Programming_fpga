`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_4_tb;
	reg clock;
	always #30 clock = !clock;
    reg a;
    wire p, q;

	part_4 top0
	(
    .clock(clock),
	.a(a),
	.p(p),
	.q(q)
	);

	initial begin
		$dumpfile("out/part_4_tb.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_4_tb);		// dump variable changes in the testbench
		
		clock = 0;
        a = 0;

		#60;
		#5 a = 0;
        #5 a = 0;  
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 0;
        #5 a = 0;
        #5 a = 0;
        #5 a = 0;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 0;
        #5 a = 1;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 1;
        #5 a = 0;
        #5 a = 0;
        #5 a = 1;
        #5 a = 1;
        #5 a = 0;
        #5 a = 0;
        #5 a = 1;

		$finish;
	end

	initial begin
		$monitor("t=%-4d: clock=%b, a=%b, p=%b, q=%b", $time, clock, a, p, q);
	end
endmodule