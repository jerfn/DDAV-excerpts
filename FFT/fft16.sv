module fft16 #(WIDTH = 16) (
    input signed [(WIDTH - 1):0] in [0:3], // 4 x 16-bit (default) complex inputs for sampled being FFT'd
    input clk,
    input reset,
    input start,
    output logic signed [(WIDTH - 1):0] out [0:3], // 4 x 16-bit (default) complex ouputs
    output logic done // 1 when computation is done, 0 else
);

    localparam RESET = 2'b00;
    localparam STAGE1 = 2'b01;
    localparam STAGE2 = 2'b10;
    localparam DONE = 2'b11;

    logic [1:0] currState, nextState;

    logic [(WIDTH - 1):0] a1, b1, w1, out1_plus, out1_minus;
    butterfly #(WIDTH) butter1(a1, b1, w1, out1_plus, out1_minus);
    logic [(WIDTH - 1):0] a2, b2, w2, out2_plus, out2_minus;
    butterfly #(WIDTH) butter2(a2, b2, w2, out2_plus, out2_minus);

    initial begin
        currState = RESET;
    end

    always_comb begin
        case (currState)
            RESET : begin
                done = 0;
                out[0] = 0;
                out[1] = 0;
                out[2] = 0;
                out[3] = 0;
                if (start == 1) begin
                    nextState = STAGE1;
                end else begin
                    nextState = RESET;
                end
            end
            STAGE1 : begin
                done = 0;
                out[0] = 0;
                out[1] = 0;
                out[2] = 0;
                out[3] = 0;
                nextState = STAGE2;
            end
            STAGE2 : begin
                done = 0;
                out[0] = 0;
                out[1] = 0;
                out[2] = 0;
                out[3] = 0;
                nextState = DONE;
            end
            DONE : begin
                out[0] = out1_plus;
                out[1] = out2_plus;
                out[2] = out1_minus;
                out[3] = out2_minus;
                done = 1;
                if (reset == 1) begin
                    nextState = RESET;
                end else begin
                    nextState = DONE;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        currState <= nextState;
        if (nextState == STAGE1) begin
            a1 <= in[0];
            b1 <= in[2];
            a2 <= in[1];
            b2 <= in[3];
            w1 <= 16'h7f00; // W(0, 4)
            w2 <= 16'h7f00; // W(0, 4)
        end else if (nextState == STAGE2) begin
            a1 <= out1_plus;
            b1 <= out2_plus;
            a2 <= out1_minus;
            b2 <= out2_minus;
            w1 <= 16'h7f00; // W(0, 4)
            w2 <= 16'h0080; // W(1, 4)
        end
    end
    
endmodule