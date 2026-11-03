module divide_n_counter #(parameter N = 10)
(
    input clk,
    input rst,
    output reg [$clog2(N)-1:0] count,
    output reg out
);

always @(posedge clk or posedge rst)

begin

    if (rst)
    begin
        count <= 0;
        out <= 0;
    end

    else
    begin
        if (count == N-1)
        begin
            count <= 0;
            out <= ~out;
        end

        else
        begin
            count <= count + 1;
        end
    end
end
endmodule

`timescale 1ns/1ps

module tb_counter;
reg clk, rst;
wire [3:0] count;
wire out;

divide_n_counter #(.N(10)) uut (
    .clk(clk),
    .rst(rst),
    .count(count),
    .out(out)
);
always #5 clk = ~clk;

initial
begin
    $shm_open("waves.shm");
    $shm_probe(tb_counter, "AS");
    clk = 0;
    rst = 1;
    #10 rst = 0;

    #200 $finish;
end
endmodule