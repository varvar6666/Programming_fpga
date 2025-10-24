module part_6(
    input clk,
    input a,
    input b,
    output reg q,   
    output reg state 
);
    
    always @(*) begin
            q = a ^ b ^ state; 
        end

    always @(posedge clk) begin
            if(a == b)
                state <= a;
            else
                state <= state;
        end

    initial begin
        state = 0;
        q = 0;
    end
    
endmodule
