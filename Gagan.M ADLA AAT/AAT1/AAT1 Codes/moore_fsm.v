module moore_fsm (
    input clk, reset, x,
    output reg z
);
reg [1:0] state, next_state;
localparam S0 = 2'b00, S1 = 2'b01,
           S2 = 2'b10, S3 = 2'b11;

always @(posedge clk) begin
    if (reset) state <= S0;
    else       state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        S0: if (x) next_state = S1; else next_state = S0;
        S1: if (x) next_state = S1; else next_state = S2;
        S2: if (x) next_state = S3; else next_state = S0;
        S3: if (x) next_state = S1; else next_state = S2;
        default: next_state = S0;
    endcase
end

always @(*) begin
    z = (state == S3);
end
endmodule

`timescale 1ns/1ps
module moore_fsm_tb;
reg clk, reset, x;
wire z;
moore_fsm dut (.clk(clk), .reset(reset), .x(x), .z(z));
always #5 clk = ~clk;
initial begin
    $monitor("Time=%0t Input=%b State=%b Output=%b",
             $time, x, dut.state, z);
    clk = 0; reset = 1; x = 0;
    #10; reset = 0;
    @(negedge clk); x = 1;
    @(negedge clk); x = 0;
    @(negedge clk); x = 1;
    @(negedge clk); x = 1;
    @(negedge clk); x = 0;
    @(negedge clk); x = 1;
    #10;
    $finish;
end
endmodule