module full_add ( 
    input a, b, cin,
    output sum, cout );

    // write code here
    // Расчет суммы: XOR всех трех входов
    assign sum = a ^ b ^ cin;
    
    // Расчет переноса: если хотя бы два из трех входов равны 1
    assign cout = (a & b) | (a & cin) | (b & cin);


endmodule