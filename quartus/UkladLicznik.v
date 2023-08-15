module UkladLicznik (
	input clk_board,		//1MHz clock from board's PLL
	input reset,	//from button0 (reset button) - active low
	input data_inc,	//from button1  - when low sig number goes up
	input [2:0] opcode_switches,	//board switches 0-3 determining opcode
	input enable,			//board switch 4 - active high
	output [7:0] data_number,	//decoded number of data
	output [7:0] result_number,	//decoded result number
	output y			//parity signal (LED)
);
	parameter N = 9;
	parameter WIDTH = 4;

	reg clk_manual = 0;	//manual 1 Hz clock for counter 
	reg [31:0] count = 0;
	wire [3:0] data;	//output from user input and input to the counter
	wire [3:0] result;	//output from counter and input to the result decoder
	
	always @(posedge clk_board) begin	//this creates manually 1 Hz clock for counter
		if (count == 50000000) begin
			clk_manual <= ~clk_manual;
			count <= 0;
		end
		else begin
			count <= count + 1'b1;
		end
	end
	
	UserInput USER_INPUT (
		.clk(clk_board),
		.user_clk(data_inc),
		.enable(enable),
		.data(data)
	);
	
	Decoder USER_DECODER (
		.data_in(data),
		.a(data_number[0]),
		.b(data_number[1]),
		.c(data_number[2]),
		.d(data_number[3]),
		.e(data_number[4]),
		.f(data_number[5]),
		.g(data_number[6]),
		.dot(data_number[7])
	);
	
	Counter #(
		.N(N),
		.WIDTH(WIDTH)
	) COUNTER (
		.reset_async(reset),
		.clk(clk_manual),
		.opcode(opcode_switches),
		.data(data),
		.y(y),
		.result(result)
	);	

	Decoder RESULT_DECODER (
		.data_in(result),
		.a(result_number[0]),
		.b(result_number[1]),
		.c(result_number[2]),
		.d(result_number[3]),
		.e(result_number[4]),
		.f(result_number[5]),
		.g(result_number[6]),
		.dot(result_number[7])
	);
	
endmodule

