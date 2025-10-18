`timescale 1ns/1ps

module simple_debug_tb;

    reg clk, reset, data, ack;
    wire counting, done;
    wire [2:0] state;
    wire [9:0] timer_count;
    wire [3:0] delay_value;

    advanced_timer_simple dut (
        .clk(clk),
        .reset(reset),
        .data(data),
        .ack(ack),
        .counting(counting),
        .done(done),
        .state(state),
        .timer_count(timer_count),
        .delay_value(delay_value)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        data = 0;
        ack = 0;
        
        #20;
        reset = 0;
        
        // Отправляем последовательность 1101
        data = 1; #10;
        data = 1; #10;
        data = 0; #10;
        data = 1; #10;
        
        // Отправляем 4 бита задержки (0001 = 1)
        data = 0; #10;
        data = 0; #10;
        data = 0; #10;
        data = 1; #10;
        
        // Ждем завершения таймера
        repeat(1005) begin
            #10;
            $display("Time: %t, State: %b, Timer_count: %d, Delay_value: %d, Condition: %b", 
                     $time, state, timer_count, delay_value, (timer_count >= delay_value * 1000));
            if (state == 3'b011) begin
                $display("SUCCESS: Timer completed and transitioned to DONE_STATE");
                $finish;
            end
        end
        
        if (state != 3'b011) begin
            $display("ERROR: Timer did not complete. State: %b, Timer_count: %d, Delay_value: %d", 
                     state, timer_count, delay_value);
        end
        
        $finish;
    end

endmodule
