// Assertion starter template
module assertion_template (
  input logic        clk,
  input logic        rst_n,
  input logic        valid,
  input logic        ready,
  input logic [31:0] data
);


  property p_check;
    @(posedge clk) disable iff (!rst_n)
      valid == 1'b1 |-> (data == 1'b1);
  endproperty

  assert property (p_check)
    else $error("Assertion failed at time %0t", $time);

endmodule
