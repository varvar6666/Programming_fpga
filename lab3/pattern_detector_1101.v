module pattern_detector_1101(
    input clk,
    input reset,
    input data_in,
    output reg start_shifting
);

// Состояния FSM
localparam IDLE = 3'b000;
localparam S1 = 3'b001;    // Получен первый бит '1'
localparam S2 = 3'b010;    // Получена последовательность '11'
localparam S3 = 3'b011;    // Получена последовательность '110'
localparam S4 = 3'b100;    // Получена последовательность '1101'

reg [2:0] state, next_state;

// Синхронная логика состояний
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Комбинационная логика переходов
always @(*) begin
    case (state)
        IDLE: begin
            if (data_in == 1'b1) begin
                next_state = S1;
            end else begin
                next_state = IDLE;
            end
        end
        
        S1: begin
            if (data_in == 1'b1) begin
                next_state = S2;
            end else begin
                next_state = IDLE;
            end
        end
        
        S2: begin
            if (data_in == 1'b0) begin
                next_state = S3;
            end else begin
                next_state = S2; // Остаемся в S2 при получении '1'
            end
        end
        
        S3: begin
            if (data_in == 1'b1) begin
                next_state = S4;
            end else begin
                next_state = IDLE;
            end
        end
        
        S4: begin
            next_state = IDLE; // После обнаружения паттерна возвращаемся в IDLE
        end
        
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Выходная логика
always @(*) begin
    if (state == S4) begin
        start_shifting = 1'b1;
    end else begin
        start_shifting = 1'b0;
    end
end

endmodule
