// From Slow Domain to Fast Domain

module pulse_synchronizer(
    // Slow Domain Interface (Source)
    input  logic clk_slow,
    input  logic rst_slow_n,
    input  logic pulse_slow_in,    // 1-cycle pulse in slow domain

    // Fast Domain Interface (Destination)
    input  logic clk_fast,
    input  logic rst_fast_n,
    output logic pulse_fast_out    // Reconstructed 1-cycle pulse in fast domain
);

    // Since the source clock (slow) is slower than the destination clock (fast),
    // a 1-cycle pulse in the slow domain is guaranteed to be wider than the fast clock period.
    // Thus, it will not be missed by the fast clock.
    // We only need a 2-FF synchronizer followed by a rising-edge detector in the fast domain.

    logic sync_ff1, sync_ff2;

    // 2-FF Synchronizer in the Fast Domain
    always_ff @(posedge clk_fast or negedge rst_fast_n) begin
        if (!rst_fast_n) begin
            sync_ff1 <= 1'b0;
            sync_ff2 <= 1'b0;
        end else begin
            sync_ff1 <= pulse_slow_in;
            sync_ff2 <= sync_ff1;
        end
    end

    // Edge Detector in the Fast Domain
    logic sync_ff3;

    always_ff @(posedge clk_fast or negedge rst_fast_n) begin
        if (!rst_fast_n) begin
            sync_ff3 <= 1'b0;
        end else begin
            sync_ff3 <= sync_ff2; // Delayed version of synchronized signal
        end
    end

    // Detect rising edge (0 -> 1 transition) in the fast domain
    assign pulse_fast_out = sync_ff2 & ~sync_ff3;

endmodule


// Testbench
module tb;

    // Slow Domain Interface
    logic clk_slow;
    logic rst_slow_n;
    logic pulse_slow_in;

    // Fast Domain Interface
    logic clk_fast;
    logic rst_fast_n;
    logic pulse_fast_out;

    // Instantiate UUT
    pulse_synchronizer dut (
        .clk_slow(clk_slow),
        .rst_slow_n(rst_slow_n),
        .pulse_slow_in(pulse_slow_in),
        .clk_fast(clk_fast),
        .rst_fast_n(rst_fast_n),
        .pulse_fast_out(pulse_fast_out)
    );

    // Slow clock generation (20 MHz, 50ns period)
    always begin
        #25 clk_slow = ~clk_slow;
    end

    // Fast clock generation (100 MHz, 10ns period)
    always begin
        #5 clk_fast = ~clk_fast;
    end

    // Monitor reconstructed pulses in fast domain
    always @(posedge clk_fast) begin
        if (pulse_fast_out) begin
            $display("[Time %0t ns] FAST: Reconstructed pulse detected!", $time);
        end
    end

    initial begin
        $dumpfile("slow_to_fast_waves.vcd");
        $dumpvars(0, tb);

        clk_slow = 0;
        clk_fast = 0;
        rst_slow_n = 0;
        rst_fast_n = 0;
        pulse_slow_in = 0;

        // Release resets
        #40;
        rst_slow_n = 1;
        rst_fast_n = 1;
        $display("[Time %0t ns] Resets released.", $time);
        #20;

        // --- Pulse 1 ---
        $display("[Time %0t ns] SLOW: Sending Pulse 1...", $time);
        @(posedge clk_slow);
        pulse_slow_in <= 1'b1;
        @(posedge clk_slow);
        pulse_slow_in <= 1'b0;

        #200;

        // --- Pulse 2 ---
        $display("[Time %0t ns] SLOW: Sending Pulse 2...", $time);
        @(posedge clk_slow);
        pulse_slow_in <= 1'b1;
        @(posedge clk_slow);
        pulse_slow_in <= 1'b0;

        #200;

        // --- Pulse 3 ---
        $display("[Time %0t ns] SLOW: Sending Pulse 3...", $time);
        @(posedge clk_slow);
        pulse_slow_in <= 1'b1;
        @(posedge clk_slow);
        pulse_slow_in <= 1'b0;

        #200;

        $display("[Time %0t ns] Simulation finished.", $time);
        $finish;
    end

endmodule