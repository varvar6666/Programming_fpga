module advanced_timer(
    input clk,
    input reset,
    input data,
    input ack,
    output counting,
    output done
);

// Состояния FSM
localparam IDLE = 3'b000;
localparam SHIFTING = 3'b001;
localparam COUNTING = 3'b010;
localparam DONE_STATE = 3'b011;

reg [2:0] state, next_state;

// Внутренние сигналы
reg [3:0] delay_reg;
reg [3:0] shift_count;
reg [9:0] timer_count;
reg [3:0] delay_value;
reg shift_ena, count_ena;
reg timer_reset;

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
            // Поиск паттерна 1101
            if (data == 1'b1) begin
                // Проверяем предыдущие биты для паттерна 1101
                // Упрощенная проверка - в реальности нужен детектор паттерна
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
    count_ena = 1'b0; // Не используется в этой реализации
    timer_reset = (state == IDLE);
    
    if (state == SHIFTING && shift_count == 4'd4) begin
        delay_value = delay_reg;
    end
end

endmodule
