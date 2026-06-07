module fac (input a, input b, input cin, output sum, output cout);
    wire w1, w2, w3;
    xor (w1, a, b);
    xor (sum, w1, cin);
    and (w2, w1, cin);
    and (w3, a, b);
    or  (cout, w2, w3);
endmodule
