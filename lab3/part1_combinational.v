// Часть 1: Комбинационная схема
// Анализируя временную диаграмму, это выглядит как логическая функция
module part1_combinational(
    input a,
    input b,
    input c,
    output y
);

// Предполагаемая логика на основе временной диаграммы
assign y = a & b | c;

endmodule
