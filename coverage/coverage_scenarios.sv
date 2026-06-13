/*************************
You have a FIFO with a 1-bit push signal, a 1-bit pop signal, and a 4-bit fifo_depth signal (values 0 to 15).
Create a cross coverage block between push, pop, and fifo_depth.
Use ignore_bins to clear out the scenario where a pop occurs when the fifo_depth is exactly 0 (since an empty FIFO cannot be popped, and you don't want it bringing down your coverage score).
*************************/

covergroup cg_fifo @(posedge clk);

    cp_push: coverpoint push{
        bins bin_push[] = {1'b0, 1'b1};
    }

    cp_pop: coverpoint pop{
        bins bin_pop[] = {1'b0, 1'b1};
    }

    cp_fifo_depth: coverpoint fifo_depth{
        bins bin_fifo_depth[] = {[0:15]};
    }

    x_fifo: cross cp_push, cp_pop, cp_fifo_depth{
        ignore_bins invalid_pop = binsof(cp_pop.bin_pop) intersect {1'b1} && 
                                  binsof(cp_fifo_depth.bin_fifo_depth) intersect {0};
    }

endgroup

/************************
Non-Consecutive FSM Traversal
An FSM state variable curr_state handles an interrupt sequence. The legal values are IDLE, REQ, ACK, and DONE.

Your Task: Write a coverpoint with a transition bin that hits if the FSM starts at IDLE, eventually transitions to REQ (with any number of cycles or other states in between), 
and then eventually reaches ACK (again, with any states or cycles allowed in between).
*************************/

typedef enum logic [1:0] {IDLE, REQ, ACK, DONE} state_t;

state_t curr_state;

covergroup cg @(posedge clk);
    cp_trainsition coverpoint curr_state{
        bins transition_bin = (IDLE => REQ [->1] => ACK[->1]);
    }
endgroup

/***************
Power-of-Two Memory Addresses
You are verifying an internal SRAM cache controller with a 32-bit address bus addr[31:0].

Your Task: Write a coverpoint for addr that tracks whether the testbench has hit addresses that align strictly to power-of-two boundaries within a 1KB space. 
Specifically, create separate bins for 32'h0000_0004, 32'h0000_0008, 32'h0000_0010, 32'h0000_0020, 32'h0000_0040, 32'h0000_0080, 32'h0000_0100, and 32'h0000_0200 
without typing out 8 separate bin lines.
***************/

covergroup cg @(posedge clk);
    cp_address coverpoint addr{
        bins bin_addr[] = {32'h0000_0004, 32'h0000_0008, 32'h0000_0010, 32'h0000_0020, 32'h0000_0040, 32'h0000_0080, 32'h0000_0100, 32'h0000_0200};
    }
endgroup

/***************
Conditional Coverage (The iff construct)
You have an 8-bit data signal payload[7:0] and a control signal valid.

Your Task: Create a coverpoint for payload that creates a single bin for the value 8'hFF. 
However, you must ensure that this coverpoint only samples or counts the value if valid == 1. If valid == 0, the tool should ignore it completely.
***************/

covergroup cg_payload @(posedge clk);
    cp_payload coverpoint payload iff (valid){
        bins bin_payload_high = {8'hff};
    }
endgroup