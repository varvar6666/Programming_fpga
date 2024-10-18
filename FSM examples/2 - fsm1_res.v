/*
This is a Moore state machine with two states, one input, and one output. 

				  B						 A
			┌───────────┐	 0 		┌───────────┐
			│			│----------→|			|
-----------→│	out=1	│			|	out=0	|
 reset		│			│←----------|			|
			└───────────┘	 0 		└───────────┘
				↑	|					↑	|
				|	|					|	|
				└───┘					└───┘
				  1						  1		

 _____
  **This is a TFF with the T input inverted.

In this example we have one always block for FSM, but 2 case's, one for FSM logic, second for output logic.

*/
module top_module(clk, reset, in, out);
	input clk;
	input reset;    // Synchronous reset to state B
	input in;
	output out;//  
	reg out;

	// State name declarations
	parameter A=0, B=1; 
	reg present_state, next_state;

	always @(posedge clk) begin
		if (reset) begin  
			// Reset logic
			if(reset) begin
			   present_state = B;
				out <= 1'b1;
			//   next_state <= B;
			end
		end else begin
			case (present_state)
				// State transition logic
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

			// State flip-flops
			present_state = next_state;   

			case (present_state)
				// Output logic
				B : out <= 1'b1;
				default : out <= 1'b0;
			endcase
		end
	end

endmodule
