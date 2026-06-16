/***************************
Write constraints to generate MxN matrix with each element with 0,1 and sum of all elements less the MAX_SUM
***************************/

class packet;
    rand bit arr[][];
    rand int max_sum;

    constraint c_arr_dimensions{
        arr.size() inside {[2:6]};

        arr[0].size() inside {[2:6]};
        foreach(arr[i]){
            arr[i].size() == arr[0].size();
        }
    }

    constraint c_arr_max_sum{
        max_sum inside {[0:arr.size()+arr[0].size()]};
    }

    constraint c_sum{
        arr.sum(row) with (
            row.sum(col) with (int'(col))
        ) <= max_sum;
    }

endclass: packet

module test;
    packet p;

    initial begin
        p = new();
        if(p.randomize()) begin
            $display("Max Sum = %0d, Generated Array: ",p.max_sum);
            foreach(p.arr[i]) begin
                foreach(p.arr[i][j]) begin
                    $write("%0b ",p.arr[i][j]);
                end
                $display("");
            end
        end
    end
endmodule