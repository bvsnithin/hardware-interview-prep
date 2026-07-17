/********************
Randomize an N×N Latin square: every row and every column contains each value 1..N exactly once

2x2 Latin Square
1 2
2 1

3x3 Latin Square
[1, 2, 3]
[3, 1, 2]
[2, 3, 1]
********************/

class packet;
    rand int arr[][];

    //Constraint for NxN matrix
    constraint c_size{
        arr.size() inside {[1:6]};
    }
    constraint c_row_size{
        arr[0].size() == arr.size();
        foreach(arr[i]){
            arr[i].size() == arr[0].size();
        }
    }
    constraint c_range_of_values{
        foreach(arr[i,j]){
            arr[i][j] inside {[1:arr.size()]};
        }
    }

    //Constraints for Latin Square
    constraint c_column_unique{
        foreach(arr[i,j]){
            foreach(arr[x,j]){
                if(i!=x) arr[i][j]!=arr[x][j];
            }
        }
    }
    constraint c_row_unique{
        foreach(arr[i,x]){
            foreach(arr[i,y]){
                if(x!=y) arr[i][x] != arr[i][y];
            }
        }
    }
endclass: packet


module test;
    packet p;
    initial begin
        // Print 5 Latin Squares
        repeat(5) begin
            p = new();
            if(p.randomize()) begin
                foreach(p.arr[i]) begin
                    foreach(p.arr[i][j]) begin
                        $write("%0d ", p.arr[i][j]);
                    end
                    $display("");
                end
                $display("::::::::::::::::::::::::::::::");
            end
        end
    end
endmodule