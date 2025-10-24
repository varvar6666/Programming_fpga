module part_5(
    input a, clk,
    output reg [2:0] q
);
    
    reg [2:0] next_q;

    always @(*) begin
        next_q = (q == 6) ? 0 : q + 1;
    end

    always @(posedge clk) begin
        if (a) q <= 4; // Останавливаем счетчик на 4 
        else q <= next_q;
    end

endmodule
