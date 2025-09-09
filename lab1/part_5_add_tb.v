`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module part_5_top_tb;
	reg [31:0]a = 0,b = 0;
	reg sub = 0;
	wire [31:0]sum;

	reg[15:0] time_of_err = 16'bx;
	wire mismatch;

	reg[31:0] sum_compare = 0;
	reg isErr = 0;

	event gen_result;

	assign mismatch = (sum != sum_compare);

	part_5_top_module top0
	(
		.a(a),
		.b(b),
		.sub(sub),
		.sum(sum)
	);


	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, part_5_top_tb);		// dump variable changes in the testbench
									// and all modules under it
		
		#5 a = 1; b = 0; sum_compare = 1;
		#5 a = 2; sum_compare = 2;
		#5 b = 1; sub = 1; sum_compare = 1;
		#5 b = 2; sum_compare = 0;
		#5 a = 32'hffff; b = 1; sub = 0; sum_compare = 32'h10000;
		#5 a = 32'h10000; sub = 1; sum_compare = 32'hffff;
		#5 a = 32'hffff_ffff; b = 32'hffff_ffff; sub = 0; sum_compare = 32'hfffffffe;
		#5 -> gen_result;
	
	end

	always @(*) begin
		if (sum === 32'bz) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in high-impedance (Z) state at t=%d", $time);
		end
		if (sum === 32'bx) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in unknown (X) state at t=%d", $time);
		end
	end

	always @ (posedge mismatch) begin
		#0.1
		if (sum != sum_compare) begin
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
		$monitor("t=%-4d: a = %h, b = %h, sub = %h, s = %h", $time, a, b, sub,sum);
	end
endmodule