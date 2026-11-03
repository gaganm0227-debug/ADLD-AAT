module mealy_fsm (
    input clk, reset, x,
    output reg z
);
reg [1:0] state, next_state;
localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

always @(posedge clk) begin
    if (reset) state <= S0;
    else       state <= next_state;
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case (state)
        S0: begin
            if (x) next_state = S1;
            else   next_state = S0;
        end
        S1: begin
            if (x) next_state = S1;
            else   next_state = S2;
        end
        S2: begin
            if (x) begin
                next_state = S1;
                z = 1'b1;
            end
            else next_state = S0;
        end
        default: next_state = S0;
    endcase
end
endmodule

`timescale 1ns/1ps
module mealy_fsm_tb;
reg clk, reset, x;
wire z;
mealy_fsm dut (.clk(clk), .reset(reset), .x(x), .z(z));
always #5 clk = ~clk;

task send_bit;
    input bit_value;
    begin
        @(negedge clk);
        x = bit_value;
        #1;
        $display("Time=%0t Input=%b Output=%b", $time, x, z);
    end
endtask

initial begin
    clk = 0; reset = 1; x = 0;
    @(negedge clk); reset = 0;
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(1);
    send_bit(0);
    send_bit(1);
    #10;
    $finish;
end
endmodule