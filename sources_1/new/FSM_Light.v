`timescale 1ns / 1ps

module FSM_Light(
    input i_clk,
    input i_reset,
    input i_OnOffSW,
    output o_light
    );

    parameter   S_LED_ON = 1'b0,
                S_LED_OFF = 1'b1;

    reg curState, nextState;
    reg r_light;

    assign o_light = r_light;

    /* 상태 변경 적용 */
    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) curState <= S_LED_OFF;
        else        curState <= nextState;
    end

    /* 이벤트 처리 부분 */
    /* 비동기식 적용 : <= */
    always @(curState or i_OnOffSW) begin
        case (curState)
            S_LED_OFF : begin
                if(i_OnOffSW == 1'b1)   nextState <= S_LED_ON;
                else    nextState <= S_LED_OFF;
            end
            S_LED_ON  : begin
                if(i_OnOffSW == 1'b0)   nextState <= S_LED_OFF;
                else    nextState <= S_LED_ON;   
            end
        endcase
    end

    /* 상태에 따른 동작 부분 */
    always @(curState) begin
        case (curState)
            S_LED_OFF : r_light <= 1'b0;
            S_LED_ON  : r_light <= 1'b1;
        endcase
    end
    
endmodule
