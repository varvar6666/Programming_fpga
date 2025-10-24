module part_4(
    input clock,
    input a,
    output reg p,
    output reg q
);
    
always @(*)begin
        if(clock)
            p = a;
        else
            p = p;
    end

    always @(negedge clock) begin
            q <= p;
    end

endmodule
