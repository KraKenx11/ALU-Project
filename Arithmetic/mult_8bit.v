module mult_8bit (input [7:0] a, input [7:0] b, output [7:0] prod);
    wire [7:0] pp [7:0]; 
    wire [7:0] sum_stg [7:0]; 
    wire [7:0] carry_stg [7:0];

    genvar i, j;
    generate
        for (i = 0; i < 8; i = i + 1) begin : pp_rows
            for (j = 0; j < 8; j = j + 1) begin : pp_cols
                and (pp[i][j], a[j], b[i]);
            end
        end

        for (j=0; j<8; j=j+1) begin : init_sum
            buf (sum_stg[0][j], pp[0][j]);
        end

        for (i = 1; i < 8; i = i + 1) begin : mult_stages
            fac fa_first (.a(sum_stg[i-1][1]), .b(pp[i][0]), .cin(1'b0), .sum(sum_stg[i][0]), .cout(carry_stg[i][0]));
            for (j = 1; j < 8-i; j = j + 1) begin : mult_adders
                fac fa_inst (.a(sum_stg[i-1][j+1]), .b(pp[i][j]), .cin(carry_stg[i][j-1]), .sum(sum_stg[i][j]), .cout(carry_stg[i][j]));
            end
        end
    endgenerate

    buf (prod[0], sum_stg[0][0]); buf (prod[1], sum_stg[1][0]);
    buf (prod[2], sum_stg[2][0]); buf (prod[3], sum_stg[3][0]);
    buf (prod[4], sum_stg[4][0]); buf (prod[5], sum_stg[5][0]);
    buf (prod[6], sum_stg[6][0]); buf (prod[7], sum_stg[7][0]);
endmodule
