/* 
- In order to capture the the pulse which is otherwise unseen by the receiving clock domain,
we have to strech the pulse in the fast
- Then pass this through a 2FF synchronizer to remove any metastability
- Then bring the pulse back in the slow receving clock domain by performing an xor operation between the 2FF sync output
and the delayed pulse in slow domain
*/


module pulse_synchronizer (
    // Fast Domain Interface
    input  logic clk_fast,
    input  logic rst_fast_n,
    input  logic pulse_fast_in,   // 1-cycle pulse in fast domain

    // Slow Domain Interface
    input  logic clk_slow,
    input  logic rst_slow_n,
    output logic pulse_slow_out   // Reconstructed 1-cycle pulse in slow domain
);

    //FAST DOMAIN: Convert incoming pulse to a Toggle Signal
    logic fast_toggle;

    always_ff @(posedge clk_fast or negedge rst_fast_n) begin
        if (!rst_fast_n) begin
            fast_toggle <= 1'b0;
        end else if (pulse_fast_in) begin
            fast_toggle <= ~fast_toggle; // Flip bit on every pulse
        end
    end


    // SLOW DOMAIN!
    // 2-FF Synchronizer in Slow Domain to remove any metastability

    logic sync_ff1, sync_ff2;


    // fast_toggle is the input to the slow domain. 

    // ---- INPUT SIGNAL -->  :FF1:  ---- FF1 OUTPUT -----> :FF2: --- OUTPUT WITHOUT ANY METASTABILITY  

    always_ff @(posedge clk_slow or negedge rst_slow_n) begin
        if (!rst_slow_n) begin
            sync_ff1 <= 1'b0;
            sync_ff2 <= 1'b0;
        end else begin
            sync_ff1 <= fast_toggle;
            sync_ff2 <= sync_ff1;
        end
    end

    // Toggle Detector (Delay + XOR)
    logic sync_ff3;

    always_ff @(posedge clk_slow or negedge rst_slow_n) begin
        if (!rst_slow_n) begin
            sync_ff3 <= 1'b0;
        end else begin
            sync_ff3 <= sync_ff2; // 1-cycle delayed version of synchronized toggle
        end
    end

    // XOR detects ANY transition (0 -> 1 or 1 -> 0) to generate a 1-cycle pulse
    assign pulse_slow_out = sync_ff2 ^ sync_ff3;

endmodule



//Testbench
module tb_pulse_synchronizer;

    // Fast Domain Interface
    logic clk_fast;
    logic rst_fast_n;
    logic pulse_fast_in;

    // Slow Domain Interface
    logic clk_slow;
    logic rst_slow_n;
    logic pulse_slow_out;

    pulse_synchronizer dut (
        .clk_fast(clk_fast),
        .rst_fast_n(rst_fast_n),
        .pulse_fast_in(pulse_fast_in),
        .clk_slow(clk_slow),
        .rst_slow_n(rst_slow_n),
        .pulse_slow_out(pulse_slow_out)
    );

    // Fast clock 100 MHz, 10ns period
    always begin
        #5 clk_fast = ~clk_fast;
    end

    // Slow clock generation 20 MHz, 50ns period
    always begin
        #25 clk_slow = ~clk_slow;
    end

    always @(posedge clk_slow) begin
        if (pulse_slow_out) begin
            $display("[Time %0t ns] SLOW: Reconstructed pulse detected!", $time);
        end
    end

    initial begin
        $dumpfile("waves_fixed.vcd");
        $dumpvars(0, tb_pulse_synchronizer);

        clk_fast = 0;
        clk_slow = 0;
        rst_fast_n = 0;
        rst_slow_n = 0;
        pulse_fast_in = 0;

        // Reset
        #40;
        rst_fast_n = 1;
        rst_slow_n = 1;
        $display("[Time %0t ns] Resets released.", $time);
        #20;

        // --- Pulse 1 ---
        $display("[Time %0t ns] FAST: Sending Pulse 1...", $time);
        @(posedge clk_fast);
        pulse_fast_in <= 1'b1;
        @(posedge clk_fast);
        pulse_fast_in <= 1'b0;

        // Delay to resolve pulse in the slow domain
        #200;

        // --- Pulse 2 ---
        $display("[Time %0t ns] FAST: Sending Pulse 2...", $time);
        @(posedge clk_fast);
        pulse_fast_in <= 1'b1;
        @(posedge clk_fast);
        pulse_fast_in <= 1'b0;

        #200;

        // --- Pulse 3 ---
        $display("[Time %0t ns] FAST: Sending Pulse 3...", $time);
        @(posedge clk_fast);
        pulse_fast_in <= 1'b1;
        @(posedge clk_fast);
        pulse_fast_in <= 1'b0;

        #300;

        $display("[Time %0t ns] Simulation finished.", $time);
        $finish;
    end

endmodule
