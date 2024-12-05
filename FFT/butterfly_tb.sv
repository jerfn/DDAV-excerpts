`timescale 1ns/1ns

module butterfly_tb (
    output logic signed [31:0] o1, o2
);
    
    reg signed [31:0] a, b, w;
    butterfly UUT(a, b, w, o1, o2);

    initial begin
        // a = 32'b00000001010011011111111011101001; // 333-279j
        a = 32'h014dfee9;
        // b = 32'b00000001111100100000000011011110; // 498+222j
        b = 32'h01f200de;
        // w = 32'b1000000000000000; // -j
        w = 32'h8000;
        #20;
		// w = 32'b0111111111111111; // j
        w = 32'h7fff;
        $stop;
    end

endmodule