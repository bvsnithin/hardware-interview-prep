/*******************
Write SV constraint to limit sum of odd elements of an array to be 30 and sum of even elements to be 60
*******************/

class packet;
  rand int arr[];
  
  constraint c_arr_size{
    arr.size() inside {[5:20]};
  }

  constraint c_element_range{
    foreach(arr[i]){
        arr[i] dist {
            [-100:0]:= 20,
            [1:100]:= 80
        };
    }
  }

  constraint c_odd_even_sum{
    arr.sum() with (int'(item%2==0?item:0)) == 60;
    arr.sum() with (int'(item%2!=0?item:0)) == 30;
  }
  
endclass: packet

module test;
  packet p;
  initial begin
    p = new();
    if(p.randomize()) begin
      $display("%p",p.arr);
      end
  end
endmodule