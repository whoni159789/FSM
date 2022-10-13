`timescale 1ns / 1ps

module ButtonController(
    input i_clk,
    input i_reset,      // clock --> need reset
    input i_button,
    output o_button
    );

    parameter   PUSHED = 1'b1,
                RELEASED = 1'b0,
                TRUE = 1'b1,
                FALSE = 1'b0;

    reg r_prevState = RELEASED;
    reg r_button;
    assign o_button = r_button;


    /* Clock이 필요함 --> Clock에 맞춰져서 Push, Release되야 하기 때문에 */
    /* 비동기식 방식 */
    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) begin
            r_button <= RELEASED;
        end
        else begin
            if(i_button == PUSHED && r_prevState == RELEASED) begin
                r_prevState = PUSHED;
                r_button = FALSE;
            end
            else if(i_button == RELEASED && r_prevState == PUSHED) begin
                r_prevState = RELEASED;
                r_button = TRUE;
            end
            else begin
                r_button = FALSE;
            end
        end
    end
endmodule
