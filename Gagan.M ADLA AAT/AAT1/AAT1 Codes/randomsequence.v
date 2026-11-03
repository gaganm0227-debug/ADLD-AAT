module lfsr_4bit (
    input clk, reset,
    output reg [3:0] Q
);
wire feedback;
assign feedback = Q[3] ^ Q[2];
always @(posedge clk) begin
    if (reset)
        Q <= 4'b0001;
    else
        Q <= {Q[2:0], feedback}
end
endmodule

`timescale 1ns/1ps
module lfsr_4bit_tb;
reg clk, reset;
wire [3:0] Q;
lfsr_4bit dut (.clk(clk), .reset(reset), .Q(Q));
always #5 clk = ~clk;
initial begin
    $monitor("Time=%0t LFSR=%b", $time, Q);
    clk = 0; reset = 1; #10;
    reset = 0; #180;
    $finish;
end
endmodule