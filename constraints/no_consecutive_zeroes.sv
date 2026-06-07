/***************************
Generate dynamic array of 300 elements with values from {0,1,2,3,4,5}. 
UVM SV Constraints: (1) Each value appears at least 40 times, (2) No two consecutive 0s (adjacent 0s forbidden). Value 0 must be interspersed with other values.
***************************/

typedef int count_t[6];
class packet;

    rand int arr[];

    constraint c_size{
        arr.size()==300;
    }

    constraint c_bounds{
        foreach(arr[i]) arr[i] inside {[0:5]};
    }

    constraint c_freq{
        arr.sum() with (int'(item==0)) >= 40;
        arr.sum() with (int'(item==1)) >= 40;
        arr.sum() with (int'(item==2)) >= 40;
        arr.sum() with (int'(item==3)) >= 40;
        arr.sum() with (int'(item==4)) >= 40;
        arr.sum() with (int'(item==5)) >= 40;
    }

    constraint c_no_repeat{
        foreach(arr[i]) {
            if((i>0) && (arr[i]==0)){
                arr[i] != arr[i-1];
            }
        }
    }
    
    function automatic count_t count(int array[]);
        int count_array[6] = {0,0,0,0,0,0};
        for(int i = 0;i<300;i++) begin
            count_array[array[i]]++;
        end
        return count_array;
    endfunction: count

endclass: packet

module test;

    packet p = new();
    count_t count_array;

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                count_array = p.count(p.arr);
                $display("%p",p.arr);
                $display("Randomization is successful, Count of 0 = %0d, Count of 1 = %0d, Count of 2 = %0d, Count of 3 = %0d, Count of 4 = %0d, Count of 5 = %0d", count_array[0], count_array[1], count_array[2], count_array[3], count_array[4], count_array[5]);
            end
            else begin
                $display("Randomization has failed");
            end
        end
    end

endmodule