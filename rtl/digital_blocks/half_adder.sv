module half_adder(
    input  logic a,
    input  logic b,
    output  logic sum, 
    output logic cout
);
    assign sum  = a ^ b;
    assign cout = a & b;
endmodule

module test;
    logic a;
    logic b;
    logic sum; 
    logic cout;

    half_adder dut(.*);

    initial begin
        $monitor("A: %0b, B = %0b, Sum = %0b, Carry = %0b",a,b,sum,cout);
        repeat(10) begin
            a = $random;
            b = $random;
            #1;
        end
        $finish;
    end
endmodule