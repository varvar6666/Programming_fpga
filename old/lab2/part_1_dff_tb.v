`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_1_top_tb;
	reg clk=0;
	always #5 clk = !clk;

	reg d = 0;
	wire q;

	part_1_top_module top0
	(
		.d(d),
		.q(q),
		.clk(clk)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_1_top_tb);		// dump variable changes in the testbench
									// and all modules under it
		
		@(posedge clk);
		@(posedge clk);
		d <= 1;
		@(posedge clk);
		@(posedge clk);
		d <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		d <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		d <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		// #10 d = 1;
		// #5 d = 1;
		// #5 d = 0;
		// #5 d = 1;
		// #5 d = 1;
		// #5 d = 0;


	
		$finish();
	end

	initial begin
		$monitor("t=%-4d: d = %d, q = %d", $time, d, q);
	end
endmodule