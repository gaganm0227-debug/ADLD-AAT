// Synchronous counter
module synchronous_counter (
    input clk, reset,
    output reg [3:0] Q
);
always @(posedge clk) begin
    if (reset)
        Q <= 4'b0000;
    else
        Q <= Q + 1'b1;
end
endmodule

// Asynchronous ripple counter
module asynchronous_counter (
    input clk, reset,
    output reg [3:0] Q
);
always @(posedge clk or posedge reset) begin
    if (reset) Q[0] <= 1'b0;
    else       Q[0] <= ~Q[0];
end
always @(negedge Q[0] or posedge reset) begin
    if (reset) Q[1] <= 1'b0;
    else       Q[1] <= ~Q[1];
end
always @(negedge Q[1] or posedge reset) begin
    if (reset) Q[2] <= 1'b0;
    else       Q[2] <= ~Q[2];
end
always @(negedge Q[2] or posedge reset) begin
    if (reset) Q[3] <= 1'b0;
    else       Q[3] <= ~Q[3];
end
endmodule

`timescale 1ns/1ps
module synchronous_counter_tb;
reg clk, reset;
wire [3:0] Q;
synchronous_counter dut (.clk(clk), .reset(reset), .Q(Q));
always #5 clk = ~clk;
initial begin
    $monitor("Time=%0t Q=%b", $time, Q);
    clk = 0; reset = 1; #10;
    reset = 0; #180;
    $finish;
end
endmodule

`timescale 1ns/1ps
module asynchronous_counter_tb;
reg clk, reset;
wire [3:0] Q;
asynchronous_counter dut (.clk(clk), .reset(reset), .Q(Q));
always #5 clk = ~clk;
initial begin
    $monitor("Time=%0t Q=%b", $time, Q);
    clk = 0; reset = 1; #12;
    reset = 0; #180;
    $finish;
end
endmodule