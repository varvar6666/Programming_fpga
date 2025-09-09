`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_1_top_tb;
	reg clk=1;
	always #5 clk = !clk;

	reg d = 0;
	wire q;

	reg[15:0] time_of_err = 16'bx;
	wire mismatch;

	reg q_compare = 0;
	reg isErr = 0;

	event gen_result;

	assign mismatch = (q != q_compare);

	part_1_top_module top0
	(
		.d(d),
		.q(q),
		.clk(clk)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_1_top_tb);		// dump variable changes in the testbench
									// and all modules under it
		q_compare <= 1'bx;
		@(posedge clk);
		@(posedge clk);
		d <= 1;
		@(posedge clk);
		q_compare <= 0;
		@(posedge clk);
		d <= 0;
		@(posedge clk);
		q_compare <= 1;
		@(posedge clk);
		@(posedge clk);
		d <= 1;
		q_compare <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		d <= 0;
		q_compare <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		q_compare <= 0;
		@(posedge clk);
		@(posedge clk);

		// #10 d = 1;
		// #5 d = 1;
		// #5 d = 0;
		// #5 d = 1;
		// #5 d = 1;
		// #5 d = 0;

		@(posedge clk); 
		-> gen_result;
	
		
	end

	always @(*) begin
		if (q === 1'bz) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in high-impedance (Z) state at t=%d", $time);
		end
		if (q === 1'bx) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in unknown (X) state at t=%d", $time);
		end
	end

	always @ (posedge mismatch) begin
		#0.1
		if (q != q_compare) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
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