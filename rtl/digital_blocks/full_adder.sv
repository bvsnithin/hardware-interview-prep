module full_adder(
    input a, b, cin,
    output sum, cout
);
    assign sum = a^b^cin;
    assign cout = (a&b) | (b&cin) | (cin&a);
endmodule

module test;
    logic a, b, cin;
    logic sum, cout;

    full_adder dut(.*);

    initial begin
        $monitor("A: %0b, B = %0b, Cin = %0b, Sum = %0b, Carry = %0b",a,b,cin,sum,cout);
        repeat(10) begin
            a = $random;
            b = $random;
            cin = $random;
            #1;
        end
        $finish;
    end
endmodule