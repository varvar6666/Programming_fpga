`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module chip_7458_tb;

	reg p1a,p1b,p1c,p1d,p1e,p1f;
	reg p2a,p2b,p2c,p2d;
	wire p1y, p2y;

	chip_7458 chip_7458_mod0
	(
		.p1a(p1a),
		.p1b(p1b),
		.p1c(p1c),
		.p1d(p1d),
		.p1e(p1e),
		.p1f(p1f),
		.p2a(p2a),
		.p2b(p2b),
		.p2c(p2c),
		.p2d(p2d),
		.p1y(p1y),
		.p2y(p2y)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, chip_7458_tb);		// dump variable changes in the testbench
									// and all modules under it

		#5 p1a=0; p1b=0; p1c=0; p1d=0; p1e=0; p1f=0; p2a=0; p2b=0; p2c=0; p2d=0;
		#5;p1a=0; p1b=0; p1c=0; p1d=0; p1e=0; p1f=0; p2a=0; p2b=0; p2c=0; p2d=0;
		#5;p1a=0; p1b=0; p1c=1; p1d=0; p1e=0; p1f=0; p2a=0; p2b=0; p2c=0; p2d=1;
		#5;p1a=0; p1b=1; p1c=0; p1d=0; p1e=0; p1f=1; p2a=0; p2b=0; p2c=1; p2d=0;
		#5;p1a=0; p1b=1; p1c=1; p1d=0; p1e=0; p1f=1; p2a=0; p2b=0; p2c=1; p2d=1;
		#5;p1a=0; p1b=0; p1c=0; p1d=0; p1e=0; p1f=0; p2a=0; p2b=1; p2c=0; p2d=0;
		#5;p1a=1; p1b=0; p1c=1; p1d=0; p1e=1; p1f=0; p2a=0; p2b=1; p2c=0; p2d=1;
		#5;p1a=1; p1b=1; p1c=0; p1d=0; p1e=1; p1f=1; p2a=0; p2b=1; p2c=1; p2d=0;
		#5;p1a=1; p1b=1; p1c=1; p1d=0; p1e=1; p1f=1; p2a=0; p2b=1; p2c=1; p2d=1;
		#5;p1a=1; p1b=0; p1c=0; p1d=1; p1e=1; p1f=0; p2a=1; p2b=0; p2c=0; p2d=0;
		#5;p1a=0; p1b=0; p1c=1; p1d=1; p1e=0; p1f=0; p2a=1; p2b=0; p2c=0; p2d=1;
		#5;p1a=0; p1b=1; p1c=0; p1d=1; p1e=0; p1f=1; p2a=1; p2b=0; p2c=1; p2d=0;
		#5;p1a=0; p1b=1; p1c=1; p1d=1; p1e=0; p1f=1; p2a=1; p2b=0; p2c=1; p2d=1;
		#5;p1a=0; p1b=0; p1c=0; p1d=1; p1e=0; p1f=0; p2a=1; p2b=1; p2c=0; p2d=0;
		#5;p1a=1; p1b=0; p1c=1; p1d=1; p1e=1; p1f=0; p2a=1; p2b=1; p2c=0; p2d=1;
		#5;p1a=1; p1b=1; p1c=0; p1d=1; p1e=1; p1f=1; p2a=1; p2b=1; p2c=1; p2d=0;
		#5;p1a=1; p1b=1; p1c=1; p1d=1; p1e=1; p1f=1; p2a=1; p2b=1; p2c=1; p2d=1;
		#5;p1a=1; p1b=0; p1c=0; p1d=0; p1e=1; p1f=0; p2a=0; p2b=0; p2c=0; p2d=0;
		#5;p1a=0; p1b=0; p1c=1; p1d=0; p1e=0; p1f=0; p2a=0; p2b=0; p2c=0; p2d=1;
		#5;p1a=0; p1b=1; p1c=0; p1d=0; p1e=0; p1f=1; p2a=0; p2b=0; p2c=1; p2d=0;
		#5;p1a=0; p1b=1; p1c=1; p1d=0; p1e=0; p1f=1; p2a=0; p2b=0; p2c=1; p2d=1;
		#5;p1a=0; p1b=0; p1c=0; p1d=0; p1e=0; p1f=0; p2a=0; p2b=1; p2c=0; p2d=0;
		#5;p1a=1; p1b=0; p1c=1; p1d=0; p1e=1; p1f=0; p2a=0; p2b=1; p2c=0; p2d=1;
		#5;p1a=1; p1b=1; p1c=0; p1d=0; p1e=1; p1f=1; p2a=0; p2b=1; p2c=1; p2d=0;
		#5;p1a=1; p1b=1; p1c=1; p1d=0; p1e=1; p1f=1; p2a=0; p2b=1; p2c=1; p2d=1;
		#5

	
		$finish();
	end

	initial begin
		$monitor("t=%-4d: p1y = %d, p2y = %d", $time, p1y, p2y);
	end
endmodule