module chip_7458 ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    // write code here
    // Логика для первого элемента И-ИЛИ (3+3 входа)
    assign p1y = (p1a & p1b & p1c) | (p1d & p1e & p1f);
    
    // Логика для второго элемента И-ИЛИ (2+2 входа)
    assign p2y = (p2a & p2b) | (p2c & p2d);


endmodule