// ---------- note_lookup_4bit ----------
// Maps 4-bit note codes to frequency divider values (half-period counts)
module note_lookup_4bit(
  input  logic [3:0]  note_code,
  output logic [15:0] target_frequency
);
  // Half-period tick counts for 12.5 MHz clock
  localparam logic [15:0]
    OFF = 16'd0,
    C4  = 16'd23887, D4  = 16'd21283, E4  = 16'd18961,
    F4  = 16'd17897, G4  = 16'd15944, A4  = 16'd14205,
    B4  = 16'd12655, C5  = 16'd11944,
    Cs4 = 16'd22546, Ds4 = 16'd20088, Fs4 = 16'd16892,
    Gs4 = 16'd15049, As4 = 16'd13407;

  always_comb unique case (note_code)
    4'b0000: target_frequency = OFF;
    4'b0001: target_frequency = C4;
    4'b0010: target_frequency = D4;
    4'b0011: target_frequency = E4;
    4'b0100: target_frequency = F4;
    4'b0101: target_frequency = G4;
    4'b0110: target_frequency = A4;
    4'b0111: target_frequency = B4;
    4'b1000: target_frequency = OFF;
    4'b1001: target_frequency = Cs4;
    4'b1010: target_frequency = Ds4;     // E# -> F
    4'b1011: target_frequency = F4;
    4'b1100: target_frequency = Fs4;
    4'b1101: target_frequency = Gs4;
    4'b1110: target_frequency = As4;     // B# -> C5
    4'b1111: target_frequency = C5;
    default: target_frequency = OFF;
  endcase
endmodule
