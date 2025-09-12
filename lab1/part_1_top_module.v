module part_1_top_module (input clk, input d, output q);

    // Провода для соединения триггеров
    wire q1, q2;
    
    // Первый D-триггер
    my_dff dff1 (
        .clk(clk),
        .d(d),
        .q(q1)
    );
    
    // Второй D-триггер
    my_dff dff2 (
        .clk(clk),
        .d(q1),
        .q(q2)
    );
    
    // Третий D-триггер
    my_dff dff3 (
        .clk(clk),
        .d(q2),
        .q(q)
    );

endmodule

// Модуль D-триггера
module my_dff (input clk, input d, output reg q);
    always @(posedge clk) begin
        q <= d;
    end
endmodule