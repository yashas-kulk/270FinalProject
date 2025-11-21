`default_nettype none
module music_player_top_test(
  input  logic        CLK,
  input  logic        ICE_PB,
  input  logic        ICE_36,
  input  logic ICE_38,
  input  logic ICE_28,
  input  logic ICE_32,
  output logic        ICE_31
);
  logic [15:0] target_frequency;
  note_lookup_4bit u_lut (
    .note_code({ICE_36, ICE_38, ICE_28, ICE_32}), 
    .target_frequency(target_frequency)
    );
  clkdiv div(
        .clk(CLK),
        .rst(ICE_PB),
        .lim(target_frequency),
        .clk_out(ICE_31)
    );
endmodule