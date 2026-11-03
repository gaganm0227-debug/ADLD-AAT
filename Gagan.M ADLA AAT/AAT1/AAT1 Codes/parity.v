module parity_circuit (
    input [3:0] data,
    input received_parity,
    output generated_parity,
    output parity_error
);
assign generated_parity = ^data;
assign parity_error = ^{data, received_parity};
endmodule

`timescale 1ns/1ps
module parity_tb;
reg [3:0] data;
reg received_parity;
wire generated_parity, parity_error;
parity_circuit dut (.data(data), .received_parity(received_parity),
                    .generated_parity(generated_parity), .parity_error(parity_error));
initial begin
    $monitor("Data=%b Generated=%b Received=%b Error=%b",
             data, generated_parity, received_parity, parity_error);
    data = 4'b1010; received_parity = 1'b0; #10;
    data = 4'b1110; received_parity = 1'b1; #10;
    data = 4'b1100; received_parity = 1'b0; #10;
    $finish;
end
endmodule