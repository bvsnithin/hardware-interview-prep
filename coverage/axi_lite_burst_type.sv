/*******************
An interface samples a 2-bit burst signal awburst. 
The legal protocol values are 2'b00 (FIXED), 2'b01 (INCR), and 2'b10 (WRAP). The value 2'b11 is reserved and should never happen.
Create a coverpoint for awburst that creates individual bins for the legal types.
Add an illegal bin to catch the reserved value.
********************/

typedef enum logic[1:0] {FIXED, INCR, WRAP, RESERVED} burst_t;

module axi_lite_burst_cov(
    input clk,
    burst_t awburst
);
    covergroup cg_burst_values @(posedge clk);
        cp_burst_values: coverpoint awburst{
            bins bin_fixed[] = {FIXED, INCR, WRAP};
            illegal_bins not_allowed = {RESERVED};
        }
    endgroup

    cg_burst_values cg_inst;

    initial begin
        cg_inst = new();    
    end
endmodule



module test;
    logic clk;
    burst_t awburst;

    axi_lite_burst_cov dut(.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        awburst = FIXED;
        @(posedge clk);
        #1;
        awburst = INCR;
        @(posedge clk);
        #1;
        awburst = WRAP;
        @(posedge clk);
        #1;

        $display("Simulation done");
        $display("Total system coverage: %f%%",$get_coverage());

        $finish;
    end
endmodule