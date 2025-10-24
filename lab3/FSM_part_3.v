module FSM_part_3 (
    input clk,
    input reset,   
    input data,
    output reg start_shifting);

    parameter S0 = 3'd0, // Начальное состояние, ожидание первой 1
              S1 = 3'd1, // Получили 1
              S2 = 3'd2, // Получили 11
              S3 = 3'd3, // Получили 110
              S4 = 3'd4; // Получили 1101
    reg [2:0] current_state;
    reg [2:0] next_state;

    always@(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end
        else begin
            current_state <= next_state;
        end
    end

    always@(*) begin
        case(current_state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4; 
            default: next_state = S0;
        endcase
    end

    always@(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end
        else if (next_state == S4) begin
            start_shifting <= 1'b1;
        end
    end

endmodule
