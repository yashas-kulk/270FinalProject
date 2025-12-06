// Testbench for simulation and waveform dumping
`timescale 1ns/1ps

module tb_music_player;
  logic clk = 0;
  logic reset = 1;
  logic [3:0] note_code;
  logic audio_out;

  // DUT
  music_player_top dut (
    .clk(clk),
    .reset(reset),
    .note_code(note_code),
    .audio_out(audio_out)
  );

  // Clock: 12.5 MHz (80 ns period)
  localparam real T_NS = 80.0;
  always #(T_NS/2.0) clk = ~clk;

  // Reset and stimulus
  initial begin
    // Generate waveform file
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_music_player);

    // Reset sequence
    repeat (5) @(posedge clk);
    reset = 0;

    // Sequence of notes
    note_code = 4'b0001; repeat (200000) @(posedge clk); // C4
    note_code = 4'b0010; repeat (200000) @(posedge clk); // D4
    note_code = 4'b0011; repeat (200000) @(posedge clk); // E4
    note_code = 4'b0100; repeat (200000) @(posedge clk); // F4
    note_code = 4'b0101; repeat (200000) @(posedge clk); // G4
    note_code = 4'b0000; repeat (50000) @(posedge clk);  // silence

    $finish;
  end
endmodule
