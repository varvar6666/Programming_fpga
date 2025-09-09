`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_3_top_tb;
	reg [31:0]a = 0,b = 0;
	wire [31:0]sum;

	reg[15:0] time_of_err = 0;
	wire mismatch;

	reg[31:0] sum_compare = 0;
	reg isErr = 0;

	event gen_result;

	assign mismatch = (sum != sum_compare);

	part_3_top_module top0
	(
		.a(a),
		.b(b),
		.sum(sum)
	);


	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_3_top_tb);		// dump variable changes in the testbench
									// and all modules under it
		
		#5 a = 0; b = 1; sum_compare = 1;
		#5 b = 2; sum_compare = 2;
		#5 a = 1; sum_compare = 3;
		#5 a = 32'hffff; b = 0; sum_compare = 32'hffff;
		#5 b = 1; sum_compare = 32'h10000;
		#5 b = 32'h2ccc1; sum_compare = 32'h3ccc0;
		#5 -> gen_result;
	
		
	end

	always @ (posedge mismatch) begin
		#0.1
		if (sum != sum_compare) begin
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
		$monitor("t=%-4d: a = %h, b = %h, s = %h", $time, a, b,sum);
	end
endmodule