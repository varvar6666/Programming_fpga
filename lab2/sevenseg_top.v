module sevenseg_top(input [3:0] data,
    output [6:0] segments);
    
    reg [6:0] segments_r;
    assign segments = segments_r;
    
    always @(*)
        case(data)
            0: segments_r = 7'b111_1110;
            1: segments_r = 7'b011_0000;
            2: segments_r = 7'b110_1101;
            3: segments_r = 7'b111_1001;
            4: segments_r = 7'b011_0011;
            5: segments_r = 7'b101_1011;
            6: segments_r = 7'b101_1111;
            7: segments_r = 7'b111_0000;
            8: segments_r = 7'b111_1111;
            9: segments_r = 7'b111_0011;
            default: segments_r = 7'b000_0000;
        endcase
endmodule
