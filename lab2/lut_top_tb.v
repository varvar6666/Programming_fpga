`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module lut_top_tb;

    reg clk=1;
	always #5 clk = !clk;

    reg enable;
    reg S, A, B, C;
    wire Z;

    lut_top top0 (
        .clk(clk),
        .enable(enable),
        .S(S),
        .A(A), 
        .B(B), 
        .C(C),
        .Z(Z) 
    );

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, lut_top_tb);		// dump variable changes in the testbench

        enable <= 0;
        S <= 0;
        A <= 0;
        B <= 0;
        C <= 0;
		
        // Первый логический вентиль
        @(posedge clk);
        enable <= 1;
        S <= 1;
        @(posedge clk);
        S <= 0;
        repeat(7)
            @(posedge clk);
        enable <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);
        B <= 1;
        C <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);
        A <= 1;
        B <= 0;
        C <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);
        B <= 1;
        C <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);


        // Второй логический вентиль
        enable <= 0;
        S <= 0;
        A <= 0;
        B <= 0;
        C <= 0;
        @(posedge clk);
        enable <= 1;
        S <= 1;
        @(posedge clk);

        S <= 0;
        @(posedge clk);
        @(posedge clk);
        S <= 1;
        @(posedge clk);
        S <= 0;
        @(posedge clk);
        S <= 1;
        @(posedge clk);
        @(posedge clk);
        S <= 0;
        @(posedge clk);
        enable <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);
        B <= 1;
        C <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);
        A <= 1;
        B <= 0;
        C <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);
        B <= 1;
        C <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);

        S <= 0;
        A <= 0;
        B <= 0;
        C <= 0;
		
        // Третий логический вентиль
        @(posedge clk);
        enable <= 1;
        S <= 1;
        @(posedge clk);
        S <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        S <= 1;
        @(posedge clk);
        S <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        enable <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);
        B <= 1;
        C <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);
        A <= 1;
        B <= 0;
        C <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);
        B <= 1;
        C <= 0;
        @(posedge clk);
        C <= 1;
        @(posedge clk);

        $finish;
    end

    initial begin
        $monitor("t=%0t: A=%b, B=%b, C=%b, Z=%b", $time, A, B, C, Z);
    end

endmodule