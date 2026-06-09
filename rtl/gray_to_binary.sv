module gray_to_binary #(
	N = 8
)(
  input logic [N-1:0] data,
  output logic [N-1:0] output_data
);
  logic [N-1:0] temp_data;
  always_comb begin: for_block 
    temp_data = data;
    for(int i = 0; i < N ;i++) begin
      output_data[i] = ^(temp_data);
      temp_data = temp_data >> 1;
    end
  end
	
endmodule

module test;
  localparam N = 8;
  logic [N-1:0] data;
  logic [N-1:0] output_data;
  
  gray_to_binary dut(.*);
  
  initial begin
    repeat(5) begin
      data = $random;
      #1;
      $display("Input gray coded data: %08b, Binary data: %08b",data,output_data);
    end
    $finish;
  end
endmodule
