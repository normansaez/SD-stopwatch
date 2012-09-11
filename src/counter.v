`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:50:23 09/04/2012 
// Design Name: 
// Module Name:    counter 
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
module counter(
     input reset,
	 input pause,
	 input lap,
	 input lap1,
	 input lap2,
	 input lap3,
     input clk_50M,
     output [6:0] seven_seg,
     output [3:0] an,
	 output led0,
     output led1,
	 output led2,
	 output led3,
	 output led4,
	 output led5,
	 output led6,
	 output led7,
	 output dp
    );

	reg clk_1Hz = 1'b0;
	reg [24:0] counter_50M;
	
	reg [3:0] centesimas;
	reg [3:0] decimas;
	reg [3:0] segundos0;
	reg [3:0] segundos1;
	reg [3:0] minutos;
	reg [1:0] pos;
	reg [3:0] count;
	
	reg [3:0] l1_cen;
	reg [3:0] l1_dec;
	reg [3:0] l1_seg0;
	reg [3:0] l1_seg1;
	reg [3:0] l1_min;
	
	reg [3:0] l2_cen;
	reg [3:0] l2_dec;
	reg [3:0] l2_seg0;
	reg [3:0] l2_seg1;
	reg [3:0] l2_min;
	
	reg [3:0] l3_cen;
	reg [3:0] l3_dec;
	reg [3:0] l3_seg0;
	reg [3:0] l3_seg1;
	reg [3:0] l3_min;
	
	reg [1:0] lap_count;
	
	//parameter COUNT_50M  = 25000000; // para clock de 1s (segundo)
	//parameter COUNT_5M   = 2500000; // para clock de 0.1s (decimas)
	parameter COUNT_05M  = 250000; // para clock de 0.01s (centesimas)
	
	decoder_2to4 D24(pos,an);
	hex7seg H1(count, seven_seg);
	
	
	always @ (posedge clk_50M or posedge reset)
	begin
	
		if (reset)
			begin
				counter_50M <=0;
				clk_1Hz <= 1'b0;
				pos <= 2'b00;
			end
		else
			if (counter_50M == COUNT_05M)
				begin
					counter_50M <= 0;
					clk_1Hz <= ~clk_1Hz;
				end
			else
				begin
					counter_50M <= counter_50M + 1;
					pos <= counter_50M[12:11];

				end
	end
	
	always @ (posedge clk_1Hz or posedge reset)
	begin
		if (reset)
			begin
				centesimas <= 4'b0000;
				decimas    <= 4'b0000;
				segundos0  <= 4'b0000;
				segundos1  <= 4'b0000;
				minutos    <= 4'b0000;

				lap_count  <= 2'b00;

				l1_cen     <= 4'b0000;
			    l1_dec     <= 4'b0000;
			    l1_seg0    <= 4'b0000;
			    l1_seg1    <= 4'b0000;
				l1_min     <= 4'b0000;
				
				l2_cen  <= 4'b0000;
			    l2_dec  <= 4'b0000;
			    l2_seg0 <= 4'b0000;
			    l2_seg1 <= 4'b0000;
				l2_min  <= 4'b0000;
				
				l3_cen  <= 4'b0000;
			    l3_dec  <= 4'b0000;
			    l3_seg0 <= 4'b0000;
			    l3_seg1 <= 4'b0000;
				l3_min  <= 4'b0000;
			end
		else
			begin
			if (lap)
			lap_count <= lap_count + 1;
			begin
			if (lap_count == 2'b01)
				begin
					l1_cen  <= centesimas;
					l1_dec  <= decimas;
					l1_seg0 <= segundos0;
					l1_seg1 <= segundos1;
					l1_min  <= minutos;
				end
			
			if (lap_count == 2'b10)
				begin
					l2_cen  <= centesimas;
					l2_dec  <= decimas;
					l2_seg0 <= segundos0;
					l2_seg1 <= segundos1;
					l2_min  <= minutos;
				end
				
			if (lap_count == 2'b11)
				begin
					l3_cen  <= centesimas;
					l3_dec  <= decimas;
					l3_seg0 <= segundos0;
					l3_seg1 <= segundos1;
					l3_min  <= minutos;
				end
				
			end
			
				if (centesimas == 4'b1001 && ~pause) //09 centesimas!
					begin
						centesimas <= 4'b0000;
						decimas <= decimas +1;
					end
				else
					if (~pause)
					begin
					centesimas <= centesimas + 1;
					end
			   if (decimas == 4'b1001 && centesimas == 4'b1001 && ~pause)
					begin
						decimas <= 4'b0000;
						segundos0 <= segundos0 + 1;
					end
					
				if (segundos0 == 4'b1001 && decimas == 4'b1001 && centesimas == 4'b1001 && ~pause)
					begin
						segundos0 <= 4'b0000;
						segundos1 <= segundos1 + 1;
					end
					
				if (segundos1 == 4'b0101 && segundos0 == 4'b1001 && decimas == 4'b1001 && centesimas == 4'b1001 && ~pause)
					begin
						segundos1 <= 4'b0000;
						minutos <= minutos + 1;
					end
				if (segundos1 == 4'b0101 && segundos0 == 4'b1001 && minutos == 4'b1000 && decimas == 4'b1001 && centesimas == 4'b1001 && ~pause)
					begin
						minutos <= 4'b0000;
					end
			end
	end
	

	
always @(*)
begin
	if (lap1)
	begin
		case (pos)
			0: count = l1_cen;
			1: count = l1_dec;
			2: count = l1_seg0;
			3: count = l1_seg1;
		endcase
        mins = l1_min
	end
	else
		if (lap2)
		begin
			case (pos)
			0: count = l2_cen;
			1: count = l2_dec;
			2: count = l2_seg0;
			3: count = l2_seg1;
		endcase
        mins = l2_min
		end
		else
		if (lap3)
		begin
			case (pos)
				0: count = l3_cen;
				1: count = l3_dec;
				2: count = l3_seg0;
				3: count = l3_seg1;
			endcase
        mins = l3_min
		end
		else
		begin
			case (pos)
			0: count = centesimas;
			1: count = decimas;
			2: count = segundos0;
			3: count = segundos1; 
		endcase
        mins = minutos
	end
end

assign dp = (pos == 2) ? 1'b0:1'b1;
assign led0 = (mins >= 1) ? 1'b1:1'b0;
assign led1 = (mins >= 2) ? 1'b1:1'b0;
assign led2 = (mins >= 3) ? 1'b1:1'b0;
assign led3 = (mins >= 4) ? 1'b1:1'b0;		
assign led4 = (mins >= 5) ? 1'b1:1'b0;
assign led5 = (mins >= 6) ? 1'b1:1'b0;
assign led6 = (mins >= 7) ? 1'b1:1'b0;
assign led7 = (mins >= 8) ? 1'b1:1'b0;

endmodule
