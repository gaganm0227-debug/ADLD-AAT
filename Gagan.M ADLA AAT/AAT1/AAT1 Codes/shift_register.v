module shift_register (
    input clk, reset, serial_in,
    output serial_out,
    output reg [3:0] Q
);
always @(posedge clk) begin
    if (reset)
        Q <= 4'b0000;
    else
        Q <= {Q[2:0], serial_in};
end
assign serial_out = Q[3];
endmodule

`timescale 1ns/1ps
module shift_register_tb;
reg clk, reset, serial_in;
wire serial_out;
wire [3:0] Q;
shift_register dut (.clk(clk), .reset(reset), .serial_in(serial_in),
                    .serial_out(serial_out), .Q(Q));
always #5 clk = ~clk;
initial begin
    $monitor("Time=%0t Input=%b Q=%b Output=%b",
             $time, serial_in, Q, serial_out);
    clk = 0; reset = 1; serial_in = 0; #10;
    reset = 0;
    serial_in = 1; #10;
    serial_in = 0; #10;
    serial_in = 1; #10;
    serial_in = 1; #10;
    serial_in = 0; #10;
    $finish;
end
endmodule