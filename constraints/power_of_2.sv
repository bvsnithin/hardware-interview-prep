/******** 
Write a constraint for generating the 2 power numbers with out using ** operator
Output an array with a random number of 2 power numbers in binary. In other words randomize an array with one hot numbers. 
Display both binary and decimal
*********/

//Array of power of 2 numbers in binary
class packet;   
    rand bit[7:0] arr[];
    rand int bit_pos[]; //This array stores random bit positions that we will set to high. 

    //randomize the size of array
    constraint c_size{
        arr.size() inside {
            [3:8]
        };

        bit_pos.size() == arr.size();
    }
    
    //Value of bit indexes has to be in the range of size of the array. bit positions has be to in the range of [0,arr.size()-1];
    constraint c_bit_post_range{
        foreach(bit_pos[i]) {
            bit_pos[i] < arr.size() && bit_pos[i] > -1;
        }
    }

    constraint c_unique_bit_positions{
        unique {bit_pos};
    }

    constraint c_power_of_2{
        foreach(arr[i]){
            arr[i] == 8'b1 << bit_pos[i];
        }
    }
endclass: packet

module test;
    packet p = new();

    initial begin
        if(p.randomize()) begin
            $display("Generated values");
            for(int i =0;i<p.arr.size();i++) begin
                $display("Decimal: %0d, Binary = %08b",p.arr[i],p.arr[i]);
            end
        end
    end
endmodule
