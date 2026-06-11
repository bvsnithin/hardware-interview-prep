//
// Problem Statement:
//   A design has a 2-bit state signal pwr_state with the following values:
//     2'b00 (ACTIVE)
//     2'b01 (SLEEP)
//     2'b10 (DEEP_SLEEP)
//   Create a covergroup that samples on the rising edge of clk.
//   Track the consecutive transition where the design goes directly from ACTIVE to DEEP_SLEEP.


  typedef enum logic[1:0] {ACTIVE, SLEEP, DEEP_SLEEP} states;

module pwr_state_cov(
  input clk,
  input states pwr_state
);

  covergroup cg_pwr_transition @(posedge clk);
    cp_pwr_state: coverpoint pwr_state{
      bins active_to_deep_sleep = (ACTIVE => DEEP_SLEEP);
    }
  endgroup

  cg_pwr_transition cg_inst;  //Handle to the covergroup

  initial begin
    cg_inst = new();
  end

endmodule

module test;
  logic clk;
  states pwr_state;

  pwr_state_cov dut(.*);

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    pwr_state = SLEEP;
    @(posedge clk);

    pwr_state = ACTIVE;
    @(posedge clk);
    pwr_state = ACTIVE;
    @(posedge clk);
    pwr_state = SLEEP;
    @(posedge clk);

    $display("Simulation Finished.");
    $display("Overall Coverage = %0f%%", $get_coverage());
    $display("Instance Transition Coverage = %0f%%", dut.cg_inst.get_inst_coverage());

    $finish;

  end

endmodule