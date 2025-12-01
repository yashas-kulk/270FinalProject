`default_nettype none

module music_player_top(
  input  logic        CLK,
  input  logic        ICE_PB,
  input  logic        ICE_36,
  input  logic        ICE_38,
  input  logic        ICE_34,
  input  logic        ICE_32,
  output logic        ICE_31,
  output logic        ICE_27,
  output logic        ICE_26,
  output logic        ICE_25,
  output logic        ICE_23,
  output logic        ICE_21,
  output logic        ICE_20_G3,
  output logic        ICE_19,
  output logic        ICE_18,
  output logic        ICE_48,
  output logic        ICE_47,
  output logic        ICE_46,
  output logic        ICE_45,
  output logic        ICE_44_G6,
  output logic        ICE_2,
  output logic        ICE_3,
  output logic        ICE_4
);


  logic [3:0] raw_input;
  assign raw_input = {ICE_36, ICE_38, ICE_34, ICE_32}; 

   2. Stability Logic 
  logic [3:0]  current_note;
  logic [3:0]  candidate_note;
  logic [19:0] timer;

  
  localparam TIMER_MAX = 20'd1_000_000;

  always_ff @(posedge CLK) begin
    if (~ICE_PB) begin
      current_note   <= 4'd0;
      candidate_note <= 4'd0;
      timer          <= 20'd0;
    end 
    else begin
      if (raw_input != candidate_note) begin
        candidate_note <= raw_input;
        timer          <= 20'd0;
      end 
      else if (timer < TIMER_MAX) begin
        
        timer <= timer + 1;
      end 
      else begin
        /
        current_note <= candidate_note;
      end
    end
  end


  logic [15:0] target_frequency_raw;
  note_lookup_4bit u_lut (
    .note_code(current_note), 
    .target_frequency(target_frequency_raw)
  );

  frequency_generator u_div(
    .clk(CLK),
    .reset(~ICE_PB),
    .target_frequency(target_frequency_raw),
    .speaker_out(ICE_31)
  );

  assign ICE_27 = target_frequency_raw[0];
  assign ICE_26 = target_frequency_raw[1];
  assign ICE_25 = target_frequency_raw[2];
  assign ICE_23 = target_frequency_raw[3];
  assign ICE_21 = target_frequency_raw[4];
  assign ICE_20_G3 = target_frequency_raw[5];
  assign ICE_19 = target_frequency_raw[6];
  assign ICE_18 = target_frequency_raw[7];
  assign ICE_48 = target_frequency_raw[8];
  assign ICE_47 = target_frequency_raw[9];
  assign ICE_46 = target_frequency_raw[10];
  assign ICE_45 = target_frequency_raw[11];
  assign ICE_44_G6 = target_frequency_raw[12];
  assign ICE_2  = target_frequency_raw[13];
  assign ICE_3  = target_frequency_raw[14];
  assign ICE_4  = target_frequency_raw[15];

endmodule
