module ring_counter (
    input clk, reset,
    output reg [3:0] Q
);
always @(posedge clk) begin
    if (reset)
        Q <= 4'b0001;
    else
        Q <= {Q[2:0], Q[3]};
end
endmodule

`timescale 1ns/1ps
module ring_counter_tb;
reg clk, reset;
wire [3:0] Q;
ring_counter dut (.clk(clk), .reset(reset), .Q(Q));
always #5 clk = ~clk;
initial begin
    $monitor("Time=%0t Q=%b", $time, Q);
    clk = 0; reset = 1; #10;
    reset = 0; #60;
    $finish;
end
endmodule