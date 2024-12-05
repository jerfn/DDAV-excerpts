`timescale 10ns/10ns

module bongo_tb(
    inout out
);

    logic clk = 1;
    logic start = 1;
    controller_bongo UUT(clk, start, out);

    initial begin
        #25 start = 0;
        #100 start = 1;
        #12000;
        $stop;
    end
	
    always begin
        #1 clk = ~clk;
    end

endmodule