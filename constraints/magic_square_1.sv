/********************************************

Write a SystemVerilog class with a rand int mat[4][4] such that:

1) Every element is in the range [1:16]
2) All 16 elements are unique (it's basically a shuffled 4x4 grid of 1 to 16)
3) The sum of each row equals the sum of its diagonal-opposite column (row i's sum must equal column i's sum, for all i)
4) The two main diagonals (top-left to bottom-right, and top-right to bottom-left) must have different sums from each other

*******************************************/

class packet;
    rand int mat[4][4];

    constraint c_range_of_values{
        foreach(mat[i,j]){
            mat[i][j] inside {[1:16]};
        }
    }

    constraint c_unique_matrix{
        foreach(mat[i,j]){
            foreach(mat[x,y]){
                if (!(x==i && y==j)){
                    mat[i][j] != mat[x][y];
                }
            }
        }
    }

    // Okay, I know this is not easy to understand but it's pretty hand. 
    // item here is the row we are are iterating over in the matrix for this reduction operation. 
    // Let's see an example p.mat.sum() with (item[0]) means -> Iterate over the matrix row by row and sum the first index element of all the rows. 
    // So it reduces to row0_first_index + row1_first_index + row2_first_index + row3_first_index.
    // To Sum the diagonal elements, instead of we use the loop variable index to sum row[index]. Where index is the row number. 
    // item[item.index] reduces to row0_0th_element + row1_1st_element + row2_2nd_element + row3_3rd_element
    constraint c_diagonal_sum_not_equal{
        mat.sum() with (item[item.index]) != mat.sum() with (item[3-item.index]);
    }

    constraint c_row_sum_equals_column_sum{
        foreach(mat[i]) {
            mat[i].sum() == mat.sum() with (item[i]); 
            //mat[i].sum = row sum
            //mat.sum() with (item[i]) = column sum. 
        }
    }



endclass

module test;
    packet p;
    initial begin
        p = new();
        if(p.randomize()) begin

            foreach(p.mat[i]) begin
                foreach(p.mat[i][j]) begin
                    $write("%0d ",p.mat[i][j]);
                end
                $display("");
            end
        end
    end
endmodule