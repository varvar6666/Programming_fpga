module advanced_timer_v2(
    input clk,
    input reset,
    input data,
    input ack,
    output counting,
    output done
);

// Состояния FSM
localparam IDLE = 4'b0000;
localparam PATTERN_DETECT = 4'b0001;
localparam SHIFTING = 4'b0010;
localparam COUNTING = 4'b0011;
localparam DONE_STATE = 4'b0100;

// Состояния детектора паттерна
localparam P_IDLE = 3'b000;
localparam P_S1 = 3'b001;    // Получен первый бит '1'
localparam P_S2 = 3'b010;    // Получена последовательность '11'
localparam P_S3 = 3'b011;    // Получена последовательность '110'
localparam P_S4 = 3'b100;    // Получена последовательность '1101'

reg [3:0] state, next_state;
reg [2:0] pattern_state, pattern_next_state;

// Внутренние сигналы
reg [3:0] delay_reg;
reg [3:0] shift_count;
reg [9:0] timer_count;
reg [3:0] delay_value;
reg pattern_found;
reg shift_ena;
reg timer_reset;

// Детектор паттерна 1101
always @(posedge clk) begin
    if (reset) begin
        pattern_state <= P_IDLE;
    end else if (state == IDLE) begin
        pattern_state <= pattern_next_state;
    end else begin
        pattern_state <= P_IDLE;
    end
end

always @(*) begin
    case (pattern_state)
        P_IDLE: begin
            if (data == 1'b1) begin
                pattern_next_state = P_S1;
            end else begin
                pattern_next_state = P_IDLE;
            end
        end
        
        P_S1: begin
            if (data == 1'b1) begin
                pattern_next_state = P_S2;
            end else begin
                pattern_next_state = P_IDLE;
            end
        end
        
        P_S2: begin
            if (data == 1'b0) begin
                pattern_next_state = P_S3;
            end else begin
                pattern_next_state = P_S2;
            end
        end
        
        P_S3: begin
            if (data == 1'b1) begin
                pattern_next_state = P_S4;
            end else begin
                pattern_next_state = P_IDLE;
            end
        end
        
        P_S4: begin
            pattern_next_state = P_IDLE;
        end
        
        default: begin
            pattern_next_state = P_IDLE;
        end
    endcase
end

// Сигнал обнаружения паттерна
always @(*) begin
    pattern_found = (pattern_state == P_S4);
end

// Счетчик для сдвига 4 битов
always @(posedge clk) begin
    if (reset || state == IDLE) begin
        shift_count <= 4'd0;
    end else if (state == SHIFTING && shift_count < 4'd4) begin
        shift_count <= shift_count + 1'b1;
    end
end

// Сдвиговый регистр для задержки
always @(posedge clk) begin
    if (reset || state == IDLE) begin
        delay_reg <= 4'd0;
    end else if (shift_ena) begin
        delay_reg <= {delay_reg[2:0], data};
    end
end

// Основной таймер
always @(posedge clk) begin
    if (timer_reset || reset) begin
        timer_count <= 10'd0;
    end else if (state == COUNTING) begin
        if (timer_count == ((delay_value + 1) * 1000) - 1) begin
            timer_count <= 10'd0;
        end else begin
            timer_count <= timer_count + 1'b1;
        end
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
            if (timer_count == ((delay_value + 1) * 1000) - 1) begin
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
assign counting = (state == COUNTING);
assign done = (state == DONE_STATE);

// Управляющие сигналы
always @(*) begin
    shift_ena = (state == SHIFTING);
    timer_reset = (state == IDLE);
end

// Сохранение значения задержки
always @(posedge clk) begin
    if (reset) begin
        delay_value <= 4'd0;
    end else if (state == SHIFTING && shift_count == 4'd4) begin
        delay_value <= delay_reg;
    end
end

endmodule
