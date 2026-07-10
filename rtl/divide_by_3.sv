module divide_3(
    input clk, 
    input rst_n,
    output clk_out
);
    logic [1:0] count;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 0;
        end
        else if(count == 2'd2) begin
            count <= 0;
        end
        else begin
            count <= count+1;
        end
    end

    assign clk_out = (count == 2'd1);
endmodule

module test;
    logic clk;
    logic rst_n;
    logic clk_out;

    divide_3 dut (.*);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;

        #20;
        rst_n = 1;

        #200;

        $finish;
    end

    initial begin
        $monitor("Time=%0t | clk=%b | rst_n=%b | clk_out=%b | count=%b",
                $time, clk, rst_n, clk_out,dut.count);
    end
endmodule