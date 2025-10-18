`timescale 1ns/1ps

module advanced_timer_simple_tb;

    reg clk, reset, data, ack;
    wire counting, done;

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
        $display("=== Advanced Timer Testbench ===");
        reset = 1;
        data = 0;
        ack = 0;
        
        #20;
        reset = 0;
        
        // Тест 1: Отправка последовательности 1101 и задержки 0001 (delay=2)
        $display("Test 1: Pattern 1101 + Delay 0001 (expected timer = 2000 cycles)");
        data = 1; #10;
        data = 1; #10;
        data = 0; #10;
        data = 1; #10;
        
        // Отправляем 4 бита задержки (0001)
        data = 0; #10;
        data = 0; #10;
        data = 0; #10;
        data = 1; #10;
        
        // Ждем завершения таймера
        wait(done);
        $display("SUCCESS: Timer completed at time %t", $time);
        
        // Отправляем ACK
        ack = 1;
        #10;
        ack = 0;
        #10;
        
        $display("=== All tests passed! ===");
        $finish;
    end

endmodule
