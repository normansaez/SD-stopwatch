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
    input clk_50M,
    input reset,
    output [3:0] outp
    );

reg [3:0] delay1;
reg [3:0] delay2;
reg [3:0] delay3;
/*reg [24:0] counter_50M;

reg clk_1Hz = 1'b0;

parameter COUNT_50M  = 25000000; // para clock de 10s (segundo)

always @ (posedge clk_50M or posedge reset)
begin

	if (reset)
		begin
			counter_50M <=0;
			clk_1Hz <= 1'b0;
		end
	else
		if (counter_50M == COUNT_50M)
			begin
				counter_50M <= 0;
				clk_1Hz <= ~clk_1Hz;
			end
		else
			begin
				counter_50M <= counter_50M + 1;
			end
end
*/
always @(posedge clk_50M or posedge reset)
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
