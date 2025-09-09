`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_2_top_tb;
	reg clk=1;
	always #5 clk = !clk;

	reg [7:0]d = 0;
	reg [1:0]sel = 0;
	wire [7:0]q;

	reg[15:0] time_of_err = 0;
	wire mismatch;

	reg[7:0] q_compare = 1'bx;
	reg isErr = 0;

	event gen_result;

	assign mismatch = (q != q_compare);

	part_2_top_module top0
	(
		.d(d),
		.q(q),
		.sel(sel),
		.clk(clk)
	);

	integer i;

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_2_top_tb);		// dump variable changes in the testbench
									// and all modules under it
		
		@(negedge clk);


		for (i = 0; i < 32; i = i + 1) begin
			@(posedge clk);
			if (i < 16) begin
				d <= i;	
				if ((i%4 == 0)&&(i != 0))
					sel = sel + 1;
			end
			else
				d <= 0;

			if (i < 4)
				q_compare <= i;
			else if (i < 8)
				q_compare <= i - 1;
			else if (i < 12)
				q_compare <= i - 2;
			else if (i < 19)
				q_compare <= i - 3;
			else
				q_compare <= 0;
		end
	
		@(posedge clk); 
		-> gen_result;
	
		
	end

	always @ (posedge mismatch) begin
		#0.1
		if (q != q_compare) begin
			isErr = 1;
			time_of_err = time_of_err == 0 ? $time : time_of_err;
		end
	end

	initial begin
		@ (gen_result) begin
			$display ("###################################################");

			if (isErr) begin
				$display("Result: FAIL");
				$display("First error at t=%-4d", time_of_err);
			end else
				$display("Result: PASS");
			$display ("###################################################");
			$finish;
		end
	end

	initial begin
		$monitor("t=%-4d: d = %d, q = %d", $time, d, q);
	end
endmodule