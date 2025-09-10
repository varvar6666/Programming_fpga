`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module full_add_tb;

	reg a = 0, b = 0, carry = 0;
	wire sum, carry_out;

	reg[15:0] time_of_err = 16'bx;
	wire mismatch;

	reg sum_compare = 0, carry_out_compare = 0;
	reg isErr = 0;

	event gen_result;

	assign mismatch = (sum ^ sum_compare) || (carry_out ^ carry_out_compare);

	full_add full_add_mod0
	(
		.a(a),
		.b(b),
		.cin(carry),
		.cout(carry_out),
		.sum(sum)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, full_add_tb);		// dump variable changes in the testbench
									// and all modules under it

		#5 b = 1; sum_compare = 1; carry_out_compare = 0;
		#5 a = 1; b = 0; sum_compare = 1; carry_out_compare = 0;
		#5 b = 1; sum_compare = 0; carry_out_compare = 1;
		#5 a = 0; b = 0; sum_compare = 0; carry_out_compare = 0;
		#5 carry = 1; sum_compare = 1; carry_out_compare = 0;
		#5 a = 1; sum_compare = 0; carry_out_compare = 1;
		#5 a = 0; b = 1; sum_compare = 0; carry_out_compare = 1;
		#5 -> gen_result;


	end

	always @(*) begin
		if (sum === 1'bz) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in high-impedance (Z) state at t=%d", $time);
		end
		if (sum === 1'bx) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in unknown (X) state at t=%d", $time);
		end
	end

	always @ (posedge mismatch) begin
		if (((sum ^ sum_compare) || (carry_out ^ carry_out_compare))) begin
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
		$monitor("t=%-4d: sum = %d, cout = %d", $time, sum, carry_out);
	end
endmodule