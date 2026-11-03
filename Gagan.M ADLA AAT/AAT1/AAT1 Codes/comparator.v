module comparator (
    input [3:0] A, B,
    output A_gt_B, A_eq_B, A_lt_B
);
assign A_gt_B = (A > B);
assign A_eq_B = (A == B);
assign A_lt_B = (A < B);
endmodule

`timescale 1ns/1ps
module comparator_tb;
reg [3:0] A, B;
wire A_gt_B, A_eq_B, A_lt_B;
comparator dut (.A(A), .B(B), .A_gt_B(A_gt_B),
                .A_eq_B(A_eq_B), .A_lt_B(A_lt_B));
initial begin
    $monitor("A=%d B=%d GT=%b EQ=%b LT=%b", A, B, A_gt_B, A_eq_B, A_lt_B);
    A = 4'd9; B = 4'd5; #10;
    A = 4'd4; B = 4'd4; #10;
    A = 4'd2; B = 4'd7; #10;
    $finish;
end
endmodule