`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:45:25 09/04/2012 
// Design Name: 
// Module Name:    hex7seg 
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
module hex7seg(
    input [3:0] x,
    output reg [6:0] a_to_g
    );

always @(*)
	case (x)
		0: a_to_g = 7'b0000001;
		1: a_to_g = 7'b1001111;
		2: a_to_g = 7'b0010010;
		3: a_to_g = 7'b0000110;
		4: a_to_g = 7'b1001100;
		5: a_to_g = 7'b0100100;
		6: a_to_g = 7'b0100000;
		7: a_to_g = 7'b0001111;
		8: a_to_g = 7'b0000000;
		9: a_to_g = 7'b0000100;
		'hA: a_to_g = 7'b0001000;
		'hB: a_to_g = 7'b1100000;
		'hC: a_to_g = 7'b0110001;
		'hd: a_to_g = 7'b1000010;
		'hE: a_to_g = 7'b0110000;
		'hF: a_to_g = 7'b0111000;
		default: a_to_g = 7'b0000001;
	endcase
endmodule
