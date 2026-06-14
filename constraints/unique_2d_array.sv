/*****************
Write a constraint to randomize 2d array with unique elements
*****************/


class packet;
    rand int arr[][];

    constraint c_arr_dimensions{
        arr.size() inside {[2:6]};

        foreach(arr[i]){
            arr[i].size() == arr.size();
        }
    }

    constraint c_arr_range{
        foreach(arr[i,j]){
            arr[i][j] inside {[0:150]};
        }
    }

    constraint c_unique_elements{
        foreach(arr[i,j]){
            foreach(arr[x,y]){
                if(!(i==x && j==y)) arr[i][j] != arr[x][y];
            }
        }
    }
endclass: packet

module test;
    packet p = new();

    initial begin
        if(p.randomize()) begin
            $display("Generated unique 2d matrix:");
            foreach(p.arr[i]) begin
                foreach(p.arr[i][j]) $write("%0d ",p.arr[i][j]);
                $display("");
            end
        end
    end
endmodule