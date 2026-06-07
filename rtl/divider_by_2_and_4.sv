module div2_4 (
    input clk,
    input rst,
    output logic clk_out_2,
    output logic clk_out_4
);

always @(posedge clk or posedge rst) begin
    if (rst)
        clk_out_2 <= 0;
    else
        clk_out_2 <= ~clk_out_2;   // toggle every cycle
end

always @(posedge clk_out_2 or posedge rst) begin
    if (rst)
        clk_out_4 <= 0;
    else
        clk_out_4 <= ~clk_out_4;   // toggle every cycle
end

endmodule

module tb_div2_4;

logic clk;
logic rst;
logic clk_out_2;
logic clk_out_4;

div2_4 uut (.*);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    #20;
    rst = 0;

    #200;

    $finish;
end

initial begin
    $monitor("Time=%0t | clk=%b | rst=%b | clk_out_2=%b | clk_out_4=%b",
              $time, clk, rst, clk_out_2, clk_out_4);
end

endmodule