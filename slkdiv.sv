`default_nettype none
module clkdiv (
    input  logic        clk,
    input  logic        rst,
    input  logic [23:0] lim,
    output logic        clk_out
);
    logic [23:0] counter;
    always_ff @(posedge clk) begin
        if (~rst) begin
            counter <= 24'd0;
            clk_out <= 1'b0;
        end else begin
            if (counter == lim - 1) begin
                counter <= 24'd0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
