module full_adder(
    input bit a,b,cin,
    output bit sum, cout
);
    assign {sum,cout} = {a^b^cin, ((a&b) | (b&cin) | (a&cin))};
endmodule

module ripple_carry_adder#(
    parameter int WIDTH = 1
)(
    input bit[WIDTH-1:0] a,b,
    input bit cin,
    output bit[WIDTH-1:0] sum, 
    output cout
);

    bit[WIDTH:0] carry;
    assign carry[0] = cin;
    assign cout = carry[WIDTH];

    genvar i;
    generate
        for(i = 0;i<WIDTH;i++) begin: for_generate
            full_adder fa(
                .a (a[i]),
                .b (b[i]),
                .sum (sum[i]),
                .cout (carry[i+1]),
                .cin (carry[i])
            );
        end
    endgenerate
endmodule

module test;
    parameter int WIDTH = 4;
    logic[WIDTH-1:0] a, b, sum, cout;
    logic cin;

    ripple_carry_adder #(.WIDTH(WIDTH)) dut(.*);

    initial begin
        $monitor("A: %0d, B = %0d, Cin = %0d, Sum = %0d, Carry = %0d",a,b,cin,sum,cout);
        repeat(10) begin
            a = $random;
            b = $random;
            cin = $random;
            #1;
        end
        $finish;
    end
endmodule