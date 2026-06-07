/*************************************
Generate dynamic array of exactly 300 elements. Elements take values from {0,1,2,3,4}. 
UVM SV Constraints: (1) Each value (0,1,2,3,4) appears at least 40 times, (2) Value 0 can appear consecutively, (3) Values 1,2,3,4 cannot appear consecutively (no adjacent repeats).
*************************************/

typedef int count_t[5];

class packet;
    rand int arr[];

    constraint c_size_range{
        arr.size()==300;

        foreach(arr[i]) {
            arr[i] inside {[0:4]};
        }
    }

    constraint c_freq{
        
        arr.sum() with (int'(item == 0)) >= 40;
        arr.sum() with (int'(item == 1)) >= 40;
        arr.sum() with (int'(item == 2)) >= 40;
        arr.sum() with (int'(item == 3)) >= 40;
        arr.sum() with (int'(item == 4)) >= 40;

    }

    constraint c_adjacent_no_repeat{
        foreach(arr[i]){
            if((i>0) && (arr[i] inside {[1:4]})) {
                arr[i] != arr[i-1];
            }
        }
    }

    function automatic count_t count(int array[]);
        int count_arr[5] = {0,0,0,0,0};
        foreach(array[i]) begin
            if(array[i]==0) count_arr[0]++;
            else if(array[i]==1) count_arr[1]++;
            else if(array[i]==2) count_arr[2]++;
            else if(array[i]==3) count_arr[3]++;
            else if(array[i]==4) count_arr[4]++;
        end
        return count_arr;
    endfunction: count

endclass: packet

module test;

    packet p = new();
    count_t count_arr;

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                count_arr = p.count(p.arr);
                $display("%p",p.arr);
                $display("Randomization is successful, Count of 0 = %0d, Count of 1 = %0d, Count of 2 = %0d, Count of 3 = %0d, Count of 4 = %0d", count_arr[0], count_arr[1], count_arr[2], count_arr[3], count_arr[4]);
            end
            else begin
                $display("Randomization has failed");
            end
        end
    end

endmodule