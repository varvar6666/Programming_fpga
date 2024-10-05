`timescale 1 ps/ 1 ps
module counter_tb;

reg clk=0, reset, enable;
wire [3:0] count;
reg dut_error;

counter U0 (
.clk    (clk),
.reset  (reset),
.enable (enable),
.count  (count)
);

initial
begin
 $display ("###################################################");
 $display ("Start TestBench");
 clk = 0;
 reset = 0;
 enable = 0;
 dut_error = 0;
end

always
  #5 clk = !clk;

initial 
begin
  $dumpfile ("counter.vcd");
  $dumpvars(0, counter_tb);
end

event reset_done;
event reset_enable;
event terminate_sim;


initial begin // Ход симуляции
	// делаем reset
	#10 -> reset_enable;
	@ (reset_done);
	@ (negedge clk);

	// простая проверка
	enable = 1;
	repeat (20)
	begin
	@ (negedge clk);
	end
	enable = 0;

	// делаем reset
	#10 -> reset_enable;
	@ (reset_done);
	@ (negedge clk);

	// измененеи сигналов случайным образом
	fork  // внутри fork все выполняется одновременно
	repeat (50) begin // 10 повторений
		@ (negedge clk); //ждем negedge clk
		enable = $random; 
		end 
	repeat (50) begin // 10 повторений
		@ (negedge clk); // negedge clk
		reset = $random; 
	end 
	join //end fork

	#10 -> terminate_sim;
end

initial // Управление reset
forever begin				// Бесконечный цикл
	@ (reset_enable);		// Ждем события Reset Enable
	@ (negedge clk)			// После события Reset Enable ждем следующий падающий фронт clk
	$display ("Applying reset");
	reset = 1;				// Задаем состояние линии reset
	@ (negedge clk)			// Ждем один такт
	reset = 0;				// Задаем состояние линии reset
	$display ("Came out of Reset");
	-> reset_done;			// Вызываем событие – Reset Done
end

// эталонная модель
reg [3:0] count_compare;

always @ (posedge clk)
if (reset == 1'b1)
 count_compare <= 0;
else if ( enable == 1'b1)
 count_compare <= count_compare + 1;

// сравнение объекта испытаний с эталонной моделью
always @ (negedge clk)
if (count_compare != count) begin
  $display ("DUT ERROR AT TIME%d",$time);
  $display ("Expected value %d, Got Value %d", count_compare, count);
  dut_error = 1;
  #10 -> terminate_sim;
end

// Окончание tesetbench
initial
@ (terminate_sim)  begin
	$display ("Terminating simulation");
	if (dut_error == 0) begin
		$display ("Simulation Result : PASSED");
	end
	else begin
		$display ("Simulation Result : FAILED");
	end
	$display ("###################################################");
	#1 $finish;
end

endmodule


