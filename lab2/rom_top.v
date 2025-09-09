module rom_top(input [1:0] adr,
    output reg [3:0] dout);
    
    always @(*)
        case(adr)
            0: dout = 4'b1010;
            1: dout = 4'b1110;
            2: dout = 4'b0001;
            3: dout = 4'b1101;
            default: dout = 4'bxxxx;
        endcase
endmodule
