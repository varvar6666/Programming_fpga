`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module FSM_part_4_tb;

    reg clk;
    reg reset;
    reg data;
    reg done_counting;
    reg ack;
    wire [3:0] cnt;
    wire counting, done;

    FSM_part_4 uut (
        .clk(clk),
        .reset(reset),
        .data(data),
        .done_counting(done_counting),
        .ack(ack),
        .counting(counting),
        .done(done),
        .cnt(cnt)
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #10 reset <= 0;
    end
    initial begin
        #20150 ack <= 1;
        #10 ack <= 0;
    end
    initial begin
        #20160 data <= 1;
        #20 data <= 0;
        #10 data <= 1;
        #40 data <= 0;
    end
    initial begin   
        $dumpfile("out/FSM_part_4_tb.vcd");       // create a VCD waveform dump called "wave.vcd"
        $dumpvars(0, uut);           // dump variable changes in the testbench
                                     // and all modules under it
        done_counting = 0;
        data = 0;
        #10 data <= 1;
        #10 data <= 0;
        #20 data <= 1;
        #20 data <= 0;
        #10 data <= 1;
        #10 data <= 0;
        #30 data <= 1;
        #10 data <= 'x;
        #25000 $finish;
    end

    initial begin
        $monitor("Time: %0t | clk: %b | reset: %b | dat a: %b | cnt: %b | counting: %b | done = %b | ack = %b", $time, clk, reset, data, cnt, counting, done, ack);
    end

endmodule
