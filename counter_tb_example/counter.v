module counter (
input clk, reset, enable,
output reg [3:0] count
);

always @ (posedge clk)
	if (reset == 1'b1)
		count <= 0;
	else if ( enable == 1'b1)
		count <= count + 1;

endmodule