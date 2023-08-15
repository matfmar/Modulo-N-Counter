`timescale 1us/1ns
module testbench();
	//default values of counter inputs , def. of params
	parameter N = 9;
	parameter WIDTH = 4;
	parameter HALF_TIME = 0.32; //in [us]
	parameter END_SIM = 50;	//time of simulation
	reg reset = 1'b1;
	reg clk = 0;
	reg [2:0] opcode = 0;
	reg [WIDTH-1:0] data = 0;
	wire [WIDTH-1:0] result;
	wire y;
	
	Counter #(		//instantiates counter
		.N(N),
		.WIDTH(WIDTH)
	) COUNTER (
		.reset_async(reset),
		.clk(clk),
		.opcode(opcode),
		.data(data),
		.y(y),
		.result(result)
	);
	
	always begin
		#(HALF_TIME); clk = ~clk;
	end
	
	initial begin
		#1; data = 2;
		#1; opcode = 1;	//should load data = 2 wait
		#1; opcode = 3; //should start counting up
		#6; opcode = 2;	//should stop counting and wait
		#4; opcode = 4; //should start counting down
		#4; data = 0;	//should have no effect on counter
		#2; opcode = 1;	//should stop counting and load data = 0;
		#2; opcode = 3;	//should start counting up again
		#4; data = 13;	//should have no effect on counter
		#2; opcode = 1;	//should load truncated data (data mod N)
		#2; opcode = 3;	//should start counting up again
		#2; reset = 0;	//should end everything async'sly
	end
	
	initial begin
		#(END_SIM) $stop;
	end
	
endmodule

