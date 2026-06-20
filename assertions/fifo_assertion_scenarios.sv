/*********************
Synchronous Fifo Assertion Properties
*********************/

// FIFO is full when the pointers are same, but the wrap bits are opposite. 
property fifo_full;
    @(posedge clk)
    disable iff(!rst_n)
    {wrt_wrap_bit, wrt_ptr} == {~rd_wrap_bit, rd_ptr} |-> (full);
endproperty

assert_fifo_full: assert property (fifo_full);

// FIFO is empty when both pointers and wrap bits are same
property fifo_empty;
    @(posedge clk)
    disable iff(!rst_n)
    ({wrt_wrap_bit, wrt_ptr} == {rd_wrap_bit, rd_ptr})|-> empty;
endproperty

assert_fifo_empty: assert property (fifo_empty);

// Overflow prevention: If wr_en is asserted when the FIFO is full, it is a protocol violation. 
property overflow_prevention;
    @(posedge clk)
    disable iff(!rst_n)
    !(wr_en  && full);
endproperty

assert_overflow_prevention: assert property (overflow_prevention);

// Underflow prevention: If rd_en is asserted when the FIFO is empty, it is a protocol violation.
property underflow_prevention;
    @(posedge clk)
    disable iff(!rst_n)
    !(rd_en && empty);
endproperty

assert_underflow_prevention: assert property (underflow_prevention);

// Reset state: When rst_n is deasserted (active-low), the FIFO empty status must be active, full must be inactive, and all pointers/wrap bits must be 0.
property reset_state;
    @(posedge clk)
    (!rst_n) |-> (empty) && (full==0) &&({wrt_wrap_bit, wrt_ptr} == '0) && ({rd_wrap_bit, rd_ptr}== '0);
endproperty

assert_reset_state: assert property (reset_state);

// Write pointer increment: If wr_en is asserted and FIFO is not full, the write pointer {wrt_wrap_bit, wrt_ptr} must increment by 1 on the next cycle.
property write_pointer_increment;
    @(posedge clk)
    disable iff(!rst_n)
    wr_en && (full==0) |=> ($past({wrt_wrap_bit, wrt_ptr})+1 == {wrt_wrap_bit, wrt_ptr});
endproperty

assert_write_pointer_increment: assert property (write_pointer_increment);

// Write pointer stability: If wr_en is not asserted (or the FIFO is full), the write pointer {wrt_wrap_bit, wrt_ptr} must remain stable/unchanged on the next cycle.
property write_pointer_stability;
    @(posedge clk)
    disable iff(!rst_n)
    !wr_en || full |=> $stable({wrt_wrap_bit, wrt_ptr});
endproperty

assert_write_pointer_stability: assert property (write_pointer_stability);

// Read pointer increment: If rd_en is asserted and FIFO is not empty, the read pointer {rd_wrap_bit, rd_ptr} must increment by 1 on the next cycle.
property read_pointer_increment;
    @(posedge clk)
    disable iff(!rst_n)
    (rd_en && (empty==0)) |=> ($past({rd_wrap_bit, rd_ptr})+1 == {rd_wrap_bit, rd_ptr});
endproperty

assert_read_pointer_increment: assert property (read_pointer_increment);

// Read pointer stability: If rd_en is not asserted (or the FIFO is empty), the read pointer {rd_wrap_bit, rd_ptr} must remain stable/unchanged on the next cycle.
property read_pointer_stability;
    @(posedge clk)
    disable iff(!rst_n)
    (!rd_en || empty) |=> $stable({rd_wrap_bit, rd_ptr});
endproperty

assert_read_pointer_stability: assert property (read_pointer_stability);

