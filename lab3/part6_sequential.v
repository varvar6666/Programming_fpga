// Часть 6: Последовательная схема с комбинационной логикой
module part6_sequential(
    input clk,
    input reset,
    input a,
    input b,
    output state,
    output y
);

reg state_reg;

// Комбинационная логика
assign state = state_reg;
assign y = state_reg & a | b;

// Последовательная логика
always @(posedge clk) begin
    if (reset) begin
        state_reg <= 1'b0;
    end else begin
        state_reg <= a ^ b;
    end
end

endmodule
