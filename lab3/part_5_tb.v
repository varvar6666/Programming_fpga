`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_5_tb;
	reg a;
	reg clk = 1;
	always #5 clk = !clk;

	wire [2:0] q;

	part_5 top0
	(
    .clk(clk),
    .a(a),
    .q(q)
	);

	initial begin
		$dumpfile("out/part_5_tb.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_5_tb);		// dump variable changes in the testbench
		
		a <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		a <= 0;
		repeat(11)
        	@(posedge clk);
		#5 a <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		a <= 0;
		#40
		
		$finish;
	end

	initial begin
		$monitor("t=%-4d: clk = %b, a = %b, q = %0d", $time, clk, a, q);
	end
endmodule