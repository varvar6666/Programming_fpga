`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module sevenseg_top_tb;


	reg[3:0] data;
	wire[6:0] segments;

	sevenseg_top top0
	(
		.data(data),
		.segments(segments)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, sevenseg_top_tb);		// dump variable changes in the testbench
		
		data = 0;							// and all modules under it
		#5 data = 1;
		#5 data = 2;
		#5 data = 3;
		#5 data = 4;
		#5 data = 5;
		#5 data = 6;
		#5 data = 7;
		#5 data = 8;
		#5 data = 9;

		#5

		$finish;
		
	end

	initial begin
		$monitor("t=%-4d: data = %d, segments = %d", $time, data, segments);
	end
endmodule