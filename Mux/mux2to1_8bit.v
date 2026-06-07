module mux2to1_8bit (input [7:0] d0, input [7:0] d1, input sel, output [7:0] y);
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_mux2
            mux2to1_1bit m (d0[i], d1[i], sel, y[i]);
        end
    endgenerate
endmodule
