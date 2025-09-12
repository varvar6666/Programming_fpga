module part_4_top_module (input [31:0]a, input [31:0]b, input cin, output [31:0] sum, output cout);

    // write code here
    // Провода для переносов между 16-битными сумматорами
    wire carry_lower_to_upper;
    wire carry_upper_to_final;
    
    // Первый 16-битный сумматор (младшие биты)
    add16 add_lower (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(cin),
        .sum(sum[15:0]),
        .cout(carry_lower_to_upper)
    );
    
    // Второй 16-битный сумматор (старшие биты)
    add16 add_upper (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(carry_lower_to_upper),
        .sum(sum[31:16]),
        .cout(carry_upper_to_final)
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