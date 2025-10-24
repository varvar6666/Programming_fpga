    module FSM_part_4 (
        input clk,
        input reset,
        input data,
        output reg counting,
        input reg done_counting,
        output reg done,
        output reg [3:0] cnt,
        input ack );

        parameter S0=4'd0, S1=4'd1, S2=4'd2, S3=4'd3;
        parameter B0=4'd4, B1=4'd5, B2=4'd6, B3=4'd7;
        parameter COUNT=4'd8, WAIT=4'd9;
        reg [3:0] state, next_state;
        reg [15:0] num_cnt;
        always @(*) begin
            case (state)
                S0: next_state = (data) ? S1:S0;
                S1: next_state = data ? S2:S0;
                S2: next_state = (!data) ? S3:S2;
                S3: next_state = data ? B0:S0;
                B0: next_state = B1;
                B1: next_state = B2;
                B2: next_state = B3;
                B3: next_state = COUNT;
                COUNT: next_state = (done) ? WAIT:COUNT;
                WAIT: next_state = (ack && !(^ack === 1'bx)) ? S0:WAIT;
                default: next_state = S0;
            endcase
        end
        
        always @(posedge clk) begin
            state <= (reset) ? S0:next_state;
        end

        // СДВИГОВЫЙ РЕГИСТР
        always @(posedge clk) begin
            if (reset) begin
                cnt = 4'd0;
                done = 0;
            end else if(next_state == S0) begin
                done = 0;
            end
            else if (state == B0 || state == B1 || state == B2 || state == B3) begin
                cnt = {cnt[2:0], data};
            end
        end
        
        // СЧЕТЧИК
        always @(posedge clk) begin
            if (reset || (num_cnt == (((cnt + 1) * 1000) - 1))) begin
                counting = 0;
                cnt = 0 ;
                num_cnt <= 0;
                // ЗАДЕРЖКА ВЫДЕРЖАНА
                if (!reset) begin
                    done <= 1;
                end
            end
            else begin
                counting = (next_state==COUNT);
            end
        end
        always @(posedge clk) begin
            num_cnt <= (counting) ? num_cnt+1:0; 
        end
    endmodule