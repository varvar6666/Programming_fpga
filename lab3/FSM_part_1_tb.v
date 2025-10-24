`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module FSM_part_1_tb;
	reg reset;
	reg clk = 1;
	always #5 clk = !clk;
	wire [9:0] q;

	FSM_part_1 top0
	(
    .clk(clk),
    .reset(reset),
    .q(q)
	);

	initial begin
		$dumpfile("out/FSM_part_1_tb.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, FSM_part_1_tb);		// dump variable changes in the testbench
		
		reset <= 1; 
		@(posedge clk); 
		reset <= 0;
		repeat (999) 
			@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		reset <= 1;  
		@(posedge clk); 
		reset <= 0;  
		#20

		$finish;
	end

	initial begin
		$monitor("t=%-4d: clk = %b, reset = h%b, q = %0d", $time, clk, reset, q);
	end
endmodule