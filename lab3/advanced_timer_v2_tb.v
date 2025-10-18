`timescale 1ns/1ps

module advanced_timer_v2_tb;

reg clk;
reg reset;
reg data;
reg ack;
wire counting;
wire done;

advanced_timer_v2 dut (
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
    reset = 1;
    data = 0;
    ack = 0;
    #20 reset = 0;
    
    // Тест 1: Полный цикл работы таймера
    $display("Test 1: Full timer cycle");
    
    // Отправляем паттерн 1101
    data = 1; #10; // Первый бит '1'
    data = 1; #10; // Второй бит '1'
    data = 0; #10; // Третий бит '0'
    data = 1; #10; // Четвертый бит '1' - паттерн найден
    
    // Отправляем 4 бита задержки (delay = 2)
    data = 0; #10; // delay[3] = 0
    data = 0; #10; // delay[2] = 0
    data = 1; #10; // delay[1] = 1
    data = 0; #10; // delay[0] = 0 -> delay = 2
    
    // Проверяем, что начался счет
    if (!counting) begin
        $display("ERROR: counting should be high after delay input");
        $finish;
    end
    
    // Ждем завершения счета (delay=2, значит (2+1)*1000 = 3000 тактов)
    repeat(3000) #10;
    
    // Проверяем, что счет завершен
    if (counting) begin
        $display("ERROR: counting should be low after timer completion");
        $finish;
    end
    
    if (!done) begin
        $display("ERROR: done should be high after timer completion");
        $finish;
    end
    
    // Отправляем подтверждение
    ack = 1;
    #10;
    ack = 0;
    
    // Проверяем возврат в начальное состояние
    if (done) begin
        $display("ERROR: done should be low after ack");
        $finish;
    end
    
    // Тест 2: Таймер с delay = 0
    $display("Test 2: Timer with delay = 0");
    
    // Отправляем паттерн 1101
    data = 1; #10;
    data = 1; #10;
    data = 0; #10;
    data = 1; #10;
    
    // Отправляем delay = 0
    data = 0; #10;
    data = 0; #10;
    data = 0; #10;
    data = 0; #10;
    
    // Ждем завершения счета (delay=0, значит (0+1)*1000 = 1000 тактов)
    repeat(1000) #10;
    
    if (!done) begin
        $display("ERROR: done should be high after delay=0 timer completion");
        $finish;
    end
    
    ack = 1;
    #10;
    ack = 0;
    
    $display("All tests passed!");
    $finish;
end

initial begin
    $monitor("Time: %0t, Reset: %b, Data: %b, Ack: %b, Counting: %b, Done: %b", 
             $time, reset, data, ack, counting, done);
end

endmodule
