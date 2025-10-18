module shift_register_counter(
    input clk,
    input shift_ena,
    input count_ena,
    input data_in,
    output reg [3:0] data_out
);

always @(posedge clk) begin
    if (shift_ena) begin
        // Сдвиг данных MSB first
        data_out <= {data_out[2:0], data_in};
    end else if (count_ena) begin
        // Обратный счет
        if (data_out == 4'd0) begin
            data_out <= 4'd15; // Переход к максимальному значению
        end else begin
            data_out <= data_out - 1'b1;
        end
    end
end

endmodule
