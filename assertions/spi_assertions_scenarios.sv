/********************************************************************************************************************************************
Chip Select Active During Transfer
Whenever sclk toggles for a transaction, cs_n must remain low.
********************************************************************************************************************************************/

property c_sel_active_during_trans;
    @(posedge clk)
    disable iff(!rst_n)
    !$stable(sclk) |-> !cs_n;
endproperty

assert_c_sel_active_during_tras assert property(c_sel_active_during_trans);

/********************************************************************************************************************************************
No Clock Activity When Deselected
When cs_n is high, sclk must not toggle.
********************************************************************************************************************************************/

property no_clk_activity_when_deselected;
    @(posedge clk)
    disable iff(!rst_n)
    cs_n |-> $stable(sclk);
endproperty

assert_no_clk_activity_when_deselected assert property(no_clk_activity_when_deselected);

/********************************************************************************************************************************************
MOSI Stable Around Sampling Edge
In SPI Mode 0, mosi should not change on the edge where the receiver samples it.
********************************************************************************************************************************************/

property mosi_stable_around_sampling_edge;
    @(posedge clk)
    disable iff(!rst_n)
    (spi_mode == 2'b00 && $rose(sclk)) |-> $stable(mosi);
endproperty

assert_mosi_stable_around_sampling_edge assert property(mosi_stable_around_sampling_edge);

/********************************************************************************************************************************************
Transfer Starts with CS Assertion
A transaction begins only after cs_n transitions from high to low.
********************************************************************************************************************************************/

property transfer_starts_with_cs_assertion;
    @(posedge clk)
    disable iff(!rst_n)
    $fell(cs_n) |-> transaction_begin;
endproperty

assert_transfer_starts_with_cs_assertion assert property(transfer_starts_with_cs_assertion);

/********************************************************************************************************************************************
Transfer Ends with CS Deassertion
Once cs_n goes high, no further data bits should be transmitted until the next transaction.
********************************************************************************************************************************************/

property transfer_ends_with_cs_deassertion;
    @(posedge clk)
    disable iff(!rst_n)
    cs_n |-> $stable(sclk) && $stable(mosi);
endproperty

assert_transfer_ends_with_cs_deassertion assert property(transfer_ends_with_cs_deassertion);

/********************************************************************************************************************************************
Exactly 8 Clock Cycles Per Byte
From the falling edge of cs_n until it rises again, there should be exactly 8 active sclk sampling edges.
********************************************************************************************************************************************/

property exactly_8_clock_cycles_per_byte;
    int count;
    @(posedge clk)
    disable iff(!rst_n)
    $fell(cs_n) |-> (1, count = 0) ##1 (($rose(sclk), count = count + 1) or (!$rose(sclk)))[*0:$] ##1 $rose(cs_n) |-> (count == 8);
endproperty

assert_exactly_8_clock_cycles_per_byte assert property(exactly_8_clock_cycles_per_byte);

/********************************************************************************************************************************************
Bit Counter Increments
While cs_n is low, bit_count increments by one on every sampling edge until it reaches 7.
********************************************************************************************************************************************/

property bit_counter_increments;
    @(posedge clk)
    disable iff(!rst_n)
    (!cs_n && $rose(sclk) && bit_count < 7) |-> (bit_count == $past(bit_count) + 1'b1);
endproperty

assert_bit_counter_increments assert property(bit_counter_increments);

/********************************************************************************************************************************************
Bit Counter Reset
When cs_n rises, bit_count returns to 0 on the next system clock.
********************************************************************************************************************************************/

property bit_counter_reset;
    @(posedge clk)
    disable iff(!rst_n)
    $rose(cs_n) |=> (bit_count == 0);
endproperty

assert_bit_counter_reset assert property(bit_counter_reset);

/********************************************************************************************************************************************
Shift Register Updates
On every sampling edge while cs_n is low, the transmit shift register shifts by one bit.
********************************************************************************************************************************************/

property shift_register_updates;
    @(posedge clk)
    disable iff(!rst_n)
    (!cs_n && $rose(sclk)) |-> (tx_shift_reg == ($past(tx_shift_reg) >> 1) || tx_shift_reg == ($past(tx_shift_reg) << 1));
endproperty

assert_shift_register_updates assert property(shift_register_updates);

/********************************************************************************************************************************************
Done Pulse Generation
done should assert exactly once after the eighth bit is transferred.
********************************************************************************************************************************************/

property done_pulse_generation;
    @(posedge clk)
    disable iff(!rst_n)
    (bit_count == 3'd7 && $rose(sclk)) |=> done ##1 !done;
endproperty

assert_done_pulse_generation assert property(done_pulse_generation);

/********************************************************************************************************************************************
No Premature Done
done must never assert before 8 bits have been transferred.
********************************************************************************************************************************************/

property no_premature_done;
    @(posedge clk)
    disable iff(!rst_n)
    (bit_count < 3'd7) |-> !done;
endproperty

assert_no_premature_done assert property(no_premature_done);

/********************************************************************************************************************************************
Done Follows Final Bit
After the eighth sampling edge, done should assert within one clock cycle.
********************************************************************************************************************************************/

property done_follows_final_bit;
    @(posedge clk)
    disable iff(!rst_n)
    (bit_count == 3'd7 && $rose(sclk)) |=> done;
endproperty

assert_done_follows_final_bit assert property(done_follows_final_bit);

/********************************************************************************************************************************************
CS Remains Low Throughout Byte
cs_n must not deassert before all 8 bits are transferred.
********************************************************************************************************************************************/

property cs_remains_low_throughout_byte;
    @(posedge clk)
    disable iff(!rst_n)
    (bit_count < 3'd7) |-> !cs_n;
endproperty

assert_cs_remains_low_throughout_byte assert property(cs_remains_low_throughout_byte);

/********************************************************************************************************************************************
Data Stable Between Launch and Sample
For the selected SPI mode, the transmitting device changes data only on launch edges and keeps it stable until the corresponding sample edge.
********************************************************************************************************************************************/

property data_stable_between_launch_and_sample;
    @(posedge clk)
    disable iff(!rst_n)
    (spi_mode == 2'b00 && !sclk) |-> $stable(mosi) && $stable(miso);
endproperty

assert_data_stable_between_launch_and_sample assert property(data_stable_between_launch_and_sample);

/********************************************************************************************************************************************
Back-to-Back Transactions
If one transaction completes and another starts immediately, bit_count must reset correctly before counting the new byte.
********************************************************************************************************************************************/

property back_to_back_transactions;
    @(posedge clk)
    disable iff(!rst_n)
    ($rose(cs_n) ##1 $fell(cs_n)) |=> (bit_count == 0);
endproperty

assert_back_to_back_transactions assert property(back_to_back_transactions);

/********************************************************************************************************************************************
Illegal Clock Detection
If cs_n is high, any detected sclk edge should trigger an assertion failure.
********************************************************************************************************************************************/

property illegal_clock_detection;
    @(posedge clk)
    disable iff(!rst_n)
    (cs_n && !$stable(sclk)) |-> 1'b0;
endproperty

assert_illegal_clock_detection assert property(illegal_clock_detection);

/********************************************************************************************************************************************
Transaction Length Parameterization
Generalize the assertion so that a transfer consists of N bits rather than being fixed at 8.
********************************************************************************************************************************************/

property transaction_length_parameterization;
    @(posedge clk)
    disable iff(!rst_n)
    (bit_count < (N_BITS - 1)) |-> !cs_n;
endproperty

assert_transaction_length_parameterization assert property(transaction_length_parameterization);

/********************************************************************************************************************************************
No Unknowns During Active Transfer
While cs_n is low, mosi and miso must never be X or Z.
********************************************************************************************************************************************/

property no_unknowns_during_active_transfer;
    @(posedge clk)
    disable iff(!rst_n)
    !cs_n |-> !$isunknown(mosi) && !$isunknown(miso);
endproperty

assert_no_unknowns_during_active_transfer assert property(no_unknowns_during_active_transfer);

/********************************************************************************************************************************************
CPOL/CPHA-Aware Sampling
Write assertions that adapt to configurable CPOL/CPHA settings and verify sampling and launching on the correct edges.
********************************************************************************************************************************************/

property cpol_cpha_aware_sampling;
    @(posedge clk)
    disable iff(!rst_n)
    (((cpol == cpha) && $rose(sclk)) || ((cpol != cpha) && $fell(sclk))) |-> $stable(mosi);
endproperty

assert_cpol_cpha_aware_sampling assert property(cpol_cpha_aware_sampling);

/********************************************************************************************************************************************
Continuous Transfer Mode
If cs_n stays low across multiple bytes, ensure that done pulses every 8 bits and the bit counter wraps correctly without requiring cs_n to toggle.
********************************************************************************************************************************************/

property continuous_transfer_mode;
    @(posedge clk)
    disable iff(!rst_n)
    (!cs_n && bit_count == 3'd7 && $rose(sclk)) |=> done ##1 (bit_count == 0);
endproperty

assert_continuous_transfer_mode assert property(continuous_transfer_mode);
