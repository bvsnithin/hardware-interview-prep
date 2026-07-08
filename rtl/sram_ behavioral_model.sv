module sram_model (
    parameter int DEPTH = 256,
    parameter int WIDTH = 8,
    parameter int ADDR_W = $clog2(DEPTH)
)
(
    input  logic             clk,
    input  logic             rst_n,
    input  logic             wr_en,
    input  logic             rd_en,
    input  logic[ADDR_W-1:0] addr,
    input  logic[WIDTH-1:0]  wdata,
    output logic[WIDTH-1:0]  rdata  
);
    //Memory Array. Number of rows = DEPTH and each row is WIDTH bits wide
    logic [WIDTH-1:0] mem [0:DEPTH-1];
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rdata <='0;
        end
        else begin
            if(wr_en) begin
                mem[addr] <= wdata;
            end
            if(rd_en) begin
                rdata <= mem[addr];
            end
        end
    end

    
endmodule