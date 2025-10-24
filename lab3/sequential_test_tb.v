`timescale 1ns/1ps

module sequential_test_tb;

reg clk, reset;
reg d, j, k, a, b;
wire q4, q5, state, y6;

part4_sequential dut4(.clk(clk), .reset(reset), .d(d), .q(q4));
part5_sequential dut5(.clk(clk), .reset(reset), .j(j), .k(k), .q(q5));
part6_sequential dut6(.clk(clk), .reset(reset), .a(a), .b(b), .state(state), .y(y6));

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $display("=== Sequential Circuits Test ===");
    
    // Test Part 4: D flip-flop
    $display("\nTesting Part 4: D flip-flop");
    reset = 1; d = 0; #10;
    $display("Reset: d=%b, q=%b", d, q4);
    
    reset = 0; d = 1; #10;
    $display("After reset: d=%b, q=%b", d, q4);
    
    d = 0; #10;
    $display("d=%b, q=%b", d, q4);
    
    d = 1; #10;
    $display("d=%b, q=%b", d, q4);
    
    // Test Part 5: JK flip-flop
    $display("\nTesting Part 5: JK flip-flop");
    reset = 1; j = 0; k = 0; #10;
    $display("Reset: j=%b k=%b, q=%b", j, k, q5);
    
    reset = 0; j = 1; k = 0; #10; // Set
    $display("Set: j=%b k=%b, q=%b", j, k, q5);
    
    j = 0; k = 1; #10; // Reset
    $display("Reset: j=%b k=%b, q=%b", j, k, q5);
    
    j = 1; k = 1; #10; // Toggle
    $display("Toggle: j=%b k=%b, q=%b", j, k, q5);
    
    j = 1; k = 1; #10; // Toggle again
    $display("Toggle: j=%b k=%b, q=%b", j, k, q5);
    
    j = 0; k = 0; #10; // Hold
    $display("Hold: j=%b k=%b, q=%b", j, k, q5);
    
    // Test Part 6: Combinational + Memory
    $display("\nTesting Part 6: Combinational + Memory");
    reset = 1; a = 0; b = 0; #10;
    $display("Reset: a=%b b=%b, state=%b y=%b", a, b, state, y6);
    
    reset = 0; a = 1; b = 0; #10;
    $display("a=%b b=%b, state=%b y=%b", a, b, state, y6);
    
    a = 0; b = 1; #10;
    $display("a=%b b=%b, state=%b y=%b", a, b, state, y6);
    
    a = 1; b = 1; #10;
    $display("a=%b b=%b, state=%b y=%b", a, b, state, y6);
    
    $display("\nTest completed!");
    $finish;
end

endmodule
