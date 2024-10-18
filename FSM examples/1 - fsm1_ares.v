/*
This is a Moore state machine with two states, one input, and one output. 

				  B						 A
			┌───────────┐	 0 		┌───────────┐
			│			│----------→|			|
-----------→│	out=1	│			|	out=0	|
areset		│			│←----------|			|
			└───────────┘	 0 		└───────────┘
				↑	|					↑	|
				|	|					|	|
				└───┘					└───┘
				  1						  1		

 _____
  **This is a TFF with the T input inverted.


In this example we have 2 always blocks, one - combinational - for state transition logic, second - sequential - for the reset.
Output given outside from always blocks.

*/

module top_module(
	input clk,
	input areset,	// Asynchronous reset to state B
	input in,
	output out);

	parameter A=1'b0, B=1'b1; 
	reg state, next_state;

	always @(*) begin	// This is a combinational always block
		// State transition logic
		 case(state)
			A:begin
				if(in)
					next_state = A;
				else
					next_state = B;
			end
			B:begin
				if(!in)
					next_state = A;
				else
					next_state = B;
			end
		endcase
	end

	always @(posedge clk, posedge areset) begin	// This is a sequential always block
		// State flip-flops with asynchronous reset
		if(areset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	assign out = state;
	// assign out = (state == B) ? 1 : 0;

endmodule
