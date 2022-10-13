`timescale 1ns / 1ps

module FSM_Light_2(
    input i_clk,
    input i_reset,
    input [1:0] i_OnOffSW,
    output [1:0] o_Light
    );

    parameter   S_LED_00 = 2'b00,
                S_LED_01 = 2'b01,
                S_LED_10 = 2'b10;

    reg [1:0] curState, nextState;
    reg [1:0] r_Light;
    assign o_Light = r_Light;

    /* 상태 변경 */
    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) curState <= 2'b00;
        else    curState <= nextState;
    end

    /* 이벤트 처리 */
    always @(curState or i_OnOffSW) begin
        nextState <= 2'b00;
        case (curState)
            S_LED_00 : begin
                if(i_OnOffSW == 2'b01)  nextState <= 2'b01;
                else if(i_OnOffSW == 2'b10)  nextState <= 2'b10;
                else    nextState <= 2'b00;
            end
            S_LED_01 : begin
                if(i_OnOffSW == 2'b00)  nextState <= 2'b00;
                else if(i_OnOffSW == 2'b10)  nextState <= 2'b10;
                else    nextState <= 2'b00;
            end
            S_LED_10 : begin
                if(i_OnOffSW == 2'b00)  nextState <= 2'b00;
                else if(i_OnOffSW == 2'b01)  nextState <= 2'b01;
                else    nextState <= 2'b00;
            end
        endcase 
    end

    /* 상태에 따른 동작 */
    always @(curState) begin
        r_Light = 2'b00;
        case (curState)
            S_LED_00 :  r_Light = 2'b00;
            S_LED_01 :  r_Light = 2'b01;
            S_LED_10 :  r_Light = 2'b10;
        endcase
    end

endmodule
