module counter_0_999(
    input clk,
    input reset,
    output reg [9:0] count
);

always @(posedge clk) begin
    if (reset) begin
        count <= 10'd0;
    end else begin
        if (count == 10'd999) begin
            count <= 10'd0;
        end else begin
            count <= count + 1'b1;
        end
    end
end

endmodule
