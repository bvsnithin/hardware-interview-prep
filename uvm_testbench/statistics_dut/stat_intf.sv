interface stat_intf(input logic clk);

    logic              rst_n;
    logic signed [7:0] x;

    logic signed [7:0] mean; 
    logic signed [7:0] median; 
    logic [4:0]        count; 
    logic [4:0]        unique_count;

endinterface