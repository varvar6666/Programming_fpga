`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module full_add_3b_tb;

	reg [2:0] a = 0, b = 0;
	reg carry = 0;
	wire [2:0] sum, carry_out;

	reg[15:0] time_of_err = 16'bx;
	wire mismatch;

	reg[2:0] sum_compare = 0, carry_out_compare = 0;
	reg isErr = 0;

	event gen_result;

	assign mismatch = (sum ^ sum_compare) || (carry_out ^ carry_out_compare);

	full_add_3b full_add_mod0
	(
		.a(a),
		.b(b),
		.cin(carry),
		.cout(carry_out),
		.sum(sum)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, full_add_3b_tb);		// dump variable changes in the testbench
									// and all modules under it

		#5 a = 2; b = 3; sum_compare = 5; carry_out_compare = 2;
		#5 carry = 1; sum_compare = 6; carry_out_compare = 3;
		#5 b = 2; carry = 0; sum_compare = 4; carry_out_compare = 2;
		#5 a = 0; b = 0; carry = 1; sum_compare = 1; carry_out_compare = 0;
		#5 b = 4; sum_compare = 5; carry_out_compare = 0;
		#5 a = 6; b = 1; sum_compare = 0; carry_out_compare = 7;
		#5 a = 0; b = 6; sum_compare = 7; carry_out_compare = 0;
		#5 a = 6; b = 2; sum_compare = 1; carry_out_compare = 6;
		#5 a = 1; b = 1; carry = 0; sum_compare = 2; carry_out_compare = 1;
		#5 a = 0; b = 0; carry = 1; sum_compare = 1; carry_out_compare = 0;
		#5 b = 6; sum_compare = 7; carry_out_compare = 0;
		#5 a = 7; b = 3; carry = 0; sum_compare = 2; carry_out_compare = 7;
		#5 -> gen_result;


	
	end

	always @(*) begin
		if (sum === 3'bz) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in high-impedance (Z) state at t=%d", $time);
		end
		if (sum === 3'bx) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in unknown (X) state at t=%d", $time);
		end
	end


	always @ (posedge mismatch) begin
		#0.1; // Для иммитации синхронизатора, учитывая что провода передают сигнал почти без задержек, в отличии от регистров
		if ((sum ^ sum_compare) || (carry_out ^ carry_out_compare)) begin
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
		$monitor("t=%-4d: cout = %d, sum = %d", $time, carry_out, sum);
	end
endmodule