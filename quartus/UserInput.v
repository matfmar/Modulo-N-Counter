module UserInput (	//actually async sequential circuit driven by user pressing debouncing button and board clock
			//every press increases number by 1
	input clk,
	input user_clk,
	input enable,
	output [3:0] data
);
	reg[3:0] number = 0;
	
	always @(negedge user_clk) begin	//press = 0; no_press = 1
		if (!enable) begin
			number <= 0;
		end
		else begin
			if (number > 4'b1110) begin
				number <= 0;
			end
			else begin
				number <= number + 1'b1;
			end
		end
	end
	assign data[3:0] = number[3:0];
endmodule

