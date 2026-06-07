module alu_top (
    input  [7:0] A,
    input  [7:0] B,
    input  [3:0] Control,
    output [7:0] Result,
    output Z, N, V
);

    wire is_sub, is_add_or_sub, dir_right;
    wire [2:0] mux_sel_0;
    wire mux_sel_1;

    wire [7:0] res_addsub, res_mul, res_div, res_and, res_or, res_xor, res_shl, res_shr, res_shift_final;
    wire c_out, ovf_addsub;

    // Control Unit
    alu_control_unit ctrl (
        .Control(Control), .is_sub(is_sub), .is_add_or_sub(is_add_or_sub), 
        .dir_right(dir_right), .mux_sel_0(mux_sel_0), .mux_sel_1(mux_sel_1)
    );

    // Operatii Aritmetice
    add_sub_8bit adder_inst (.a(A), .b(B), .sub(is_sub), .res(res_addsub), .cout(c_out), .overflow(ovf_addsub));
    mult_8bit    mult_inst  (.a(A), .b(B), .prod(res_mul));
    assign res_div = 8'b00000000; // Impărțirea pur structurală este prea costisitoare, o setăm pe 0

    // Operatii Logice
    and8bit and_inst (.a(A), .b(B), .y(res_and));
    or8bit  or_inst  (.a(A), .b(B), .y(res_or));
    xor8bit xor_inst (.a(A), .b(B), .y(res_xor));

    // Operatii de Shift
    shl8bit shl_inst (.a(A), .shamt(B[2:0]), .y(res_shl));
    shr8bit shr_inst (.a(A), .shamt(B[2:0]), .y(res_shr));
    
    // Selectam tipul de shift intern inainte de iesire
    mux2to1_8bit shift_mux (.d0(res_shl), .d1(res_shr), .sel(dir_right), .y(res_shift_final));

    // MUX Principal (Etapa 1: operatiile 0000 -> 0111)
    wire [7:0] mux_stage_0;
    mux8to1_8bit out_mux (
        .d0(res_addsub), .d1(res_addsub), .d2(res_mul), .d3(res_div),
        .d4(res_and),    .d5(res_or),     .d6(res_xor), .d7(res_shl),
        .sel(mux_sel_0), .y(mux_stage_0)
    );

    // MUX Final (Etapa 2: Alege intre MUX principal si Right Shift (1000))
    mux2to1_8bit final_out_mux (.d0(mux_stage_0), .d1(res_shift_final), .sel(mux_sel_1), .y(Result));

    // Setare Flag-uri
    nor (Z, Result[0], Result[1], Result[2], Result[3], Result[4], Result[5], Result[6], Result[7]);
    buf (N, Result[7]);
    and (V, ovf_addsub, is_add_or_sub); 

endmodule
