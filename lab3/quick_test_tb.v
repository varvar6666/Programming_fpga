`timescale 1ns/1ps

module quick_test_tb;

reg a, b, c, d;
wire y1, y2, y3;

part1_combinational dut1(.a(a), .b(b), .c(c), .y(y1));
part2_combinational dut2(.a(a), .b(b), .c(c), .d(d), .y(y2));
part3_combinational dut3(.a(a), .b(b), .c(c), .d(d), .y(y3));

initial begin
    $display("=== Quick Test ===");
    $display("Part 1: y = c");
    $display("Part 2: y = a ^ b ^ c ^ d");
    $display("Part 3: y = (a & b) | (c & d)");
    $display("");
    
    // Test Part 1
    $display("Testing Part 1:");
    a = 0; b = 0; c = 0; #1 $display("a=%b b=%b c=%b | y1=%b", a, b, c, y1);
    a = 0; b = 0; c = 1; #1 $display("a=%b b=%b c=%b | y1=%b", a, b, c, y1);
    a = 1; b = 1; c = 0; #1 $display("a=%b b=%b c=%b | y1=%b", a, b, c, y1);
    a = 1; b = 1; c = 1; #1 $display("a=%b b=%b c=%b | y1=%b", a, b, c, y1);
    $display("");
    
    // Test Part 2
    $display("Testing Part 2:");
    a = 0; b = 0; c = 0; d = 0; #1 $display("a=%b b=%b c=%b d=%b | y2=%b", a, b, c, d, y2);
    a = 0; b = 0; c = 0; d = 1; #1 $display("a=%b b=%b c=%b d=%b | y2=%b", a, b, c, d, y2);
    a = 0; b = 0; c = 1; d = 0; #1 $display("a=%b b=%b c=%b d=%b | y2=%b", a, b, c, d, y2);
    a = 0; b = 0; c = 1; d = 1; #1 $display("a=%b b=%b c=%b d=%b | y2=%b", a, b, c, d, y2);
    a = 1; b = 1; c = 1; d = 1; #1 $display("a=%b b=%b c=%b d=%b | y2=%b", a, b, c, d, y2);
    $display("");
    
    // Test Part 3
    $display("Testing Part 3:");
    a = 0; b = 0; c = 0; d = 0; #1 $display("a=%b b=%b c=%b d=%b | y3=%b", a, b, c, d, y3);
    a = 0; b = 0; c = 0; d = 1; #1 $display("a=%b b=%b c=%b d=%b | y3=%b", a, b, c, d, y3);
    a = 0; b = 0; c = 1; d = 0; #1 $display("a=%b b=%b c=%b d=%b | y3=%b", a, b, c, d, y3);
    a = 0; b = 0; c = 1; d = 1; #1 $display("a=%b b=%b c=%b d=%b | y3=%b", a, b, c, d, y3);
    a = 1; b = 1; c = 0; d = 0; #1 $display("a=%b b=%b c=%b d=%b | y3=%b", a, b, c, d, y3);
    a = 1; b = 1; c = 1; d = 1; #1 $display("a=%b b=%b c=%b d=%b | y3=%b", a, b, c, d, y3);
    
    $display("");
    $display("Test completed!");
    $finish;
end

endmodule


