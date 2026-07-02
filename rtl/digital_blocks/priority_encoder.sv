module priority_encoder #(
    WIDTH = 8,
    OUTPUT_WIDTH = $clog2(WIDTH)
)(
    input logic [WIDTH-1:0] in,
    output logic [OUTPUT_WIDTH-1:0] out
);
    always @(*) begin
        out = 'b0;
        for(int i = WIDTH-1;i>=0;i--) begin
            if(in[i]) begin
                out = OUTPUT_WIDTH'(i);
                break;
            end
        end
    end
endmodule

module test;
    parameter WIDTH = 8;
    parameter OUTPUT_WIDTH = 3;
    logic [WIDTH-1:0] in;
    logic [OUTPUT_WIDTH-1:0] out;

    priority_encoder dut(.*);

    initial begin
        $monitor("Input = %08b, Output = %03b",in, out);
        repeat(5) begin
            in = $random;
            #1;
        end
        $finish;
    end
endmodule