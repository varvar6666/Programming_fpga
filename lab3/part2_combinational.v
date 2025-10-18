// Часть 2: Комбинационная схема
module part2_combinational(
    input a,
    input b,
    input c,
    input d,
    output y
);

// Предполагаемая логика на основе временной диаграммы
assign y = a ^ b ^ c ^ d;

endmodule
