module Counter #(		//sequential circuit making modulo N arithmetic with add. features (jak w zadaniu)
	parameter N = 9,	//modulo N - default 9 (jak w treści zadania) - max. has 32-bits ( = 2^32 - 1 = <dużo>)
	parameter WIDTH = 4	//set by external module - has to do that because determines input data
) (
	input reset_async,	//async reset, active 0
	input clk,		//clock signal
	input [2:0] opcode,	//opcode determining mode of action
	input [WIDTH-1:0] data,	//data to be loaded
	input enable,		//when 0 counter is not working regardless anything else
	output reg y,		//y signalizing parity,
	output [WIDTH-1:0] result	//output data
);
	//localparams so that opcode is easier to read
	localparam OP_EMPTY = 0;
	localparam OP_LOAD = 3'b001;
	localparam OP_STOP = 3'b010;
	localparam OP_INC = 3'b011;
	localparam OP_DEC = 3'b100;
	//internal storage to be operated on - definition
	reg [WIDTH-1:0] value;	//internal value of counter, to be outwired later
	//main loop, when clk goes up or reset_async becomes active
	always @(posedge clk or negedge reset_async) begin
		if ((!reset_async) || (!enable)) begin	//reset active 0, enable active 1
			value <= 0;
		end
		else begin	//if reset is inactive - prioritized conditions from up to down
			if (opcode == OP_EMPTY) begin end	//do nothing
			else if (opcode == OP_STOP) begin end	//stop counting means in fact do nothing
			else if (opcode == OP_LOAD) begin
				value <= data % N;		//loads data mod N (jak w treści zadania)
			end
			else if (opcode == OP_INC) begin
				if (value > (N-2)) begin	//count from 0 when val reaches upper limit (N-1)
					value <= 0;
				end
				else begin
					value <= value + 1'b1;	//OP_INC means increase by 1
				end
			end
			else if (opcode == OP_DEC) begin
				if (value == 0) begin		// from 0 becomes N-2 (dla N=9 --> 7)
					value <= N - 2;
				end
				else if (value == 1) begin	// from 1 becomes N-1 (dla N=9 --> 8)
					value <= N-1;
				end
				else begin
					value <= value - 2'b10;
				end
			end
			else begin end	//unknown opcode - do nothing
		end
	end
	
	always @(value) begin	//checks parity of value and sets y output reg accordingly - starts when value changes
		if (value[0] == 0) begin
			y <= 1'b1;
		end
		else if (value[0] == 1'b1) begin
			y <= 0;
		end
		else begin
			y <= 0;
		end
	end
	assign result[WIDTH-1:0] = value[WIDTH-1:0];	//wires internal counter value out
endmodule

