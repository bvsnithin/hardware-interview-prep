/**************************
Write a constraint to generate two dynamic arrays such that array1 size = [6:9], array2 size = array1 size. 
Array 1 should be assembled in ascending order while array2 should have all the values picked from array1
**************************/

class packet;
    rand int arr1[];
    rand int arr2[];

    constraint c_arr_size{
        arr1.size() inside {[6:9]};
        arr2.size() == arr1.size();
    }

    constraint c_arr1_range{
        foreach(arr1[i]){
            arr1[i] inside {[0:20]};
        }
    }

    constraint c_arr1_ascending_order{
        foreach(arr1[i]){
            if(i>0){
                arr1[i] > arr1[i-1];
            }
        }
    }

    function void post_randomize();
        arr2 = arr1;
        arr2.shuffle();
    endfunction
endclass: packet

module test;
    packet p;
    initial begin
        p = new();
        if(p.randomize()) begin
            $display("%p",p.arr1);
            $display("%p",p.arr2);
        end
    end
endmodule