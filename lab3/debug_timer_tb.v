`timescale 1ns/1ps

module debug_timer_tb;

reg clk;
reg reset;
reg data;
reg ack;
wire counting;
wire done;

advanced_timer_simple dut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .ack(ack),
    .counting(counting),
    .done(done)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Initialize VCD dump
    $dumpfile("out/debug_timer_tb.vcd");
    $dumpvars(0, debug_timer_tb);
    
    reset = 1;
    data = 0;
    ack = 0;
    #20 reset = 0;
    
    $display("Starting debug test...");
    
    // Отправляем паттерн 1101 по одному биту
    $display("Sending pattern 1101...");
    data = 1; #10; // Первый бит '1'
    $display("Sent bit 1, pattern_buffer should be 0001");
    
    data = 1; #10; // Второй бит '1'
    $display("Sent bit 1, pattern_buffer should be 0011");
    
    data = 0; #10; // Третий бит '0'
    $display("Sent bit 0, pattern_buffer should be 0110");
    
    data = 1; #10; // Четвертый бит '1' - паттерн найден
    $display("Sent bit 1, pattern_buffer should be 1101");
    
    // Проверяем состояние
    #10;
    $display("Current state: %b, counting: %b, done: %b", dut.state, counting, done);
    
    // Отправляем 4 бита задержки
    $display("Sending delay bits...");
    data = 0; #10; // delay[3] = 0
    data = 0; #10; // delay[2] = 0
    data = 1; #10; // delay[1] = 1
    data = 0; #10; // delay[0] = 0 -> delay = 2
    
    $display("After delay input - state: %b, shift_count: %d, counting: %b, done: %b", dut.state, dut.shift_count, counting, done);
    
    // Ждем еще один такт для перехода в COUNTING
    #10;
    $display("After one more clock - state: %b, shift_count: %d, counting: %b, done: %b", dut.state, dut.shift_count, counting, done);
    
    if (!counting) begin
        $display("ERROR: counting should be high after delay input");
        $finish;
    end
    
    $display("Test passed!");
    $finish;
end

initial begin
    $monitor("Time: %0t, Reset: %b, Data: %b, State: %b, Counting: %b, Done: %b", 
             $time, reset, data, dut.state, counting, done);
end

endmodule
