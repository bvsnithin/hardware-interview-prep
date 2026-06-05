/******************
Write SystemVerilog constraint for integer array of 10 elements where exactly 3 elements share the 
same value (triplicate), and the remaining 7 elements are all different from the 
triplicate value. 
******************/

class packet;
    
    //Array is of size 10
    rand int arr[10];
    // Array that holds 3 indexes that have the same value
    rand int rand_pos[3];
    rand int trip_repeat_value;

    constraint range{
        foreach(arr[i]) {
            arr[i] inside {[0:255]};
        }

        trip_repeat_value inside {[0:255]};
    }

    constraint three_rand_pos_same{
        unique { rand_pos };

        foreach(rand_pos[i]) {
            rand_pos[i] inside {[0:9]};
        }

        arr[rand_pos[0]] == trip_repeat_value;
        arr[rand_pos[0]] == arr[rand_pos[1]];
        arr[rand_pos[1]] == arr[rand_pos[2]];
    }

    constraint other_pos_same_values{

        foreach(arr[i]) {
            if(!(i inside {rand_pos})) arr[i] != trip_repeat_value;
        }

    }





endclass: packet

module exactly_3_same_values;

    packet p = new();

    initial begin
        if(p.randomize()) begin
            $display("Randomization is successful");
            foreach(p.arr[i]) begin
                $display("arr[%0d]: %0d", i, p.arr[i]);
            end
        end
        else begin
            $display("Randomization has failed");
        end
    end
endmodule