`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module ram_top_tb;

	reg clk=1;
	always #5 clk = !clk;

	parameter N = 4, M = 32;

    reg [N-1:0] adr = 0;
    reg [M-1:0] din = 0;
	reg we = 0;
	wire [M-1:0] dout;

	ram_top #(N, M) top0
	(
		.clk(clk),
		.we(we),
		.adr(adr),
		.din(din),
		.dout(dout)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, ram_top_tb);		// dump variable changes in the testbench
		
        @(posedge clk)
        adr <= 1; din <= 32'hA; we <= 1;
        @(posedge clk)
        we <= 0;
        @(posedge clk)
        adr <= 4'hf; din <= 32'hFA12; we <= 1;
        @(posedge clk)
        we <= 0;
        @(posedge clk)
        adr <= 4'h1;
        @(posedge clk)
        adr <= 0; din <= 32'hFFFF; we <= 1;
        @(posedge clk)
        we <= 0;
        @(posedge clk)
        adr <= 4'h8; din <= 32'hFFFFFFFF; we <= 1;
        @(posedge clk)
        we <= 0;
        @(posedge clk)
        adr <= 4'h1; din <= 32'hF; we <= 1;
        @(posedge clk)
        we <= 0;
        @(posedge clk)
        adr <= 4'h1;
        @(posedge clk)

		$finish;
		
	end

	initial begin
		$monitor("t=%-4d: adr = %d, dout = %d", $time, adr, dout);
	end
endmodule