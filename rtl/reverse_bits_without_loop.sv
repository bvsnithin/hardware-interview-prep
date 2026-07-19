module reverse_bit#(
    parameter N = 8
)(
    input [N-1:0] in,
    output [N-1:0] out
);

    assign out = {<<{in}};

endmodule

module test;

    localparam N = 8;
    logic [N-1:0] in;
    logic [N-1:0] out;
    
    reverse_bit #(.N(N)) dut(.*);

    initial begin
        in = 8'b1001_1101;
        #1;
        in = 8'b0011_1111;
    end
    initial begin
        $monitor("TIME: %0t, in = %08b, output = %08b", $time, in, out);
    end
endmodule