`timescale 1ns/1ps

module pattern_detector_1101_tb;

reg clk;
reg reset;
reg data_in;
wire start_shifting;

pattern_detector_1101 dut (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .start_shifting(start_shifting)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1;
    data_in = 0;
    #20 reset = 0;
    
    // Тест 1: Корректная последовательность 1101
    $display("Test 1: Correct pattern 1101");
    data_in = 1; #10; // S1
    data_in = 1; #10; // S2
    data_in = 0; #10; // S3
    data_in = 1; #10; // S4 - должен установить start_shifting
    
    if (!start_shifting) begin
        $display("ERROR: start_shifting should be high after pattern 1101");
        $finish;
    end
    
    #10; // Возврат в IDLE
    if (start_shifting) begin
        $display("ERROR: start_shifting should be low after returning to IDLE");
        $finish;
    end
    
    // Тест 2: Неправильная последовательность 1100
    $display("Test 2: Incorrect pattern 1100");
    data_in = 1; #10; // S1
    data_in = 1; #10; // S2
    data_in = 0; #10; // S3
    data_in = 0; #10; // IDLE
    
    if (start_shifting) begin
        $display("ERROR: start_shifting should be low for pattern 1100");
        $finish;
    end
    
    // Тест 3: Последовательность с прерыванием 1101
    $display("Test 3: Pattern with interruption");
    data_in = 1; #10; // S1
    data_in = 1; #10; // S2
    data_in = 0; #10; // S3
    data_in = 0; #10; // IDLE (прерывание)
    data_in = 1; #10; // S1
    
    if (start_shifting) begin
        $display("ERROR: start_shifting should be low after interruption");
        $finish;
    end
    
    // Тест 4: Множественные последовательности
    $display("Test 4: Multiple patterns");
    data_in = 1; #10; // S1
    data_in = 1; #10; // S2
    data_in = 0; #10; // S3
    data_in = 1; #10; // S4 - start_shifting = 1
    #10; // IDLE
    data_in = 1; #10; // S1
    data_in = 1; #10; // S2
    data_in = 0; #10; // S3
    data_in = 1; #10; // S4 - start_shifting = 1
    
    if (!start_shifting) begin
        $display("ERROR: start_shifting should be high for second pattern");
        $finish;
    end
    
    #10; // IDLE
    
    $display("All tests passed!");
    $finish;
end

initial begin
    $monitor("Time: %0t, Reset: %b, Data_in: %b, Start_shifting: %b", 
             $time, reset, data_in, start_shifting);
end

endmodule
