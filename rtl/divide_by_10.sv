/********************
Write RTL for clock divide by 10 with a duty cycle of 40
********************/

module divide_10(
    input clk,
    input rst_n, 
    output clk_10_50,  // 50% duty cycle
    output clk_10_40   // 40% duty cycle
);
    logic[3:0] count;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= '0;
        end
        else if(count == 4'd9) begin
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end

    assign clk_10_50 = (count > 4'd4);
    assign clk_10_40 = (count > 4'd5);
endmodule

module test;
    logic clk;
    logic rst_n;
    logic clk_10_50;
    logic clk_10_40;

    divide_10 dut(.*);

    initial begin
        clk = 0;
    end
    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        repeat(2) @(posedge clk);
        rst_n = 1;
        #200;
        $finish;
    end 

    initial begin
        $monitor("[TIME: %0t] clk = %0b, rst_n = %0b, clk_10_50 = %0b, clk_10_40 = %0b", $time, clk, rst_n, clk_10_50, clk_10_40);
    end
endmodule