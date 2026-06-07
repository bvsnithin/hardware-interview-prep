

module fibonacci(
    input  logic unsigned [31:0] n,
    output logic unsigned [31:0] val
);
    logic[31:0] a,b,c;

    always @(*) begin
        a = 32'b0;
        b = 32'b1;

        if(n==32'd0) begin
            val = a;
        end
        else if(n==32'd1) begin
            val = b;
        end
        else begin
            for(int i = 2;i<n;i++) begin
                c = a+b;
                a = b;
                b = c;
            end
            val = c;
        end
    end

endmodule

module fibonacci_tb;
    logic unsigned [31:0] n;
    logic unsigned [31:0] val;

    fibonacci dut(.*);

    initial begin
        repeat(5) begin
            n = $urandom_range(0, 10);
            #1;
            $display("N = %0d, Out = %0d",n,val);
        end
        $finish;
    end

    
endmodule

