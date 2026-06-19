/***********************************************************
1. AXI Handshake
On any interface with valid and ready, once valid is asserted, it must stay high until ready is seen. 
Write an assertion that catches valid dropping before the handshake completes.
***********************************************************/

property axi_handshake;
    @(posedge clk)
    disable iff(!rst_n)
    $rose(valid) |-> valid until_with ready;     //This means that the valid should be asserted until ready is seen and ready must be seen. We dont use "until" because it vacously passes even if ready is never seen asserted
endproperty

assert_axi_handshake: assert property (axi_handshake);

/***********************************************************
2. Request-to-Acknowledge Latency
A module drives req and expects ack in response. Write an assertion that ack must arrive within 1 to 4 cycles after req is asserted. 
Also write a complementary assertion that ack never appears without a prior req.
***********************************************************/
property req_to_ack;
    @(posedge clk)
    disable iff(!rst_n)
    req |-> ##[1:4] ack;
endproperty

property ack_not_before_req;
    @(posedge clk)
    disable iff(!rst_n)
    $rose(ack) |-> $past(req);    //Is acknowledge signal asserted, then in the past req must have appeared. 
endproperty

assert_req_to_ack: assert property (req_to_ack);
assert_ack_not_before_req: assert property (ack_not_before_req);

/***********************************************************
3. Mutual Exclusion
A bus arbiter grants access to one of three masters using grant[2:0]. Write an assertion that no two grant bits are ever high at the same time (one-hot or zero only).
***********************************************************/
property grant_one_hot;
    @(posedge clk)
    disable iff(!rst_n)
    // (grant == 3'b000) or (grant == 3'b010) or (grant == 3'b100) or (grant == 3'b001)
    $onehot0(grant);
endproperty

assert_grant_one_hot: assert property (grant_one_hot);

/***********************************************************
4. FIFO Overflow / Underflow
A FIFO has full, empty, wr_en, and rd_en. Write two assertions: one that wr_en is never high when full is high, and one that rd_en is never high when empty is high.
***********************************************************/
property no_write_when_full;
    @(posedge clk)
    disable iff(!rst_n)
    (full == 1)|-> !wr_en;
endproperty

assert_no_write_when_full: assert property (no_write_when_full);

property no_read_when_empty;
    @(posedge clk)
    disable iff(!rst_n)
    (empty == 1)|-> !rd_en;
endproperty

assert_no_read_when_empty: assert property (no_read_when_empty);


/***********************************************************
5. FSM State Transition
A 2-bit FSM has states IDLE (00), FETCH (01), EXECUTE (10), WRITEBACK (11). Write assertions that:

EXECUTE is only reachable from FETCH
WRITEBACK is only reachable from EXECUTE
***********************************************************/
property execute_only_from_fetch;
    @(posedge clk)
    disable iff (!rst_n)
    (state == EXECUTE && $past(state) != EXECUTE) |-> ($past(state) == FETCH);
endproperty

assert_execute_only_from_fetch: assert property (execute_only_from_fetch);

property writeback_only_from_execute;
    @(posedge clk)
    disable iff (!rst_n)
    (state == WRITEBACK) && $past(state != WRITEBACK) |-> $past(state) == EXECUTE;
endproperty

assert_execute_only_from_fetch: assert property (execute_only_from_fetch);
assert_writeback_only_from_execute: assert property (writeback_only_from_execute);

/***********************************************************
6. Data Stability During Burst
During an active burst (a signal burst_active held high for N cycles), a data_valid signal must be high every cycle, and the addr must increment by 4 each cycle. 
Write assertions covering both conditions.
***********************************************************/
property data_stability_during_burst;
    @(posedge clk)
    disable iff (!rst_n)
    burst_active |-> data_valid;
endproperty

property addr_increment_during_burst;
    @(posedge clk)
    disable iff (!rst_n)
    burst_active && $past(burst_active) |-> (addr == $past(addr)+4);
endproperty

assert_data_stability_during_burst: assert property (data_stability_during_burst);
assert_addr_increment_during_burst: assert property (addr_increment_during_burst);