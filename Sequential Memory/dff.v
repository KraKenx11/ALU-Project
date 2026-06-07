module dff (input clk, input d, output q);
    wire w1, w2, w3, w4, w5, w6, w8, clk_n; 
    not (clk_n, clk);
    
    // Master Latch
    nand (w1, d, clk_n);
    nand (w2, clk_n, w1);
    nand (w3, w1, w4);
    nand (w4, w2, w3);

    // Slave Latch
    nand (w5, w3, clk);
    nand (w6, clk, w4);
    nand (q, w5, w8); 
    nand (w8, w6, q); 
endmodule