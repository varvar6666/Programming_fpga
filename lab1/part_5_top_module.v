module part_5_top_module (input [31:0]a, input [31:0]b, input sub, output [31:0] sum);

    // write code here
    wire [15:0] b0_xor, b1_xor;
    wire [15:0] s0, s1;
    wire        c0;

    // инвертируем B при sub=1 (двухкомплементарное вычитание: B' = B ^ 1, cin = 1)
    assign b0_xor = b[15:0]  ^ {16{sub}};
    assign b1_xor = b[31:16] ^ {16{sub}};

    // младшие 16 бит
    add16 u0 (
        .a   (a[15:0]),
        .b   (b0_xor),
        .cin (sub),      // при вычитании начинается с 1
        .sum (s0),
        .cout(c0)
    );

    // старшие 16 бит
    add16 u1 (
        .a   (a[31:16]),
        .b   (b1_xor),
        .cin (c0),
        .sum (s1),
        .cout()          // внешний перенос не нужен
    );

    assign sum = {s1, s0};
endmodule

// Простейшая 16-битная сумматорная «ячейка» с переносом
module add16 (
    input  [15:0] a,
    input  [15:0] b,
    input         cin,
    output [15:0] sum,
    output        cout
);
    assign {cout, sum} = a + b + cin;
endmodule