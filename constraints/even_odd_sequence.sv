/**********
Question:
array of integers for which we want a patterned series of N even values followed by N odd values
    rand int array[];
    rand int N;

Create a constraint which will ensure that
the array is randomized according
to our pattern
EX (N = 2): {0, 2, 3, 5}
EX (N = 5): {18, 8, 18, 24, 98, 9, 15, 33, 71, 1}
EX (N = 1): {4, 1, 22, 9, 36}
**********/



class even_odd_sequence;
    rand int arr[];
    rand int N;

    constraint c_unique_arr{
        unique {arr};
    }

    constraint pattern{
        foreach(arr[i]){
            if((i/N)%2 ==0){
                arr[i]%2 == 0;
            }
            else{
                arr[i]%2 == 1;
            }
        }
    }

    constraint c_array_range{
        foreach(arr[i]){
            arr[i] inside {[0:100]};
        }
    }

    constraint c_c_array_range_size{
        arr.size() inside {[5:20]};
    }

    constraint c_range_N{
        N inside {[1:5]};
    }
endclass

module test;
    even_odd_sequence inst = new();

    initial begin
        repeat(5) begin
            if(inst.randomize()) begin
                $display("N: %0d, Array: %p",inst.N,inst.arr);
            end
        end
    end
endmodule