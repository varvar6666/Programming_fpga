module part_3_top_module (input [31:0]a, input [31:0]b, input cin, output [31:0] sum);

    // write code here
    // Провод для переноса между 16-битными сумматорами
    wire carry_between;
    
    // Младшие 16 бит (биты 0-15)
    add16 add_lower (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(cin),
        .sum(sum[15:0]),
        .cout(carry_between)
    );
    
    // Старшие 16 бит (биты 16-31)
    add16 add_upper (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(carry_between),
        .sum(sum[31:16]),
        .cout() // Выходной перенос не используется в этой реализации
    );

endmodule

// Модуль 16-битного сумматора
module add16(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] sum,
    output cout
);
    
    // Используем встроенный оператор сложения Verilog
    assign {cout, sum} = a + b + cin;
endmodule