/******************
Write constraint for an integer array with 10 elements such that exactly 3 of them are same and rest are unique
******************/

class packet;
    
    //Array is of size 10
    rand int arr[10];
    
    //It is the value that repeats 3 times
    rand int unsigned triple_value;

    constraint triple_value_constraint{
        triple_value inside {[0:9]};
    }

    constraint seven_unique{
        
        foreach(arr[i]){
            arr[i] inside {[0:9]};
            arr[i] != triple_value -> arr.sum() with (int'(item == arr[i])) == 1;
        }
    }

    constraint triple_repeat{
        arr.sum() with (int'(item == triple_value))==3;
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