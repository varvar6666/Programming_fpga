/*
This is a Moore state machine with two states, two inputs, and one output.

				OFF						 ON
			┌───────────┐	 j=1	┌───────────┐
			│			│----------→|			|
-----------→│	out=0	│			|	out=1	|
 areset		│			│←----------|			|
			└───────────┘	 k=1	└───────────┘
				↑	|					↑	|
				|	|					|	|
				└───┘					└───┘
				 j=0					 k=0

 _____
  **This is a JK flip-flop.

*/
module top_module(
	input clk,
	input areset,    // Asynchronous reset to OFF
	input j,
	input k,
	output out); //  

	parameter OFF=0, ON=1; 
	reg state, next_state;

	always @(*) begin
		// State transition logic
				case(state)
			OFF:begin
				if(j)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON:begin
				if(!k)
					next_state = ON;
				else
					next_state = OFF;
			end
		endcase
	end

	always @(posedge clk, posedge areset) begin
		// State flip-flops with asynchronous reset
		if(areset)
			state <= OFF;
		else
			state <= next_state;    
	end

	// Output logic
	assign out = state;
	// assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
