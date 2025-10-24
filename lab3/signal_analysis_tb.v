`timescale 1ns/1ps

module signal_analysis_tb;

// Часть 1
reg a1, b1, c1;
wire y1;
part1_combinational dut1(.a(a1), .b(b1), .c(c1), .y(y1));

// Часть 2
reg a2, b2, c2, d2;
wire y2;
part2_combinational dut2(.a(a2), .b(b2), .c(c2), .d(d2), .y(y2));

// Часть 3
reg a3, b3, c3, d3;
wire y3;
part3_combinational dut3(.a(a3), .b(b3), .c(c3), .d(d3), .y(y3));

// Часть 4
reg clk4, reset4, d4;
wire q4;
part4_sequential dut4(.clk(clk4), .reset(reset4), .d(d4), .q(q4));

// Часть 5
reg clk5, reset5, j5, k5;
wire q5;
part5_sequential dut5(.clk(clk5), .reset(reset5), .j(j5), .k(k5), .q(q5));

// Часть 6
reg clk6, reset6, a6, b6;
wire state6, y6;
part6_sequential dut6(.clk(clk6), .reset(reset6), .a(a6), .b(b6), .state(state6), .y(y6));

// Общий тактовый сигнал
reg clk;
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

assign clk4 = clk;
assign clk5 = clk;
assign clk6 = clk;

initial begin
    // Initialize VCD dump
    $dumpfile("out/signal_analysis_tb.vcd");
    $dumpvars(0, signal_analysis_tb);
    
    // Тест части 1
    $display("Testing Part 1: Combinational circuit");
    a1 = 0; b1 = 0; c1 = 0; #10;
    $display("a=%b, b=%b, c=%b, y=%b", a1, b1, c1, y1);
    
    a1 = 1; b1 = 1; c1 = 0; #10;
    $display("a=%b, b=%b, c=%b, y=%b", a1, b1, c1, y1);
    
    a1 = 0; b1 = 0; c1 = 1; #10;
    $display("a=%b, b=%b, c=%b, y=%b", a1, b1, c1, y1);
    
    // Тест части 2
    $display("Testing Part 2: Combinational circuit");
    a2 = 0; b2 = 0; c2 = 0; d2 = 0; #10;
    $display("a=%b, b=%b, c=%b, d=%b, y=%b", a2, b2, c2, d2, y2);
    
    a2 = 1; b2 = 1; c2 = 1; d2 = 1; #10;
    $display("a=%b, b=%b, c=%b, d=%b, y=%b", a2, b2, c2, d2, y2);
    
    // Тест части 3
    $display("Testing Part 3: Combinational circuit");
    a3 = 1; b3 = 1; c3 = 0; d3 = 0; #10;
    $display("a=%b, b=%b, c=%b, d=%b, y=%b", a3, b3, c3, d3, y3);
    
    a3 = 0; b3 = 0; c3 = 1; d3 = 1; #10;
    $display("a=%b, b=%b, c=%b, d=%b, y=%b", a3, b3, c3, d3, y3);
    
    // Тест части 4
    $display("Testing Part 4: Sequential circuit (D flip-flop)");
    reset4 = 1; d4 = 0; #10;
    reset4 = 0; #10;
    $display("Reset released, q=%b", q4);
    
    d4 = 1; #10;
    $display("d=%b, q=%b", d4, q4);
    
    d4 = 0; #10;
    $display("d=%b, q=%b", d4, q4);
    
    // Тест части 5
    $display("Testing Part 5: Sequential circuit (JK flip-flop)");
    reset5 = 1; j5 = 0; k5 = 0; #10;
    reset5 = 0; #10;
    $display("Reset released, q=%b", q5);
    
    j5 = 1; k5 = 0; #10;
    $display("j=%b, k=%b, q=%b", j5, k5, q5);
    
    j5 = 0; k5 = 1; #10;
    $display("j=%b, k=%b, q=%b", j5, k5, q5);
    
    j5 = 1; k5 = 1; #10;
    $display("j=%b, k=%b, q=%b", j5, k5, q5);
    
    // Тест части 6
    $display("Testing Part 6: Sequential circuit with combinational logic");
    reset6 = 1; a6 = 0; b6 = 0; #10;
    reset6 = 0; #10;
    $display("Reset released, state=%b, y=%b", state6, y6);
    
    a6 = 1; b6 = 0; #10;
    $display("a=%b, b=%b, state=%b, y=%b", a6, b6, state6, y6);
    
    a6 = 0; b6 = 1; #10;
    $display("a=%b, b=%b, state=%b, y=%b", a6, b6, state6, y6);
    
    a6 = 1; b6 = 1; #10;
    $display("a=%b, b=%b, state=%b, y=%b", a6, b6, state6, y6);
    
    $display("All signal analysis tests completed!");
    $finish;
end

endmodule
