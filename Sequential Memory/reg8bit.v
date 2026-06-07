module reg8bit (input clk, input en, input [7:0] d, output [7:0] q);
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_reg
            reg1bit r (.clk(clk), .en(en), .d(d[i]), .q(q[i]));
        end
    endgenerate
endmodule