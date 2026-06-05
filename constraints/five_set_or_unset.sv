/****
Question from NVIDIA panel - You are generating a 32-bit random variable in SystemVerilog. Write a constraint to ensure that the randomized value does not contain more than five consecutive bits that are all 1's or all. Solve without using 'unique' or 'post_randomize' keyword. 0's.

In other words, within the 32-bit value, there should be no sequence of 5 contiguous bits that are all set or all unset.
****/

class packet;
  rand bit [31:0] arr;

    constraint c{
        foreach(arr[i]){
          if(i<=27){
            !(&arr[i+:5]);
            !(&(~arr[i+:5]));
          }
        }
    }


endclass: packet

module five_set_or_unset;

    packet p = new();

    initial begin
        if(p.randomize()) begin
            $display("Randomization is successful");
            foreach(p.arr[i]) begin
                $write("%0d",p.arr[i]);
            end
        end
        else begin
            $display("Randomization has failed");
        end
    end
endmodule
