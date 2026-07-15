/***************************
Write a function to identify all powers of 2s in a vector of ints
Write a constraint to generate an array with power of 2s and regular numbers
***************************/

class packet;
    rand int array[];
    rand int rand_indexes[];

    //Array size between 5 to 20
    constraint c_array_size{
        array.size() inside{[5:20]};
    }

    // Number of power of 2s in the array should be less than the size of the array
    constraint c_rand_indexes{
        rand_indexes.size() inside {[1:array.size()]};
    }

    // Array values are in the range of 1 to 1000
    constraint c_range{
        foreach(array[i]){
            array[i] inside {[1:1000]};
        }
    }

    // The indexes should be in range of the array size 
    constraint c_randomize_indexes{
        foreach(rand_indexes[i]){
            rand_indexes[i] inside {[0:array.size()-1]};
        }
    }

    //Unique random indexes
    constraint c_unique_random_indexes{
        unique {rand_indexes};
    }

    //Generate random power of 2 values
    constraint c_generate_power_of_2{
        foreach(rand_indexes[i]){
            array[rand_indexes[i]] inside {1,2,4,8,16,32,64,128,256,512};
        }
    }


endclass: packet

module test;
    packet p;
    int ans[];
    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                $display(".............................");
                $display("%p", p.array);
                $display("%p", p.rand_indexes);
                $display(".............................");
                

                identify_power_of_2(p.array, ans);
                $display("Powers of 2 are:");
                $display("%p", ans);
                $display(".............................");
            end
        end
    end

    function void identify_power_of_2(input int arr[], output int ans[]);
        automatic int count = 0;
        foreach(arr[i]) begin
            if((arr[i] & (arr[i]-1)) == 0) begin
                count++;
            end
        end

        ans = new[count];

        //Now used as an index
        count = 0;
        foreach(arr[i]) begin
            if((arr[i] & (arr[i]-1)) == 0) begin
                ans[count++] = arr[i];
            end
        end
    endfunction: identify_power_of_2
endmodule