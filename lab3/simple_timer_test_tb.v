`timescale 1ns/1ps

module simple_timer_test_tb;

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
    $dumpfile("out/simple_timer_test_tb.vcd");
    $dumpvars(0, simple_timer_test_tb);
    
    reset = 1;
    data = 0;
    ack = 0;
    #20 reset = 0;
    
    $display("Starting simple timer test...");
    
    // Отправляем паттерн 1101
    $display("Sending pattern 1101...");
    data = 1; #10; // Первый бит '1'
    data = 1; #10; // Второй бит '1'
    data = 0; #10; // Третий бит '0'
    data = 1; #10; // Четвертый бит '1' - паттерн найден
    
    // Отправляем 4 бита задержки (delay = 1)
    $display("Sending delay bits (delay = 1)...");
    data = 0; #10; // delay[3] = 0
    data = 0; #10; // delay[2] = 0
    data = 0; #10; // delay[1] = 0
    data = 1; #10; // delay[0] = 1 -> delay = 1
    
    // Ждем дополнительный такт для перехода в COUNTING
    #10;
    
    // Ждем еще один такт для завершения сдвига
    #10;
    
    $display("State: %b, Counting: %b, Done: %b", dut.state, counting, done);
    
    if (!counting) begin
        $display("ERROR: counting should be high");
        $finish;
    end
    
    // Ждем завершения счета (delay=1, значит (1+1)*1000 = 2000 тактов)
    $display("Waiting for timer completion...");
    repeat(2000) #10;
    
    $display("After timer completion - State: %b, Timer_count: %d, Delay_value: %d, Counting: %b, Done: %b", dut.state, dut.timer_count, dut.delay_value, counting, done);
    
    if (counting) begin
        $display("ERROR: counting should be low after completion");
        $finish;
    end
    
    if (!done) begin
        $display("ERROR: done should be high after completion");
        $finish;
    end
    
    // Отправляем подтверждение
    $display("Sending ack...");
    ack = 1;
    #10;
    ack = 0;
    
    $display("After ack - State: %b, Counting: %b, Done: %b", dut.state, counting, done);
    
    if (done) begin
        $display("ERROR: done should be low after ack");
        $finish;
    end
    
    $display("All tests passed!");
    $finish;
end

initial begin
    $monitor("Time: %0t, Reset: %b, Data: %b, Ack: %b, State: %b, Counting: %b, Done: %b", 
             $time, reset, data, ack, dut.state, counting, done);
end

endmodule
