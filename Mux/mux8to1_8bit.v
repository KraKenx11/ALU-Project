module mux8to1_8bit (input [7:0] d0, d1, d2, d3, d4, d5, d6, d7, input [2:0] sel, output [7:0] y);
    wire [7:0] w0, w1;
    mux4to1_8bit m0 (.d0(d0), .d1(d1), .d2(d2), .d3(d3), .sel(sel[1:0]), .y(w0));
    mux4to1_8bit m1 (.d0(d4), .d1(d5), .d2(d6), .d3(d7), .sel(sel[1:0]), .y(w1));
    mux2to1_8bit m2 (.d0(w0), .d1(w1), .sel(sel[2]), .y(y));
endmodule
