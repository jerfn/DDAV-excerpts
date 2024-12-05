`timescale 1ns/1ns

module ft_tb(
	output reg clk
);

	reg signed [31:0] samples_32 [0:3];
	wire signed [31:0] frequencies_32 [0:3];
	reg signed [15:0] samples_16 [0:3];
	wire signed [15:0] frequencies_16 [0:3];
	reg reset;
	reg start;
	wire done;
	
	fft UUT32 (
		samples_32,
		clk,
		reset,
		start,
		frequencies_32,
		done
	);
	
	fft16 UUT16 (
		samples_16,
		clk,
		reset,
		start,
		frequencies_16,
		done
	);

	initial begin
		clk = 0;

		reset = 0;
		start = 0;
		samples_32[0] = {16'd100, 16'd0};
		samples_32[1] = {16'd150, 16'd0};
		samples_32[2] = {16'd200, 16'd0};
		samples_32[3] = {16'd250, 16'd0};
		samples_16[0] = {8'd100, 8'd0};
		samples_16[1] = {8'd150, 8'd0};
		samples_16[2] = {8'd200, 8'd0};
		samples_16[3] = {8'd250, 8'd0};
		#10;
		start = 1;
		#50;
		
		reset = 1;
		#10;

		reset = 0;
		start = 0;
		samples_32[0] = {16'd15, 16'd0};
		samples_32[1] = {16'd66, 16'd0};
		samples_32[2] = {16'd128, 16'd0};
		samples_32[3] = {16'd52, 16'd0};
		samples_16[0] = {8'd15, 8'd0};
		samples_16[1] = {8'd66, 8'd0};
		samples_16[2] = {8'd128, 8'd0};
		samples_16[3] = {8'd52, 8'd0};
		#10;
		start = 1;
		#50;
		$stop;
	end
	
	always begin
		#5 clk = ~clk;
		
		/*
		if (done) begin
			$stop;
		end
		*/
	end

endmodule