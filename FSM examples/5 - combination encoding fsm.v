/*
The following is the state transition table for a Moore state machine with one input, one output, and four states.
State encoding: A=2'b00, B=2'b01, C=2'b10, D=2'b11. 

State transition table:
┌───────┬─────────────┬─────────┐
│ 		| Next state  |			│
│ State	├─────────────┤	Output	│
│		| in=0 | in=1 |			│
├───────┼──────┼──────┼─────────┤
│  A	│  A   |  B	  |	  0		│
│  B	│  C   |  B	  |	  0		│
│  C	│  A   |  D	  |	  0		│
│  D	│  C   |  B	  |	  1		│
└───────┴──────┴──────┴─────────┘

For the example here we used functions for state transition and output logic.
*/
module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: 
    assign next_state = nxt(state, in);

    // Output logic for a Moore state machine:  \
    assign out = ot(state);
    
    function [1:0] nxt(input [1:0] st, input i);
        case(st)
            A:if(i) nxt = B; 
            else nxt = A;
            B:if(i) nxt = B; 
            else nxt = C;
            C:if(i) nxt = D; 
            else nxt = A;
            D:if(i) nxt = B; 
            else nxt = C;
        endcase
    endfunction
    
    function automatic ot(input [1:0] st);
            if(st == D)
                ot = 1'b1; 
            else
                ot = 1'b0; 
    endfunction
  
endmodule