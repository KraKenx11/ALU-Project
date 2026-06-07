`timescale 1ns / 1ps

module tb_module;

    reg [7:0] a, b;
    reg [2:0] shamt;
    reg clk, en;
    wire [7:0] y_and, y_or, y_xor, y_shl, y_shr, q_reg;
    wire [7:0] y_mux4;
    wire sum, cout;

    and8bit u_and (.a(a), .b(b), .y(y_and));
    or8bit  u_or  (.a(a), .b(b), .y(y_or));
    xor8bit u_xor (.a(a), .b(b), .y(y_xor));
    
    shl8bit u_shl (.a(a), .shamt(shamt), .y(y_shl));
    shr8bit u_shr (.a(a), .shamt(shamt), .y(y_shr));
    
    mux4to1_8bit u_mux4 (
        .d0(8'hAA), .d1(8'hBB), .d2(8'hCC), .d3(8'hDD), 
        .sel(shamt[1:0]), .y(y_mux4)
    );

    fac u_fac (.a(a[0]), .b(b[0]), .cin(1'b0), .sum(sum), .cout(cout));

    reg8bit u_reg (.clk(clk), .en(en), .d(a), .q(q_reg));

    initial clk = 0;
    always #5 clk = ~clk;

    // Procedura de Test
    initial begin
        $display("START TESTARE STRUCTURALA");
        
        // Test Combinațional
        a = 8'b11110000; b = 8'b10101010; shamt = 3'd2;
        #10;
        $display("AND: %b & %b = %b", a, b, y_and);
        $display("OR:  %b | %b = %b", a, b, y_or);
        $display("XOR: %b ^ %b = %b", a, b, y_xor);
        $display("SHL (a<<2): %b -> %b", a, y_shl);
        $display("SHR (a>>2): %b -> %b", a, y_shr);
        $display("MUX4 (sel=%d): Iesire = %h", shamt[1:0], y_mux4);
        $display("FAC (a[0]+b[0]+0): %b + %b = %b (Cout: %b)", a[0], b[0], sum, cout);
        
        // Test Secvențial (Registru)
        en = 1; // Activăm scrierea
        #10;
        $display("REG Scriere (en=1): d=%b, q=%b", a, q_reg);
        
        en = 0; // Dezactivăm scrierea
        a = 8'b00001111; // Schimbăm datele de intrare
        #10;
        $display("REG Menținere (en=0, date noi la intrare): d=%b, q=%b (q trebuie sa ramana vechea valoare)", a, q_reg);

        $display("TEST FINALIZAT CU SUCCES");
        $finish;
    end

endmodule
