module alu_control_unit (
    input  [3:0] Control,
    output is_sub,           // Activ pentru SUB (0001)
    output is_add_or_sub,    // Activ pentru ADD (0000) sau SUB (0001)
    output dir_right,        // Activ pentru RIGHT SHIFT (1000)
    output [2:0] mux_sel_0,  // Selectori pentru MUX-ul principal (etapa 1)
    output mux_sel_1         // Selector pentru MUX-ul secundar (etapa 2)
);
    wire not_c3, not_c2, not_c1, not_c0;
    
    not (not_c3, Control[3]);
    not (not_c2, Control[2]);
    not (not_c1, Control[1]);
    not (not_c0, Control[0]);

    // is_sub = 0001
    and (is_sub, not_c3, not_c2, not_c1, Control[0]);

    // is_add_or_sub = 0000 sau 0001
    and (is_add_or_sub, not_c3, not_c2, not_c1);

    // dir_right = 1000
    and (dir_right, Control[3], not_c2, not_c1, not_c0);

    // Conectare la pinii de selecție MUX
    buf (mux_sel_0[0], Control[0]);
    buf (mux_sel_0[1], Control[1]);
    buf (mux_sel_0[2], Control[2]);
    buf (mux_sel_1,  Control[3]);
endmodule
