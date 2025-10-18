module advanced_timer_simple(
    input clk,
    input reset,
    input data,
    input ack,
    output reg counting,
    output reg done,
    output reg [2:0] state,
    output reg [9:0] timer_count,
    output reg [3:0] delay_value
);

// Состояния FSM
localparam IDLE = 3'b000;
localparam SHIFTING = 3'b001;
localparam COUNTING = 3'b010;
localparam DONE_STATE = 3'b011;

reg [2:0] next_state;

// Внутренние сигналы
reg [3:0] delay_reg;
reg [3:0] shift_count;
reg [9:0] target_count;  // Целевое значение счетчика

// Детектор паттерна 1101
reg [3:0] pattern_buffer;

always @(posedge clk) begin
    if (reset) begin
        pattern_buffer <= 4'b0000;
    end else begin
        pattern_buffer <= {pattern_buffer[2:0], data};
    end
end

wire pattern_found = (pattern_buffer == 4'b1101) && (state == IDLE);

// Счетчик сдвига
always @(posedge clk) begin
    if (reset) begin
        shift_count <= 4'd0;
    end else if (state == SHIFTING) begin
        shift_count <= shift_count + 1'b1;
    end else begin
        shift_count <= 4'd0;
    end
end

// Сдвиговый регистр для задержки
always @(posedge clk) begin
    if (reset) begin
        delay_reg <= 4'd0;
    end else if (state == SHIFTING) begin
        delay_reg <= {delay_reg[2:0], data};
    end
end

// Сохранение целевого значения счетчика и delay_value
always @(posedge clk) begin
    if (reset) begin
        target_count <= 10'd0;
        delay_value <= 4'd0;
    end else if (state == SHIFTING && shift_count == 4'd3) begin
        // Сохраняем целевое значение = (delay_reg + 1) * 1000
        delay_value <= {delay_reg[2:0], data} + 1'b1;
        target_count <= ({delay_reg[2:0], data} + 1'b1) * 10'd1000;
    end
end

// Основной таймер
always @(posedge clk) begin
    if (reset || state == IDLE) begin
        timer_count <= 10'd0;
    end else if (state == COUNTING) begin
        timer_count <= timer_count + 1'b1;
    end
end

// FSM логика состояний
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
            if (pattern_found) begin
                next_state = SHIFTING;
            end else begin
                next_state = IDLE;
            end
        end
        
        SHIFTING: begin
            if (shift_count == 4'd4) begin
                next_state = COUNTING;
            end else begin
                next_state = SHIFTING;
            end
        end
        
        COUNTING: begin
            if (timer_count >= target_count - 1) begin
                next_state = DONE_STATE;
            end else begin
                next_state = COUNTING;
            end
        end
        
        DONE_STATE: begin
            if (ack) begin
                next_state = IDLE;
            end else begin
                next_state = DONE_STATE;
            end
        end
        
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Выходная логика
always @(*) begin
    counting = (state == COUNTING);
    done = (state == DONE_STATE);
end

endmodule

