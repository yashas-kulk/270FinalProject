module frequency_generator (
    input logic clk, //12.5 MGHz clock input
    input logic reset, // system reset
    input logic [15:0] target_frequency, // from MUX logic
    output logic speaker_out // output to speaker
);

    logic [15:0] counter; //counter
    logic internal_speaker_out; //internal speaker output

    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 16'b0; // reset counter
            internal_speaker_out <= 1'b0; // reset speaker output
        end else begin
            if (target_frequency == 16'b0) begin //if our MUX selects are 0000 or 1000
                counter <= 16'b0; //reset counter
                internal_speaker_out <= 1'b0; //reset speaker output
            end else if (counter == target_frequency) begin //counter has reached MUX selected value
                counter <= 16'b0; //reset counter
                internal_speaker_out <= ~internal_speaker_out; //toggle speaker output to generate tone
            end else begin
                counter <= counter + 1; //increment counter bc we haven't reached target frequency yet
            end
        end
    end

    assign speaker_out = internal_speaker_out; //assign internal speaker output to module output
endmodule
