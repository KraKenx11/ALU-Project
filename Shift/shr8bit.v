module shr8bit (input [7:0] a, input [2:0] shamt, output [7:0] y);
    wire [7:0] s0, s1;
    genvar i;
    generate
        // Shift by 1
        for (i=0; i<7; i=i+1) mux2to1_1bit ms0 (a[i], a[i+1], shamt[0], s0[i]);
        mux2to1_1bit ms0_7 (a[7], 1'b0, shamt[0], s0[7]);

        // Shift by 2
        for (i=0; i<6; i=i+1) mux2to1_1bit ms1 (s0[i], s0[i+2], shamt[1], s1[i]);
        for (i=6; i<8; i=i+1) mux2to1_1bit ms1_z (s0[i], 1'b0, shamt[1], s1[i]);

        // Shift by 4
        for (i=0; i<4; i=i+1) mux2to1_1bit ms2 (s1[i], s1[i+4], shamt[2], y[i]);
        for (i=4; i<8; i=i+1) mux2to1_1bit ms2_z (s1[i], 1'b0, shamt[2], y[i]);
    endgenerate
endmodule
