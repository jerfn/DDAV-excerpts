module butterfly #(WIDTH = 32) (
    input signed [(WIDTH - 1):0] a, b, w,           // 32-bit (default)
    output logic signed [(WIDTH - 1):0] out1, out2  // 32-bit (default)
);

    wire signed [(WIDTH / 2 - 1):0]    a_re = a[(WIDTH - 1):(WIDTH / 2)];  // 16-bit [31:16] (default)
    wire signed [(WIDTH / 2 - 1):0]    a_im = a[(WIDTH / 2 - 1):0];        // 16-bit [15:0]  (default)

    wire signed [(WIDTH / 2 - 1):0]    b_re = b[(WIDTH - 1):(WIDTH / 2)];  // 16-bit [31:16] (default)
    wire signed [(WIDTH / 2 - 1):0]    b_im = b[(WIDTH / 2 - 1):0];        // 16-bit [15:0]  (default)

    wire signed [(WIDTH / 2 - 1):0]    w_re = w[(WIDTH - 1):(WIDTH / 2)];  // 16-bit [31:16] (default)
    wire signed [(WIDTH / 2 - 1):0]    w_im = w[(WIDTH / 2 - 1):0];        // 16-bit [15:0]  (default)

    wire signed [(WIDTH - 1):0]        wb_re = w_re * b_re - w_im * b_im;  // 32-bit (default)
    wire signed [(WIDTH - 1):0]        wb_im = w_im * b_re + w_re * b_im;  // 32-bit (default)

    wire signed [(WIDTH / 2 - 1):0]    wb_re_trunc = wb_re[(WIDTH - 2):(WIDTH / 2 - 1)];   // 16-bit [30:15] (default)
    wire signed [(WIDTH / 2 - 1):0]    wb_im_trunc = wb_im[(WIDTH - 2):(WIDTH / 2 - 1)];   // 16-bit [30:15] (default)
    
    assign out1 = {a_re + wb_re_trunc, a_im + wb_im_trunc};
    assign out2 = {a_re - wb_re_trunc, a_im - wb_im_trunc};
    
endmodule