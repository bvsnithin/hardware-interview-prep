// Write a constraint on a two-dimensional array to generate even numbers in the first 4 locations and odd numbers in the next 4 locations.

class Packet;
    rand int arr[][]; // A 2 dimensional random array. Let's constraint such that it has 2 rows and 4 columns

    constraint c_arr_dimensions{
        arr.size() == 2; // Number of rows is 2
        arr[0].size == 4; // Each row has 4 elements, meaning 4 columns.
        arr[1].size == 4;
    }

    constraint c_range{
        foreach(arr[i,j]){
            arr[i][j] inside {[0:100]};
        }
    }

    constraint c_toprow_even{
        foreach (arr[0][i]){
            arr[0][i] % 2 == 0;
        }
    }

    constraint c_bottomrow_odd{
        foreach(arr[1][i]){
            arr[1][i] % 2 != 0;
        }
    }

endclass: Packet

module test;
    Packet p;

    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                foreach(p.arr[i]) begin
                    foreach(p.arr[i][j]) begin
                        $write("%0d ", p.arr[i][j]);
                    end
                    $display("");
                end
                $display("------------------");
            end
            else begin
                $display("Randomiztion has failed!");
            end
        end
        
    end
endmodule