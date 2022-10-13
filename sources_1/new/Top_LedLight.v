`timescale 1ns / 1ps

module Top_LedLight(
    input i_clk,
    input i_reset,
    input [1:0] i_button,
    output [1:0] o_light
    );

    wire [1:0] w_button;

    ButtonController BTNUpCont(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[0]),
        .o_button(w_button[0])
    );

    ButtonController BTNDownCont(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[1]),
        .o_button(w_button[1])
    );

    FSM_Light_2 FSM_led(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(w_button),
        .o_light(o_light)
    );

endmodule
