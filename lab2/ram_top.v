module ram_top #(parameter N = 6, M = 32)
    (input clk,
    input we,
    input [N-1:0] adr,
    input [M-1:0] din,
    output [M-1:0] dout);
    
    reg [M-1:0] mem [2**N-1:0];
    
    assign dout = adr == 0 ? 0 : mem[adr];
    
    always @(posedge clk)
        if (we && (adr != {N{1'b0}})) mem [adr] <= din;
        

endmodule
