`timescale 1ns/1ps

module test_final;

    reg clk, reset, data, ack;
    wire counting, done;

    advanced_timer_final dut (
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
        $display("Starting test...");
        reset = 1;
        data = 0;
        ack = 0;
        
        #20;
        reset = 0;
        
        // Отправляем последовательность 1101
        $display("Sending pattern 1101...");
        data = 1; #10;
        data = 1; #10;
        data = 0; #10;
        data = 1; #10;
        
        // Отправляем 4 бита задержки (0001 = 1, что означает delay = 2)
        $display("Sending delay bits 0001...");
        data = 0; #10;
        data = 0; #10;
        data = 0; #10;
        data = 1; #10;
        
        $display("Waiting for timer to complete...");
        // Ждем завершения таймера (delay=2 -> 2000 тактов)
        repeat(2010) begin
            #10;
            if (done) begin
                $display("SUCCESS: Timer completed at time %t", $time);
                $display("Sending ACK...");
                ack = 1;
                #10;
                ack = 0;
                #10;
                $display("Test passed!");
                $finish;
            end
        end
        
        $display("ERROR: Timer did not complete in expected time");
        $finish;
    end

endmodule

