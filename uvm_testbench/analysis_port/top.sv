import uvm_pkg::*;
`include "uvm_macros.svh"

`include "my_item.sv"
`include "my_monitor.sv"
`include "my_scoreboard.sv"
`include "my_logger.sv"
`include "my_coverage.sv"
`include "my_env.sv"
`include "my_test.sv"

module test;
    initial begin
        run_test();
    end
endmodule