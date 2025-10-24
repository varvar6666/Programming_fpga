`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module FSM_part_2_tb;
	reg clk = 1;
	always #5 clk = !clk;
	reg shift_ena;  
	reg count_ena;   
	reg data;       
  	wire [3:0] q;    

	FSM_part_2 top0
	(
	.clk(clk),
	.shift_ena(shift_ena),
	.count_ena(count_ena),
	.data(data),
	.q(q)
	);

	initial begin
		$dumpfile("out/FSM_part_2_tb.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, FSM_part_2_tb);		// dump variable changes in the testbench
		
		shift_ena <= 0;
		count_ena <= 0;
		data <= 0;
		
		@(posedge clk);
		@(posedge clk);
		shift_ena <= 1;
		data <= 1;
		@(posedge clk); 
		data <= 0;
		@(posedge clk);
		@(posedge clk);
		data <= 1;
		@(posedge clk);
		data <= 0;
		shift_ena <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		count_ena <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		count_ena <= 0;
		#20

		$finish;
	end

	initial begin
		$monitor("t=%-4d: clk = %b, shift_ena=%b, count_ena=%b, data=%b, q=%d", $time, clk, shift_ena, count_ena, data, q);
	end
endmodule