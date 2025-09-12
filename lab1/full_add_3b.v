module full_add_3b( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

	// write code here
    // Младший бит (bit 0)
    assign sum[0] = a[0] ^ b[0] ^ cin;
    assign cout[0] = (a[0] & b[0]) | (a[0] & cin) | (b[0] & cin);
    
    // Средний бит (bit 1)
    assign sum[1] = a[1] ^ b[1] ^ cout[0];
    assign cout[1] = (a[1] & b[1]) | (a[1] & cout[0]) | (b[1] & cout[0]);
    
    // Старший бит (bit 2)
    assign sum[2] = a[2] ^ b[2] ^ cout[1];
    assign cout[2] = (a[2] & b[2]) | (a[2] & cout[1]) | (b[2] & cout[1]);
endmodule
