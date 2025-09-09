module sync_top(
    input clk,
    input signal,
    output signal_sync
);
    
reg [1:0]sync;

always @(posedge clk)
   sync <= { sync[0], signal };

wire signal_sync;
assign signal_sync = sync[1];

endmodule
