module alu_top (
    input [31:0] a_i,
    input [31:0] b_i,
    input [4:0] op_i,
    output reg [31:0] result_o,
    output reg flag_o
);

always @(*) begin
    result_o = 32'b0;
    flag_o = 1'b0;
    case (op_i)
        5'b00000: result_o = a_i + b_i;  // ADD
        5'b10000: result_o = a_i - b_i;  // SUB
        5'b00001: result_o = a_i << (b_i[4:0]);  // SLL
        5'b00010: result_o = 32'($signed(a_i) < $signed(b_i));  // SLTS
        5'b00011: result_o = 32'(a_i < b_i);  // SLTU
        5'b00100: result_o = a_i ^ b_i;  // XOR
        5'b00101: result_o = a_i >> (b_i[4:0]);  // SRL
        5'b01101: result_o = $signed(a_i) >>> (b_i[4:0]);  // SRA
        5'b00110: result_o = a_i | b_i;  // OR
        5'b00111: result_o = a_i & b_i;  // AND
        5'b11000: flag_o = 1'(a_i == b_i);  // EQ
        5'b11001: flag_o = 1'(a_i != b_i);  // NE
        5'b11100: flag_o = 1'($signed(a_i) < $signed(b_i));  // LTS
        5'b11101: flag_o = 1'($signed(a_i) >= $signed(b_i));  // GES
        5'b11110: flag_o = 1'(a_i < b_i);  // LTU
        5'b11111: flag_o = 1'(a_i >= b_i);  // GEU
        default: begin
            result_o = 32'b0;
            flag_o = 1'b0;
        end
    endcase
end

endmodule
