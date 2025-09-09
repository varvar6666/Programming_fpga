`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module alu_top_tb;


    reg [31:0] a_i;
    reg [31:0] b_i;
    reg [4:0] op_i;

    wire [31:0] result_o;
    wire flag_o;

    alu_top top0 (
        .a_i(a_i),
        .b_i(b_i),
        .op_i(op_i),
        .result_o(result_o),
        .flag_o(flag_o)
    );

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, alu_top_tb);		// dump variable changes in the testbench

        a_i = 0;
        b_i = 0;
        op_i = 0;

        // ADD
        #5
        a_i = 32'h00000005; b_i = 32'h00000003; op_i = 5'b00000;
        #5


        // SUB
        #5
        a_i = 32'h00000005; b_i = 32'h00000003; op_i = 5'b01000;
        #5


        // SLL
        #5
        a_i = 32'h00000001; b_i = 32'h00000003; op_i = 5'b00001;
        #5


        // SLTS
        #5
        a_i = 32'hFFFFFFFE; b_i = 32'h00000001; op_i = 5'b00010;
        #5


        // SLTU
        #5
        a_i = 32'hFFFFFFFE; b_i = 32'h00000001; op_i = 5'b00011;
        #5


        // XOR
        #5
        a_i = 32'h000000AF; b_i = 32'h000000FA; op_i = 5'b00100;
        #5


        // SRL
        #5
        a_i = 32'h80000000; b_i = 32'h00000001; op_i = 5'b00101;
        #5


        // SRA
        #5
        a_i = 32'h80000000; b_i = 32'h00000003; op_i = 5'b01101;
        #5


        // OR
        #5
        a_i = 32'h0000000F; b_i = 32'h000000F0; op_i = 5'b00110;
        #5


        // AND
        #5
        a_i = 32'h0000000F; b_i = 32'h000000F0; op_i = 5'b00111;
        #5


        // EQ
        #5
        a_i = 32'h00000005; b_i = 32'h00000005; op_i = 5'b11000;
        #5


        #5
        a_i = 32'h00000005; b_i = 32'h00000006; op_i = 5'b11000;
        #5


        // NE
        #5
        a_i = 32'h00000005; b_i = 32'h00000005; op_i = 5'b11001;
        #5

        #5
        a_i = 32'h00000005; b_i = 32'h00000006; op_i = 5'b11001;
        #5


        // LTS
        #5
        a_i = 32'hFFFFFFFE; b_i = 32'h00000001; op_i = 5'b11100;
        #5

        #5
        a_i = 32'h0FFFFFFE; b_i = 32'hF0000001; op_i = 5'b11100;
        #5


        // GES
        #5
        a_i = 32'h00000001; b_i = 32'hFFFFFFFE; op_i = 5'b11101;
        #5

        #5
        a_i = 32'h00000001; b_i = 32'h00000001; op_i = 5'b11101;
        #5

        #5
        a_i = 32'h00000001; b_i = 32'h00000002; op_i = 5'b11101;
        #5



        // LTU
        #5
        a_i = 32'h00000001; b_i = 32'hFFFFFFFE; op_i = 5'b11110;
        #5

        #5
        a_i = 32'h00000001; b_i = 32'h00000000; op_i = 5'b11110;
        #5


        // GEU
        #5
        a_i = 32'h10000000; b_i = 32'hFFFFFFFE; op_i = 5'b11111;
        #5

        #5
        a_i = 32'h10000000; b_i = 32'h10000000; op_i = 5'b11111;
        #5

        #5
        a_i = 32'h10000000; b_i = 32'h01111111; op_i = 5'b11111;
        #5


        #5
        $finish;
    end

    initial begin
        $monitor("t=%0t: op=%b, a=%h, b=%h, result=%h, flag=%b", $time, op_i, a_i, b_i, result_o, flag_o);
    end

endmodule