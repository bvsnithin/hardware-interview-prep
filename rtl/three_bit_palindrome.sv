module three_bit_palindrome(
    input  logic clk,
    input  logic areset_n,
    input  logic in,
    output logic out
);
    logic[1:0] state;

    always_ff @(posedge clk or negedge areset_n) begin
        if(!areset_n) begin
            state <= 2'b00;
        end
        else begin 
            state <= {state[0],in}; 
        end
    end

    assign out = ~(state[1]^in);
endmodule


module test;
    logic clk;
    logic areset_n;
    logic in;
    logic out;

    three_bit_palindrome dut(.*);

    initial begin
        clk = 0;
        areset_n = 0;
        in = 0;
    end

    always begin
        #5 clk = ~clk;
    end

    initial begin
        repeat(2) @(posedge clk);
        areset_n = 1;
        @(posedge clk);
        in = 1;
        repeat(10) begin
            @(negedge clk);
            in = $urandom_range(0,1);
        end
        #20 $finish;
    end 

    initial begin
        $monitor("[time=%0t] in=%0b out=%0b state=%b",$time, in, out, dut.state);
    end

    
endmodule