`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:37:58 09/10/2012 
// Design Name: 
// Module Name:    pausa 
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

module secuence(
    input entrada,
    input clk,
    input reset,
    output salida
    );

reg state, nextstate;

parameter s0 = 1'b0;
parameter s1 = 1'b1;
reg y;


always @(posedge reset, posedge clk )
    begin
        if (reset)
            state <= s0;
        else
            state <= nextstate;
    end


always @(*)
    begin
        case(state)
            s0: if(entrada) 
                    nextstate = s1;
                else
                    nextstate = s0;
            s1: if(entrada)
                    nextstate = s1;
                else
                    nextstate = s0;
        endcase
    end

assign salida = state & ~entrada ;
endmodule



