/*****************************
VALID before READY
Once AWVALID is asserted, it must remain high until AWREADY is seen (i.e, AWVALID must not deassert before the handshake completes)
*****************************/

property axi_handshake;
    @(posedge clk)
    disable iff(!rst_n)
    $rose(AWVALID) |-> AWVALID until_with (AWVALID && AWREADY);
    // AWVALID && !AWREADY |=> AWVALID;
endproperty

assert_axi_handshake: assert property(axi_handshake);

/******************************
MESI: modified state exclusivity
In a MESI cache coherence protocol, only one cache may hold a line in Modified (M) state at a time. 
Write an SVA assertion (system-level, across two caches cache0 and cache1) to enforce this.
******************************/

property mesi_m_exclusive;
    @(posedge clk)
    disable iff(!rst_n)
    !(cache0.state==M && cache1.state==M);
endproperty