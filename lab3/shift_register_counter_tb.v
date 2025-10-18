`timescale 1ns/1ps

module shift_register_counter_tb;

reg clk;
reg shift_ena;
reg count_ena;
reg data_in;
wire [3:0] data_out;

shift_register_counter dut (
    .clk(clk),
    .shift_ena(shift_ena),
    .count_ena(count_ena),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    shift_ena = 0;
    count_ena = 0;
    data_in = 0;
    
    // Тест сдвига
    $display("Testing shift functionality...");
    shift_ena = 1;
    data_in = 1;
    #10; // Сдвигаем первый бит
    data_in = 0;
    #10; // Сдвигаем второй бит
    data_in = 1;
    #10; // Сдвигаем третий бит
    data_in = 1;
    #10; // Сдвигаем четвертый бит
    
    if (data_out != 4'b1011) begin
        $display("ERROR: Expected 1011, got %b", data_out);
        $finish;
    end
    
    shift_ena = 0;
    #10;
    
    // Тест обратного счета
    $display("Testing count down functionality...");
    count_ena = 1;
    #10; // 1011 -> 1010
    if (data_out != 4'b1010) begin
        $display("ERROR: Expected 1010, got %b", data_out);
        $finish;
    end
    
    #10; // 1010 -> 1001
    if (data_out != 4'b1001) begin
        $display("ERROR: Expected 1001, got %b", data_out);
        $finish;
    end
    
    #10; // 1001 -> 1000
    if (data_out != 4'b1000) begin
        $display("ERROR: Expected 1000, got %b", data_out);
        $finish;
    end
    
    // Тест перехода через 0
    #10; // 1000 -> 0111
    #10; // 0111 -> 0110
    #10; // 0110 -> 0101
    #10; // 0101 -> 0100
    #10; // 0100 -> 0011
    #10; // 0011 -> 0010
    #10; // 0010 -> 0001
    #10; // 0001 -> 0000
    #10; // 0000 -> 1111
    
    if (data_out != 4'b1111) begin
        $display("ERROR: Expected 1111 after wraparound, got %b", data_out);
        $finish;
    end
    
    count_ena = 0;
    #10;
    
    $display("All tests passed!");
    $finish;
end

initial begin
    $monitor("Time: %0t, Shift_ena: %b, Count_ena: %b, Data_in: %b, Data_out: %b", 
             $time, shift_ena, count_ena, data_in, data_out);
end

endmodule
