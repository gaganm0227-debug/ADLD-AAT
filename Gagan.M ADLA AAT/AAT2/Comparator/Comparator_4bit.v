module comparator_4bit ( 
	input [3:0] A,
	input [3:0] B, 
	output A_gt_B, 
	output A_lt_B, 
	output A_eq_B
);
assign A_gt_B = (A > B); 
assign A_lt_B = (A < B); 
assign A_eq_B = (A == B);

endmodule
 
module tb_comparator; 
reg [3:0] A, B;
wire A_gt_B, A_lt_B, A_eq_B;


comparator_4bit uut (.A(A),.B(B),.A_gt_B(A_gt_B),.A_lt_B(A_lt_B),.A_eq_B(A_eq_B));


initial begin

A = 4'b1010; B = 4'b0101; #10;
A = 4'b0011; B = 4'b1001; #10;
A = 4'b1100; B = 4'b1100; #10;
$finish;
end
initial begin
$dumpfile("comp.vcd");
$dumpvars; 
end 
endmodule
 