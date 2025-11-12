// ---------- music_player_top ----------
// Connects LUT and divider with a simple FSM (idle vs play)
`default_nettype none
module music_player_top(
  input  logic        CLK,
  input  logic        ICE_PB,
  input  logic        ICE_36,
  input  logic ICE_38,
  input  logic ICE_34,
  input  logic ICE_32,
  output logic        ICE_31,
  output logic ICE_27,
  output logic ICE_26,
  output logic ICE_25,
  output logic ICE_23,
  output logic ICE_21,
  output logic ICE_20_G3,
  output logic ICE_19,
  output logic ICE_18,
  output logic ICE_48,
  output logic ICE_47,
  output logic ICE_46,
  output logic ICE_45,
  output logic ICE_44_G6,
  output logic ICE_2,
  output logic ICE_3,
  output logic ICE_4
);
  
  
  logic [15:0] target_frequency_raw;
  
  note_lookup_4bit u_lut (.note_code({ICE_36, ICE_38, ICE_34, ICE_32}), .target_frequency(target_frequency_raw));
  
  typedef enum logic {IDLE, PLAY} state_e;
  
  state_e state, nstate;
  
  always_comb begin
    if (target_frequency_raw == 16'd0)
      nstate = IDLE;
    else
      nstate = PLAY;
  end
  
  always_ff @(posedge CLK) begin
    if (~ICE_PB)
      state <= IDLE;
    else
      state <= nstate;
  end
  
  logic [15:0] target_frequency_fsm;
  
  always_comb begin
    if (state == PLAY)
      target_frequency_fsm = target_frequency_raw;
    else
      target_frequency_fsm = 16'd0;
  
  end
  
  frequency_generator u_div(
    .clk(CLK),
    .reset(~ICE_PB),
    .target_frequency(target_frequency_fsm),
    .speaker_out(ICE_31)
  );
  
  assign ICE_27 = target_frequency_fsm[0];
  assign ICE_26 = target_frequency_fsm[1];
  assign ICE_25 = target_frequency_fsm[2];
  assign ICE_23 = target_frequency_fsm[3];
  assign ICE_21 = target_frequency_fsm[4];
  assign ICE_20_G3 = target_frequency_fsm[5];
  assign ICE_19 = target_frequency_fsm[6];
  assign ICE_18 = target_frequency_fsm[7];
  assign ICE_48 = target_frequency_fsm[8];
  assign ICE_47 = target_frequency_fsm[9];
  assign ICE_46 = target_frequency_fsm[10];
  assign ICE_45 = target_frequency_fsm[11];
  assign ICE_44_G6 = target_frequency_fsm[12];
  assign ICE_2  = target_frequency_fsm[13];
  assign ICE_3  = target_frequency_fsm[14];
  assign ICE_4  = target_frequency_fsm[15];
endmodule

