`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_2_top_tb;
	reg clk=0;
	always #5 clk = !clk;

	reg [7:0]d = 0;
	reg [1:0]sel = 0;
	wire [7:0]q;

	part_2_top_module top0
	(
		.d(d),
		.q(q),
		.sel(sel),
		.clk(clk)
	);

	integer i;

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_2_top_tb);		// dump variable changes in the testbench
									// and all modules under it
		
		@(negedge clk);


		for (i = 0; i < 32; i = i + 1) begin
			@(posedge clk);
			if (i < 16) begin
				d <= i;	
				if ((i%4 == 0)&&(i != 0))
					sel = sel + 1;
			end
			else
				d <= 0;
		end

	
		$finish();
	end

	initial begin
		$monitor("t=%-4d: d = %d, q = %d", $time, d, q);
	end
endmodule