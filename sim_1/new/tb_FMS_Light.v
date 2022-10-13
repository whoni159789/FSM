`timescale 1ns / 1ps

module tb_FMS_Light();
    reg i_clk = 1'b0;
    reg i_reset;
    reg i_OnOffSW;
    wire o_light;

    FSM_Light dut(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_OnOffSW(i_OnOffSW),
        .o_light(o_light)
    );

    always #5 i_clk = ~i_clk;

    initial begin
        #00 i_reset = 1'b1; i_OnOffSW = 1'b0;
        #100 i_reset = 1'b0; i_OnOffSW = 1'b0;
        #100 i_reset = 1'b0; i_OnOffSW = 1'b1;
        #100 $finish;
    end

endmodule
