module barrel_shifter (
    input [3:0] data,
    input [1:0] shift,
    input dir,
    output reg [3:0] result
);
always @(*) begin
    if (dir == 1'b0)
        result = data << shift;
    else
        result = data >> shift;
end
endmodule

`timescale 1ns/1ps
module barrel_shifter_tb;
reg [3:0] data;
reg [1:0] shift;
reg dir;
wire [3:0] result;
barrel_shifter dut (.data(data), .shift(shift), .dir(dir), .result(result));
initial begin
    $monitor("Data=%b Shift=%d Dir=%b Result=%b", data, shift, dir, result);
    data = 4'b1011;
    dir = 1'b0; shift = 2'd1; #10;
    dir = 1'b0; shift = 2'd2; #10;
    dir = 1'b1; shift = 2'd1; #10;
    dir = 1'b1; shift = 2'd2; #10;
    $finish;
end
endmodule