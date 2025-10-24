`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module FSM_part_3_tb;
	reg clk = 1;
	always #5 clk = !clk;
    reg reset;
    reg data;
    wire start_shifting;

	FSM_part_3 top0
	(
    .clk(clk),
	.reset(reset),
	.data(data),
	.start_shifting(start_shifting)
	);

	initial begin
		$dumpfile("out/FSM_part_3_tb.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, FSM_part_3_tb);		// dump variable changes in the testbench
		
		reset <= 1;
        data <= 0;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		data <= 1;
		@(posedge clk);
		data <= 0;
		@(posedge clk);
		data <= 1;
		repeat(5) 
			@(posedge clk);
		data <= 0;	
		@(posedge clk);
		data <= 1;
		@(posedge clk);
		@(posedge clk);
		data <= 0;
		@(posedge clk);
		@(posedge clk);
		reset <= 1;
        data <= 1;
		#20

		$finish;
	end

	initial begin
		$monitor("t=%-4d: clk = %b, reset = %b, data = %b, start_shifting = %b", $time, clk, reset, start_shifting);
	end
endmodule