module reg1bit (input clk, input en, input d, output q);
    wire d_in;
    // Dacă en = 1, d_in ia valoarea d. Dacă en = 0, d_in ia valoarea curentă q (își menține starea)
    mux2to1_1bit m_en (.d0(q), .d1(d), .sel(en), .y(d_in));
    dff flipflop (.clk(clk), .d(d_in), .q(q));
endmodule
