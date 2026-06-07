module mux4to1_8bit (input [7:0] d0, input [7:0] d1, input [7:0] d2, input [7:0] d3, input [1:0] sel, output [7:0] y);
    wire [7:0] w0, w1;
    mux2to1_8bit m0 (.d0(d0), .d1(d1), .sel(sel[0]), .y(w0));
    mux2to1_8bit m1 (.d0(d2), .d1(d3), .sel(sel[0]), .y(w1));
    mux2to1_8bit m2 (.d0(w0), .d1(w1), .sel(sel[1]),  .y(y));
endmodule