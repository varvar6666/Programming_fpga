`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module file_reg_top_tb;

	reg clk=1;
	always #5 clk = !clk;

    reg we;
    reg [4:0] waddr;
    reg [31:0] wdata;
    reg [4:0] raddr1;
    reg [4:0] raddr2;

    wire [31:0] rdata1;
    wire [31:0] rdata2;

	file_reg_top top0
	(
        .clk(clk),
        .we(we),
        .waddr(waddr),
        .wdata(wdata),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .rdata1(rdata1),
        .rdata2(rdata2)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, file_reg_top_tb);		// dump variable changes in the testbench

        we <= 0;
        waddr <= 0;
        wdata <= 0;
        raddr1 <= 0;
        raddr2 <= 0;
		

        @(posedge clk);
        we <= 1;
        waddr <= 0;
        wdata <= 32'hDEADBEEF;
        @(posedge clk);
        we <= 0;
        @(posedge clk);


        we <= 1;
        waddr <= 1;
        wdata <= 32'hCAFEBABE;
        @(posedge clk);
        we <= 0;
        raddr1 <= 0;
        raddr2 <= 1;
        @(posedge clk);


        we <= 1;
        waddr <= 2;
        wdata <= 32'h12345678;
        @(posedge clk);
        we <= 0;
        raddr1 <= 2;
        raddr2 <= 0;
        @(posedge clk);


        raddr1 <= 0;
        raddr2 <= 0;
        @(posedge clk);


        raddr1 <= 1;
        raddr2 <= 2;
        @(posedge clk);

        raddr1 <= 2;
        raddr2 <= 1;
        @(posedge clk);

        we <= 1;
        waddr <= 2;
        wdata <= 32'h87654321;
        @(posedge clk);
        we <= 0;
        raddr1 <= 2;
        raddr2 <= 2;
        @(posedge clk);




		$finish;
		
	end

    initial begin
        $monitor("t=%0t: we=%b, waddr=%h, wdata=%h, raddr1=%h, rdata1=%h, raddr2=%h, rdata2=%h",
                 $time, we, waddr, wdata, raddr1, rdata1, raddr2, rdata2);
    end

endmodule