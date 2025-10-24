`timescale 1ns/1ps

module debug_telay_tb;

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
    $dumpfile("out/debug_delay_tb.vcd");
    $dumpvars(0, debug_delay_tb);
    
    reset = 1;
    data = 0;
    ack = 0;
    #20 reset = 0;
    
    $display("Starting debug test with delay = 0...");
    
    // Отправляем паттерн 1101
    data = 1; #10; // Первый бит '1'
    data = 1; #10; // Второй бит '1'
    data = 0; #10; // Третий бит '0'
    data = 1; #10; // Четвертый бит '1' - паттерн найден
    
    // Отправляем 4 бита задержки (delay = 0)
    data = 0; #10; // delay[3] = 0
    data = 0; #10; // delay[2] = 0
    data = 0; #10; // delay[1] = 0
    data = 0; #10; // delay[0] = 0 -> delay = 0
    
    // Ждем дополнительный такт для перехода в COUNTING
    #10;
    #10;
    
    $display("State: %b, Timer_count: %d, Delay_value: %d, Counting: %b, Done: %b", dut.state, dut.timer_count, dut.delay_value, counting, done);
    
    // Ждем завершения счета (delay=0, значит (0+1)*1000 = 1000 тактов)
    $display("Waiting for timer completion...");
    repeat(1000) #10;
    
    $display("After timer completion - State: %b, Timer_count: %d, Delay_value: %d, Counting: %b, Done: %b", dut.state, dut.timer_count, dut.delay_value, counting, done);
    
    if (counting) begin
        $display("ERROR: counting should be low after completion");
        $finish;
    end
    
    if (!done) begin
        $display("ERROR: done should be high after completion");
        $finish;
    end
    
    $display("Test passed!");
    $finish;
end

initial begin
    $monitor("Time: %0t, Reset: %b, Data: %b, State: %b, Timer_count: %d, Delay_value: %d, Counting: %b, Done: %b", 
             $time, reset, data, dut.state, dut.timer_count, dut.delay_value, counting, done);
end

endmodule
