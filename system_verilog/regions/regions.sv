/*
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
               SYSTEMVERILOG SIMULATION REGIONS (IEEE 1800-2017)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
+-------+---------------+-------------------------------------------------------------+
| Order | Region Name   | What Happens Here?                                          |
+-------+---------------+-------------------------------------------------------------+
|   1   | PREPONED      | Samples concurrent assertions and clocking block inputs     |
|       |               | (with default #1step skew). Values are stable from prev step|
+-------+---------------+-------------------------------------------------------------+
|   2   | ACTIVE        | Evaluates design blocking assignments (=), module continuous|
|       |               | assignments, RHS of module non-blocking assignments (<=).   |
+-------+---------------+-------------------------------------------------------------+
|   3   | INACTIVE      | Executes #0 blocking assignments inside design modules.     |
+-------+---------------+-------------------------------------------------------------+
|   4   | NBA           | Updates LHS of design non-blocking assignments (<=).        |
|       |               | (May trigger new events, looping back to Active/Inactive)   |
+-------+---------------+-------------------------------------------------------------+
|   5   | OBSERVED      | Evaluates concurrent assertions. Samples clocking block     |
|       |               | inputs with explicit #0 skew.                               |
+-------+---------------+-------------------------------------------------------------+
|   6   | REACTIVE      | Executes program block processes (testbench code), blocking |
|       |               | assignments (=), RHS of program non-blocking assignments.   |
+-------+---------------+-------------------------------------------------------------+
|   7   | RE-INACTIVE   | Executes #0 blocking assignments inside program blocks.     |
+-------+---------------+-------------------------------------------------------------+
|   8   | RE-NBA        | Updates LHS of program non-blocking assignments (<=).       |
|       |               | Drives clocking block outputs.                              |
+-------+---------------+-------------------------------------------------------------+
|   9   | POSTPONED     | Runs $monitor, $strobe, and functional coverage collection. |
|       |               | No signals can change value in this region.                 |
+-------+---------------+-------------------------------------------------------------+
*/

module top;
    logic clk = 0;
    logic sig = 0;
    logic sig_nba = 0;

    // Clock generator (Toggles every 5ns)
    always #5 clk = ~clk;

    // Clocking block (Preponed sampling by default using #1step skew)
    clocking cb @(posedge clk);
        default input #1step;
        input sig;
    endclocking

    // [Region 2] ACTIVE: Standard module event
    always @(posedge clk) begin
        $display("\n--- Time %0t: posedge clk ---", $time);
        $display("[2] Active: Module always block starting.");
        sig = 1;         // Immediate update in Active
        sig_nba <= 1;    // Scheduled to update in NBA region
        $display("[2] Active: Changed 'sig' to %b, scheduled 'sig_nba' to 1", sig);
    end

    // [Region 3] INACTIVE: Module #0
    always @(posedge clk) begin
        #0; // Suspends process and schedules execution in the Inactive region
        $display("[3] Inactive: Module #0 executing after all Active events have completed.");
    end

    // [Region 4] NBA Event Trigger
    always @(sig_nba) begin
        // The NBA region updates sig_nba to 1, which triggers this sensitivity block
        // scheduling it back into the Active region loop.
        $display("[4] Active (via NBA trigger): 'sig_nba' updated to %b in NBA region.", sig_nba);
    end

    // [Region 5] OBSERVED: Concurrent Assertions
    // Evaluates expression after Active, Inactive, and NBA loops have fully stabilized.
    ap_observed: assert property (@(posedge clk) sig == 1) 
        $display("[5] Observed: Concurrent assertion passed. 'sig' is %b", sig);
    else 
        $display("[5] Observed: Assertion failed!");
    // Assertion fails because the value of sig at time of sampling(preponed region) is 0

    // [Region 9] POSTPONED: Read-only final look
    always @(posedge clk) begin
        $strobe("[9] Postponed: $strobe executes here. Final 'sig' = %b, 'sig_nba' = %b", sig, sig_nba);
    end

    // Instantiate the testbench program block (controls Regions 6, 7, and 8)
    test_program prog_inst();

    // End simulation
    initial begin
        #15;
        $finish;
    end
endmodule


program test_program();
    logic prog_nba = 0;

    // [Region 6] REACTIVE: Program block process triggered by clocking block event
    initial begin
        forever begin
            @(top.cb);
            // top.cb.sig samples 'sig' in the PREPONED region (which holds the stable value before the clock edge, i.e., 0)
            $display("[6] Reactive: Program block triggered. Clocking block sampled 'sig' = %b", top.cb.sig);
            
            prog_nba <= 1; // Scheduled to update in Re-NBA region
            
            #0; // Suspends process and schedules execution in Re-Inactive region
            $display("[7] Re-Inactive: Program #0 executing after Reactive events have settled.");
        end
    end

    // [Region 8] Re-NBA Event Trigger
    initial begin
        forever begin
            @(prog_nba);
            // The Re-NBA region updates prog_nba, triggering this process to schedule back into the Reactive region
            $display("[8] Reactive (via Re-NBA trigger): Program NBA 'prog_nba' updated to %b", prog_nba);
        end
    end
endprogram