/**********
Create a matrix multiplication compliant 2D arrays
**********/

class Matrix_Multiplication;
    rand bit[7:0] matA[][];
    rand bit[7:0] matB[][];
    rand int  rows_a;
    rand int rows_b;
    rand int col_a;
    rand int col_b;

    constraint c_matrix_size{
        rows_a inside {[2:5]};
        rows_b inside {[2:5]};
        col_a inside {[2:5]};
        col_b inside {[2:5]};
    }

    constraint c_mul_compatible{
        col_a == rows_b;
    }

    constraint c_solve_before{
        solve rows_a, rows_b, col_a, col_b before matA, matB;
    }

    constraint c_mat_size{
        matA.size() == rows_a;
        matB.size() == rows_b;

        foreach(matA[i]){
            matA[i].size() == col_a;
        }
        foreach(matB[i]){
            matB[i].size() == col_b;
        }
    }

    constraint c_mat_range{
        foreach(matA[i,j]){
            matA[i][j] < 50;
        }

        foreach(matB[i,j]){
            matB[i][j] < 50;
        }
    }

endclass: Matrix_Multiplication


module test;
    Matrix_Multiplication m;

    initial begin
        repeat(5) begin
            m = new();
            if(m.randomize()) begin
                $display("------------");
                foreach(m.matA[i]) begin
                    foreach(m.matA[i][j]) begin
                        $write("%0d ",m.matA[i][j]);
                    end
                    $display("");
                end
                $display("-------------");
                foreach(m.matB[i]) begin
                    foreach(m.matB[i][j]) begin
                        $write("%0d ",m.matB[i][j]);
                    end
                    $display("");
                end
            end
        end
    end

endmodule