`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/11 16:56:37
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module tb_top();

    wire    [31:0]  a,b;
	wire    [67:0] result;
	wire    [63:0] RESULT;
	wire    sign;
	integer i,j;
	reg     [31:0] A;
	reg     [31:0] B;
	
signed_multi aha(
    .A     (a       ),
    .B   (b    ),
    .sign (sign),
    .result    (result     ), 
    .RESULT    (RESULT)
);
assign a = A;
assign b = B;
assign sign = 0;
initial 
begin
    A = 2147483648;
    B = 1;
    
    
end

					


endmodule


