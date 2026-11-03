module timer_module #(parameter PERIOD = 10) (
    input clk, reset, enable,
    output reg done,
    output reg [31:0] count
);
always @(posedge clk) begin
    if (reset) begin
        count <= 0;
        done <= 0;
    end
    else if (enable) begin
        if (count == PERIOD - 1) begin
            count <= 0;
            done <= 1;
        end
        else begin
            count <= count + 1;
            done <= 0;
        end
    end
    else begin
        done <= 0;
    end
end
endmodule

`timescale 1ns/1ps
module timer_tb;
reg clk, reset, enable;
wire done;
wire [31:0] count;
timer_module #(.PERIOD(5)) dut (.clk(clk), .reset(reset),
                               .enable(enable), .done(done), .count(count));
always #5 clk = ~clk;
initial begin
    $monitor("Time=%0t Count=%d Done=%b", $time, count, done);
    clk = 0; reset = 1; enable = 0;
    #10;
    reset = 0; enable = 1;
    #100;
    $finish;
end
endmodule