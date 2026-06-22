/***************
Generate a parameterized array whose values are equal to a Magic square using constraints

A magic square is an N×N grid of distinct integers where the sum of every row, every column, and 
both main diagonals are all equal to the same number

Rules:
Unique matrix
Row sum == Column Sum == Diagonal Sum
***************/

class magic_square #(int N = 3);
    rand int arr[N][N];

    constraint c_arr_range{
        foreach(arr[i,j]) {
            arr[i][j] inside {[0:20]};
        }
    }
    
    constraint c_unique_array{
        foreach(arr[i,j]){
            foreach(arr[x,y]){
                if(!(i==x && j==y)){
                    arr[i][j] != arr[x][y];
                }
            }
        }
    }

    constraint c_row_sum{
        foreach(arr[i]){
            foreach(arr[j]){
                if(i!=j) arr[i].sum() == arr[j].sum();
            }
        }
    }

    constraint c_column_sum{
        //Iterate over the column arrays
        foreach(arr[,j]){
            arr.sum() with (item[j])==arr[0].sum();
        }
    }

    constraint c_diagonal_sum{
        //Iterate over the main diagonal
        arr.sum() with (item[item.index]) == arr[0].sum();
        //Iterate over the anti diagonal
        arr.sum() with (item[N-1-item.index]) == arr[0].sum();
    }

    


endclass: magic_square

module test;
    magic_square #(3) ms3;
    magic_square #(4) ms4;
    initial begin
        ms3 = new();
        ms4 = new();

        if(ms3.randomize()) begin
            $display("------------");
            foreach(ms3.arr[i]) begin
                foreach(ms3.arr[i][j]) begin
                    $write("%0d ",ms3.arr[i][j]);
                end
                $display("");
            end
        end
        $display("------------");
        if(ms4.randomize()) begin
            foreach(ms4.arr[i]) begin
                foreach(ms4.arr[i][j]) begin
                    $write("%0d ",ms4.arr[i][j]);
                end
                $display("");
            end
            $display("------------");
        end
    end
endmodule 