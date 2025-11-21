`default_nettype none
module note_lookup_4bit_test (
	input  logic [3:0] note_code,
	output logic [15:0] target_frequency
	);
	always_comb 
		case (note_code)
			4'b0000: target_frequency = 16'd0;
			4'b0001: target_frequency = 16'd23887;
			4'b0010: target_frequency = 16'd21283;
			4'b0011: target_frequency = 16'd18961;
			4'b0100: target_frequency = 16'd17897;
			4'b0101: target_frequency = 16'd15944;
			4'b0110: target_frequency = 16'd14205;
			4'b0111: target_frequency = 16'd12655;
			4'b1000: target_frequency = 16'd0;
			4'b1001: target_frequency = 16'd22546;
			4'b1010: target_frequency = 16'd20088;
			4'b1011: target_frequency = 16'd17897;
			4'b1100: target_frequency = 16'd16892;
			4'b1101: target_frequency = 16'd15049;
			4'b1110: target_frequency = 16'd13407;
			4'b1111: target_frequency = 16'd11944;
			default: target_frequency = 16'd0;
		endcase
endmodule