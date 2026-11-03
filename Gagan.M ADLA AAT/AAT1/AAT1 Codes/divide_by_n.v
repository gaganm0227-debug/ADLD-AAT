module divide_by_n #(parameter N = 5) (
    input clk, reset,
    output reg tick,
    output reg [31:0] count
);
always @(posedge clk) begin
    if (reset) begin
        count <= 0;
        tick <= 0;
    end
    else if (count == N-1) begin
        count <= 0;
        tick <= 1;
    end
    else begin
        count <= count + 1;
        tick <= 0;
    end
end
endmodule

`timescale 1ns/1ps
module divide_by_n_tb;
reg clk, reset;
wire tick;
wire [31:0] count;
divide_by_n #(.N(5)) dut (.clk(clk), .reset(reset),
                           .tick(tick), .count(count));
always #5 clk = ~clk;
initial begin
    $monitor("Time=%0t Count=%d Tick=%b", $time, count, tick);
    clk = 0; reset = 1; #10;
    reset = 0; #120;
    $finish;
end
endmodule