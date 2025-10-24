module part_1(
    input a, b, c, d,
    output q
);
    
assign q = (a | b) & (c | d);

endmodule
