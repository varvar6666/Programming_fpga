// Часть 4: Последовательная схема
module part4_sequential(
    input clk,
    input reset,
    input d,
    output reg q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 1'b0;
    end else begin
        q <= d;
    end
end

endmodule
