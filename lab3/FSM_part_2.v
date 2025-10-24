module FSM_part_2(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);

  initial begin
    q = 4'b0000; 
  end
  
always @(posedge clk) begin
    if (shift_ena) q <= {q[2:0], data};
    else if (count_ena) begin
      if (q != 4'b0000)
        q <= q - 1;
    end
  end

endmodule
