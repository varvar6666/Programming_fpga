module lut_top (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z 
);
    
    reg [7:0] Q;
    
    assign Z = Q[{A, B, C}];
   	
    always @(posedge clk) begin
        
        if (enable) Q <= {Q[6:0], S};
       
    end
endmodule
