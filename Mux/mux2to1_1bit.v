module mux2to1_1bit (input d0, input d1, input sel, output y);
    wire sel_n, w0, w1;
    not (sel_n, sel);
    and (w0, d0, sel_n);
    and (w1, d1, sel);
    or  (y, w0, w1);
endmodule
