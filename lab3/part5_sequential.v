// Часть 5: Последовательная схема
module part5_sequential(
    input clk,
    input reset,
    input j,
    input k,
    output reg q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 1'b0;
    end else begin
        case ({j, k})
            2'b00: q <= q;      // Сохранение состояния
            2'b01: q <= 1'b0;   // Сброс
            2'b10: q <= 1'b1;   // Установка
            2'b11: q <= ~q;     // Инверсия
        endcase
    end
end

endmodule
