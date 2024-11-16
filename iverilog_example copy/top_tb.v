`timescale 100 ps/ 10 ps
module top_tb;

	reg clk=0;
	wire [11:0]sin;
	// wire clk_lock;
	// wire
	reg [7:0] a,b;
	wire [15:0] m_s, m_h;

	top top0(
		.clk_i(clk),
		.lock_o(lock),
		.clk_1m_o(clk_1m_o),
		.clk_100m_o(clk_100m_o),
		.a(a),
		.b(b),
		.multi_soft_o(m_s)
		// .multi_hard_o(m_h)
	);


initial
begin
	$display ("###################################################");
	$display ("Start TestBench");
	clk = 0;
	a = 0;
	b = 0;

end

always
	#185 clk = !clk;

initial 
begin
	$dumpfile ("top.vcd");
	$dumpvars(0, top_tb);
end

event terminate_sim;


initial begin // Ход симуляции
	// делаем reset
	@ (posedge lock)
	@ (posedge clk_1m_o);
	a <= 1;
	b <= 2;
	@ (posedge clk_1m_o);
	a <= 10;
	b <= 20;
	@ (posedge clk_1m_o);
	a <= 11;
	b <= 22;
	
	repeat (10)
	begin
	@ (posedge clk_1m_o);
	end
	
	-> terminate_sim;
end

// Окончание tesetbench
initial
@ (terminate_sim)  begin
	$display ("###################################################");
	#1 $finish;
end

endmodule


