module binary_to_gray #(
	N = 8
)(
  input logic [N-1:0] data,
  output logic [N-1:0] output_data
);
  
  assign output_data = data ^ (data >>1);
	
endmodule

module test;
  localparam N = 8;
  logic [N-1:0] data;
  logic [N-1:0] output_data;
  
  binary_to_gray dut(.*);
  
  initial begin
    repeat(5) begin
      data = $random;
      #1;
      $display("Input binary data: %08b, Output gray coded: %08b",data,output_data);
    end
    $finish;
  end
endmodule
