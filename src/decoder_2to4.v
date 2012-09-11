`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:12:48 09/04/2012 
// Design Name: 
// Module Name:    decoder_2to4 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder_2to4(
    input [1:0] in,
    output reg [3:0] out
    );
always @(*)
	case (in)
		0: out = 4'b1110;
		1: out = 4'b1101;
		2: out = 4'b1011;
		3: out = 4'b0111;
		default: out = 4'b1111;
	endcase

endmodule
