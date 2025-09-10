`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution

module chip_7458_tb;

	reg p1a = 0,p1b = 0,p1c = 0,p1d = 0,p1e = 0,p1f = 0;
	reg p2a = 0,p2b = 0,p2c = 0,p2d = 0;
	reg[15:0] time_of_err;
	wire p1y, p2y;
	wire mismatch;
	

	reg p1y_compare = 0, p2y_compare = 0;
	reg isErr;

	chip_7458 chip_7458_mod0
	(
		.p1a(p1a),
		.p1b(p1b),
		.p1c(p1c),
		.p1d(p1d),
		.p1e(p1e),
		.p1f(p1f),
		.p2a(p2a),
		.p2b(p2b),
		.p2c(p2c),
		.p2d(p2d),
		.p1y(p1y),
		.p2y(p2y)
	);

	event gen_result;

	assign mismatch = (p1y ^ p1y_compare) || (p2y ^ p2y_compare);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, chip_7458_tb);		// dump variable changes in the testbench
									// and all modules under it
		isErr = 0; time_of_err = 16'bx;



		#5;p1a=0; p1b=0; p1c=0; p1d=0; p1e=0; p1f=0; p2a=0; p2b=0; p2c=0; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=0; p1c=0; p1d=0; p1e=0; p1f=0; p2a=0; p2b=0; p2c=0; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=0; p1c=1; p1d=0; p1e=0; p1f=0; p2a=0; p2b=0; p2c=0; p2d=1; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=1; p1c=0; p1d=0; p1e=0; p1f=1; p2a=0; p2b=0; p2c=1; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=1; p1c=1; p1d=0; p1e=0; p1f=1; p2a=0; p2b=0; p2c=1; p2d=1; p1y_compare = 0; p2y_compare = 1;
		#5;p1a=0; p1b=0; p1c=0; p1d=0; p1e=0; p1f=0; p2a=0; p2b=1; p2c=0; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=1; p1b=0; p1c=1; p1d=0; p1e=1; p1f=0; p2a=0; p2b=1; p2c=0; p2d=1; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=1; p1b=1; p1c=0; p1d=0; p1e=1; p1f=1; p2a=0; p2b=1; p2c=1; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=1; p1b=1; p1c=1; p1d=0; p1e=1; p1f=1; p2a=0; p2b=1; p2c=1; p2d=1; p1y_compare = 1; p2y_compare = 1;
		#5;p1a=1; p1b=0; p1c=0; p1d=1; p1e=1; p1f=0; p2a=1; p2b=0; p2c=0; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=0; p1c=1; p1d=1; p1e=0; p1f=0; p2a=1; p2b=0; p2c=0; p2d=1; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=1; p1c=0; p1d=1; p1e=0; p1f=1; p2a=1; p2b=0; p2c=1; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=1; p1c=1; p1d=1; p1e=0; p1f=1; p2a=1; p2b=0; p2c=1; p2d=1; p1y_compare = 0; p2y_compare = 1;
		#5;p1a=0; p1b=0; p1c=0; p1d=1; p1e=0; p1f=0; p2a=1; p2b=1; p2c=0; p2d=0; p1y_compare = 0; p2y_compare = 1;
		#5;p1a=1; p1b=0; p1c=1; p1d=1; p1e=1; p1f=0; p2a=1; p2b=1; p2c=0; p2d=1; p1y_compare = 0; p2y_compare = 1;
		#5;p1a=1; p1b=1; p1c=0; p1d=1; p1e=1; p1f=1; p2a=1; p2b=1; p2c=1; p2d=0; p1y_compare = 1; p2y_compare = 1;
		#5;p1a=1; p1b=1; p1c=1; p1d=1; p1e=1; p1f=1; p2a=1; p2b=1; p2c=1; p2d=1; p1y_compare = 1; p2y_compare = 1;
		#5;p1a=1; p1b=0; p1c=0; p1d=0; p1e=1; p1f=0; p2a=0; p2b=0; p2c=0; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=0; p1c=1; p1d=0; p1e=0; p1f=0; p2a=0; p2b=0; p2c=0; p2d=1; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=1; p1c=0; p1d=0; p1e=0; p1f=1; p2a=0; p2b=0; p2c=1; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=0; p1b=1; p1c=1; p1d=0; p1e=0; p1f=1; p2a=0; p2b=0; p2c=1; p2d=1; p1y_compare = 0; p2y_compare = 1;
		#5;p1a=0; p1b=0; p1c=0; p1d=0; p1e=0; p1f=0; p2a=0; p2b=1; p2c=0; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=1; p1b=0; p1c=1; p1d=0; p1e=1; p1f=0; p2a=0; p2b=1; p2c=0; p2d=1; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=1; p1b=1; p1c=0; p1d=0; p1e=1; p1f=1; p2a=0; p2b=1; p2c=1; p2d=0; p1y_compare = 0; p2y_compare = 0;
		#5;p1a=1; p1b=1; p1c=1; p1d=0; p1e=1; p1f=1; p2a=0; p2b=1; p2c=1; p2d=1; p1y_compare = 1; p2y_compare = 1;
		#5 -> gen_result;

	end


	always @(*) begin
		if (p1y === 1'bz) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in high-impedance (Z) state at t=%d", $time);
		end
		if (p1y === 1'bx) begin
			isErr = 1;
			time_of_err = time_of_err === 16'bx ? $time : time_of_err;
			$display("p1y is in unknown (X) state at t=%d", $time);
		end
	end


	always @ (posedge mismatch) begin
		if (((p1y ^ p1y_compare) || (p2y ^ p2y_compare))) begin
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
		$monitor("t=%-4d: p1y = %d, p2y = %d", $time, p1y, p2y);
	end
endmodule