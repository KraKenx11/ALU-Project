module add_sub_8bit (input [7:0] a, input [7:0] b, input sub, output [7:0] res, output cout, output overflow);
    wire [7:0] b_inv, b_eff;
    wire [8:0] c;
    
    // Carry in initial este 'sub' (1 pentru complement fata de 2 la scadere)
    buf (c[0], sub); 

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_addsub
            not (b_inv[i], b[i]);
            mux2to1_1bit mux_b (.d0(b[i]), .d1(b_inv[i]), .sel(sub), .y(b_eff[i]));
            fac fa_inst (.a(a[i]), .b(b_eff[i]), .cin(c[i]), .sum(res[i]), .cout(c[i+1]));
        end
    endgenerate
    
    buf (cout, c[8]);
    xor (overflow, c[8], c[7]); // Calcul overflow
endmodule
