module file_reg_top (
    input wire clk,                    
    input wire we,                     
    input wire [4:0] waddr,           
    input wire [31:0] wdata,         
    input wire [4:0] raddr1,         
    input wire [4:0] raddr2,          
    output wire [31:0] rdata1,        
    output wire [31:0] rdata2         
);

    // Массив регистров: 32 регистра по 32 бита
    reg [31:0] registers [0:31];

    // Синхронная запись
    always @(posedge clk)
        if (we && (waddr != 5'b0)) registers[waddr] <= wdata;

    // Асинхронное чтение с возвратом 0 для адреса 0
    assign rdata1 = (raddr1 == 5'b0) ? 32'h0 : registers[raddr1];
    assign rdata2 = (raddr2 == 5'b0) ? 32'h0 : registers[raddr2];
        

endmodule
