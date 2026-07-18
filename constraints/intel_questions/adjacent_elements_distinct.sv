/*********************************
Write uvm sv constraints to generate square matrix (m×m) where all adjacent elements are distinct. 
Adjacent means 4-neighborhood (up, down, left, right). For this question you can consider diagonal or not
*********************************/

class packet;
    rand int mat[][];
    rand int m; //Size

    constraint c_matrix_dimensions{
        m inside{[2:8]};
        solve m before mat;
    }

    constraint c_matrix{
        mat.size() == m;
        foreach(mat[i]){
            mat[i].size() == m;
        }
    }

    constraint c_range_of_values{
        foreach(mat[i,j]){
            mat[i][j] inside {[0:100]};
        }
    }

    //Adjacency constraint
    constraint c_left_and_right{
        foreach(mat[i,j]){
            // Left and Right must not be the same. 
            if(j < m-1){
                mat[i][j] != mat[i][j+1];
            }

            // Top and Bottom must not be same
            if(i < m-1){
                mat[i][j] != mat[i+1][j];
            }
        }
    }

    function void print_matrix(); 
        $display("------------------------------------");
        foreach(mat[i]) begin
            foreach(mat[i][j]) begin
                $write("%0d ", mat[i][j]);
            end
            $display("");
        end
        $display("------------------------------------");
    endfunction: print_matrix
    
endclass: packet

module test;
    packet p;
    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                p.print_matrix();
            end
        end
    end
endmodule