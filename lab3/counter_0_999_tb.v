`timescale 1ns/1ps

module counter_0_999_tb;

reg clk;
reg reset;
wire [9:0] count;

counter_0_999 dut (
    .clk(clk),
    .reset(reset),
    .count(count)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1;
    #20 reset = 0;
    
    // Проверяем несколько циклов счета
    repeat(3) begin
        wait(count == 10'd999);
        #20; // Ждем два такта для сброса
        if (count != 10'd0) begin
            $display("ERROR: Counter did not reset to 0 after reaching 999");
            $finish;
        end
    end
    
    // Проверяем сброс в середине счета
    #1000;
    reset = 1;
    #10;
    if (count != 10'd0) begin
        $display("ERROR: Counter did not reset to 0 on reset signal");
        $finish;
    end
    
    reset = 0;
    #50;
    
    $display("All tests passed!");
    $finish;
end

initial begin
    $monitor("Time: %0t, Reset: %b, Count: %d", $time, reset, count);
end

endmodule
