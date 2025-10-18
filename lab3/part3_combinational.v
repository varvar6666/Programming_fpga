// Часть 3: Комбинационная схема
module part3_combinational(
    input a,
    input b,
    input c,
    input d,
    output y
);

// Предполагаемая логика на основе временной диаграммы
assign y = (a & b) | (c & d);

endmodule
