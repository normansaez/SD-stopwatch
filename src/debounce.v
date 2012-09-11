`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:28:21 09/10/2012 
// Design Name: 
// Module Name:    debounce 
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
module debounce(
    input [3:0] inp,
    input clock,
    input reset,
    output [3:0] outp
    );

reg [3:0] delay1;
reg [3:0] delay2;
reg [3:0] delay3;

always @(posedge clock or posedge reset)
begin
    if (reset ==1)
        begin
            delay1 <= 4'b0000;
            delay2 <= 4'b0000;
            delay3 <= 4'b0000;
        end
    else
        begin
            delay1 <= inp;
            delay2 <= delay1;
            delay3 <= delay2;
        end    
end

assign outp = delay1 & delay2 & delay3;
endmodule
