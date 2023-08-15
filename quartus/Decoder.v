module Decoder (		//combinational circuit decoding 0-15 to 7 seg display 0-F
	input [3:0] data_in,
    	output reg a,
	output reg b,
    	output reg c,
    	output reg d,
    	output reg e,
    	output reg f,
    	output reg g,
    	output dot
);
	always @(*) begin
		case (data_in)
		/* when common cathode
		4'd0 : {a,b,c,d,e,f,g} = 7'b1111110;
		4'd1 : {a,b,c,d,e,f,g} = 7'b0110000;
		4'd2 : {a,b,c,d,e,f,g} = 7'b1101101; 
		4'd3 : {a,b,c,d,e,f,g} = 7'b1111001;
		4'd4 : {a,b,c,d,e,f,g} = 7'b0110011;
		4'd5 : {a,b,c,d,e,f,g} = 7'b1011011;  
		4'd6 : {a,b,c,d,e,f,g} = 7'b1011111;
		4'd7 : {a,b,c,d,e,f,g} = 7'b1110000;
		4'd8 : {a,b,c,d,e,f,g} = 7'b1111111;
		4'd9 : {a,b,c,d,e,f,g} = 7'b1111011;
		4'd10: {a,b,c,d,e,f,g} = 7'b1110111; 
		4'd11: {a,b,c,d,e,f,g} = 7'b0011111;
		4'd12: {a,b,c,d,e,f,g} = 7'b1001110;
		4'd13: {a,b,c,d,e,f,g} = 7'b0111101;
		4'd14: {a,b,c,d,e,f,g} = 7'b1001111;
		4'd15: {a,b,c,d,e,f,g} = 7'b1000111;
		*/
		// when common anode - as in Terasic DE10
		4'd0 : {a,b,c,d,e,f,g} = 7'b0000001;
		4'd1 : {a,b,c,d,e,f,g} = 7'b1001111;
		4'd2 : {a,b,c,d,e,f,g} = 7'b0010010; 
		4'd3 : {a,b,c,d,e,f,g} = 7'b0000110;
		4'd4 : {a,b,c,d,e,f,g} = 7'b1001100;
		4'd5 : {a,b,c,d,e,f,g} = 7'b0100100;  
		4'd6 : {a,b,c,d,e,f,g} = 7'b0100000;
		4'd7 : {a,b,c,d,e,f,g} = 7'b0001111;
		4'd8 : {a,b,c,d,e,f,g} = 7'b0000000;
		4'd9 : {a,b,c,d,e,f,g} = 7'b0000100;
		4'd10: {a,b,c,d,e,f,g} = 7'b0001000; 
		4'd11: {a,b,c,d,e,f,g} = 7'b1100000;
		4'd12: {a,b,c,d,e,f,g} = 7'b0110001;
		4'd13: {a,b,c,d,e,f,g} = 7'b1000010;
		4'd14: {a,b,c,d,e,f,g} = 7'b0110000;
		4'd15: {a,b,c,d,e,f,g} = 7'b0111000;
	    endcase
   	 end
   	 assign dot = 1'b1;
endmodule

	
