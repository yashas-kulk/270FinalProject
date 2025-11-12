`default_nettype none
module oneHzTest(
    input logic CLK,
    input logic ICE_PB,
    output logic LED_G,
    output logic ICE_31);
    logic clk_out;
    clkdiv div(
        .clk(CLK),
        .rst(ICE_PB),
        .lim(24'd12500000),
        .clk_out(clk_out)
    );
    assign LED_G = clk_out;
    assign ICE_31 = clk_out;
endmodule