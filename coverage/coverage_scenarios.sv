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

/*********************
AXI Write Transaction

Model an AXI write channel where burst_len can be 1, 4, 8, or 16 beats, burst_type can be FIXED, INCR, or WRAP, and 
size can be 1, 2, 4, or 8 bytes. Cover all combinations, and specifically cross burst_type with burst_len.
*********************/
typedef enum logic[1:0] {FIXED, INCR, WRAP} burst_type_t;
burst_type_t burst_type;
logic[4:0] burst_len;
logic[3:0] size;

covergroup cg_axi_write_transaction @(posedge clk);
    cp_burst_len: coverpoint burst_len{
        bins bin_len[] = {1,4,8,16};
    }

    cp_burst_type: coverpoint burst_type{
        bins bin_type[] = {FIXED, INCR, WRAP} ;
    }

    cp_size: coverpoint size{
        bins bin_size[] = {1,2,4,8};
    }

    x_burst_type_len: cross cp_burst_len, cp_burst_type;
    x_cross_all: cross cp_burst_len, cp_burst_type, cp_size;

endgroup

/*********************
Cache Controller State Machine

A cache controller has states: IDLE, COMPARE_TAG, ALLOCATE, WRITE_BACK. Cover each state, and 
cross the current state with a hit / miss signal to capture all meaningful state-outcome pairs.
*********************/

typedef enum logic[1:0] {IDLE, COMPARE_TAG, ALLOCATE, WRITE_BACK} states_t;
states_t state;

covergroup cg_cache_controller_states;
    cp_states: coverpoint state{
        bins bin_state[] = {IDLE, COMPARE_TAG, ALLOCATE, WRITE_BACK};
    }

    cp_hit_miss: coverpoint hit{
        bins hit_bin = {1};
        bins miss_bin = {0};
    }
    
    x_cross_state_hit: cross cp_states, cp_hit_miss;

endgroup
