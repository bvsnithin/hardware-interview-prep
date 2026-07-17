interface fifo(input logic clk);
    logic wr_en;
    logic rd_en;
    logic[3:0] wdata;
    logic[3:0] rdata;
    logic[3:0] addr;
    logic full;
    logic empty;
    logic rst_n;


    /*********************** MODPORTS ***********************/ 
    // A Master (like a CPU or DMA) driving the FIFO
    // The module that drives a signal will have it as output in it's modport. 
    // If a CPU is driving the wr_en, wdata, and address, then those signals will be the output from CPU's perspective
    modport master (
        output rst_n, wr_en, rd_en, wdata, addr,
        input  rdata, full, empty
    );
    // The FIFO itself (or a Slave) receiving the commands
    modport slave (
        input  rst_n, wr_en, rd_en, wdata, addr,
        output rdata, full, empty
    );
    // A passive monitor (just watches the bus, drives nothing)
    modport monitor (
        input rst_n, wr_en, rd_en, wdata, addr, rdata, full, empty
    );

    // input: when the module is reading the value 
    // output: when the module is driving the signal

    // A clocking block defines WHEN signals are sampled (read) and driven (written)
    // relative to a clock edge. It solves the "Race Condition" between DUT and Testbench.


    /*********************** CLOCKING BLOCK ***********************/
    clocking cb_master @(posedge clk);

        // default input #1step: Sample inputs just BEFORE the clock edge (Preponed region)
        // default output #0: Drive outputs AT the clock edge (Re-NBA region)
        default input #1step output #0;
        
        // Directions here are from the perspective of the Testbench!
        output rst_n, wr_en, rd_en, wdata, addr;
        input  rdata, full, empty;
    endclocking

    // A testbench modport that uses the clocking block
    // The testbench will access signals like: bus.cb_master.wr_en <= 1;
    modport tb_master (
        clocking cb_master
    );

endinterface