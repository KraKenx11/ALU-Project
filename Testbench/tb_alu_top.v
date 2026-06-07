`timescale 1ns / 1ps

module tb_alu_top;

    reg  [7:0] A;
    reg  [7:0] B;
    reg  [3:0] Control;
    wire [7:0] Result;
    wire Z, N, V;

    // Instanțiere ALU
    alu_top uut (
        .A(A), .B(B), .Control(Control), 
        .Result(Result), .Z(Z), .N(N), .V(V)
    );

    initial begin
        $display("--- Testare ALU TOP (Structural) ---");
        
        A = 8'd10; B = 8'd5; Control = 4'b0000;
        #10; $display("[0000] ADD: %d + %d = %d | Z=%b N=%b V=%b", A, B, Result, Z, N, V);

        A = 8'd10; B = 8'd5; Control = 4'b0001;
        #10; $display("[0001] SUB: %d - %d = %d | Z=%b N=%b V=%b", A, B, Result, Z, N, V);
        
        A = 8'd100; B = 8'd50; Control = 4'b0000;
        #10; $display("[0000] ADD (Overflow Test): %d + %d = %d | Z=%b N=%b V=%b", A, B, Result, Z, N, V);

        A = 8'd6; B = 8'd7; Control = 4'b0010;
        #10; $display("[0010] MUL: %d * %d = %d | Z=%b N=%b V=%b", A, B, Result, Z, N, V);

        A = 8'b11001100; B = 8'b10101010; Control = 4'b0100;
        #10; $display("[0100] AND: %b & %b = %b", A, B, Result);

        A = 8'b11001100; B = 8'b10101010; Control = 4'b0110;
        #10; $display("[0110] XOR: %b ^ %b = %b", A, B, Result);

        A = 8'b00001111; B = 8'd2; Control = 4'b0111;
        #10; $display("[0111] SHL: %b << %d = %b", A, B, Result);

        A = 8'b11110000; B = 8'd3; Control = 4'b1000;
        #10; $display("[1000] SHR: %b >> %d = %b", A, B, Result);

        $display("--- Testare Finalizata ---");
        $finish;
    end

endmodule
