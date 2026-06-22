/******
Generate a solved sudoku puzzle
******/

class sudoku;
    rand int arr[9][9];

    constraint c_arr_range{
        foreach(arr[i,j]){
            arr[i][j] inside {[1:9]};
        }
    }

    // Rules for a valid suduko
    // Value has to be unique in the row
    // Value has to be unique in the column
    // Value has to be unique in the 3x3 matrix

    constraint c_row_unique{
        foreach(arr[i]){                    // This will iterate over the rows: which is an array
            unique {arr[i]};                // Each row array has to be unique
        }
    }

    constraint c_column_unique{
        foreach(arr[i,j]){
            foreach(arr[x,j]){
                if(i != x){                 // If the columns are same then the values in columns must be all different frome each other. 
                    arr[i][j]!=arr[x][j];
                }
            }
        }
    }

    constraint c_block_unique {
        foreach(arr[i, j]) {
            foreach(arr[x, y]) {
                // If they are in the same 3x3 block but are not the same cell
                // i/3 == x/3 compares if they are in the same block 
                if ((i/3 == x/3) && (j/3 == y/3) && !(i == x && j == y)) {
                    arr[i][j] != arr[x][y];
                }
            }
        }
    }
endclass: sudoku

module test;
    sudoku s;
    initial begin
        s = new();
        if(s.randomize())begin
            foreach(s.arr[i]) begin
                foreach(s.arr[i][j]) begin
                    $write("%0d ",s.arr[i][j]);
                     if(j%3 ==2) $write(" ");
                end
                $display("");
                if(i%3 ==2) $display("");
            end
        end
    end
endmodule