module rom_top(input [1:0] adr,
    output [3:0] dout);
    
    reg [3:0] dout_r;
    assign dout = dout_r;
    
    always @(*)
        case(adr)
            0: dout_r = 4'b1010;
            1: dout_r = 4'b1110;
            2: dout_r = 4'b0001;
            3: dout_r = 4'b1101;
            default: dout_r = 4'bxxxx;
        endcase
endmodule
