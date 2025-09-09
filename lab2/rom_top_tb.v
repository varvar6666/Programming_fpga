`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module rom_top_tb;


	reg[1:0] adr;
	reg[3:0] dout;

	rom_top top0
	(
		.adr(adr),
		.dout(dout)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, rom_top_tb);		// dump variable changes in the testbench
		
		adr = 0;							// and all modules under it
		#5 adr = 1;
		#5 adr = 2;
		#5 adr = 3;

		#5

		$finish;
		
	end

	initial begin
		$monitor("t=%-4d: data = %d, segments = %d", $time, adr, dout);
	end
endmodule