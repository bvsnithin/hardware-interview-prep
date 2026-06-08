// Write uvm sv constraint for variable where number of 1-bits equals number of 0-bits. Balanced bit pattern. Requires even bit width.

class packet;
  rand bit [15:0] arr;
  
//   constraint c_arr{
//     arr.sum() with (int'(item==1)) == (15+1)/2;
//     arr.sum() with (int'(item==0)) == (15+1)/2;
  //   } //Cant use this because sum is only for unpacked arrays

  constraint c_arr{
    $countones(arr) == 8;
  }
endclass

module test;
  packet p = new();
  initial begin
  	repeat(5) begin
    	if(p.randomize()) begin
      	$display("Randomization is successful: %016b",p.arr);
    	end
  	end
  end
endmodule
