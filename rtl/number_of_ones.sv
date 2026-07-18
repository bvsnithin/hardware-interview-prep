/************************************
RTL for determining number of 1s in an input bit-stream.
************************************/

module number_of_ones(
    input logic in, 
    input logic clk,
    input logic rst_n,
    output logic[7:0] count
);

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= '0;
        end
        else begin
            count <= count + (in & 1'b1);
        end
    end
endmodule

module test;
    logic in;
    logic clk;
    logic rst_n;
    logic [7:0] count;

    initial clk = 0;
    always #5 clk = ~clk;

    number_of_ones dut(
        .in(in),
        .clk(clk),
        .rst_n(rst_n),
        .count(count)
    );

    initial begin
        rst_n = 0;
        in = 0;
        repeat(2) @(posedge clk);
        rst_n <= 1;
        repeat(10) begin
            @(posedge clk);
            in <= $random;
        end
        rst_n <= 0;
        repeat(2) @(posedge clk);
        rst_n <= 1;
        repeat(5) begin
            @(posedge clk);
            in <= $random;
        end
        $finish;
    end

    initial begin
        $monitor("[TIME: %0t] Input = %0d, Count = %0d", $time, in, count);
    end
endmodule