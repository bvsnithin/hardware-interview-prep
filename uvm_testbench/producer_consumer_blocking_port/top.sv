/*********************
1. Write a UVM testbench that implements a producer and a
consumer using TLM blocking ports. Ensure that the producer
generates 10 integer values, and the consumer retrieves and
logs them.
***********************/

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "producer.sv"
`include "consumer.sv"
`include "test_env.sv"
`include "test.sv"

module top;
    initial begin
        run_test();
    end
endmodule

