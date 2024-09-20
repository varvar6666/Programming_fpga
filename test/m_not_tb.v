`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module test_not;

	reg a = 0;
	wire c;

	m_not not_0
	(
		.in(a),
		.out(c)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, test_not);		// dump variable changes in the testbench
									// and all modules under it

		#5
		a = 1;
		#5
		a = 0;
		#5
		a = 1;
		#5
		a = 0;
	
		$finish();
	end

	initial begin
		$monitor("t=%-4d: a = %d, c = %d", $time, a, c);
	end
endmodule