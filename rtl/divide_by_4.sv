module div4(
    input clk,
    input reset,
    output logic clk_out
);
    logic [1:0] count;

    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
        end
        else begin
            count <= count+1;
        end
    end

    assign clk_out = count[1];

endmodule

module tb_div4;

logic clk;
logic reset;
logic clk_out;

div4 dut (.*);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #20;
    reset = 0;

    #200;

    $finish;
end

initial begin
    $monitor("Time=%0t | clk=%b | reset=%b | clk_out=%b",
              $time, clk, reset, clk_out);
end

endmodule