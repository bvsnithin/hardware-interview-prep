/*************

Matrix size should be randomized with only odd numbered square matrix. 

*************/

class packet;

    // Matrix declaration
    rand int unsigned mat[][];

    rand int m; //Size of the matrix, should be odd - 1,3,5,7,....

    // a. Matrix size should be randomized with only odd numbered square matrix. 
    constraint c_odd_size{
        m%2 == 1;
        m inside {[1:9]};
    }

    // Create an odd dimensions square matrix - (m x m)
    constraint c_mat_dimensions{
        mat.size() == m;
        foreach(mat[i]) {
            mat[i].size() == m;
        }
    }

    // Matrix elements range
    constraint c_mat_elements_range{
        foreach(mat[i,j]){
            mat[i][j] inside {[1:500]};
        }
    }


endclass

module test;
    packet p;

    initial begin
        repeat(5) begin
            $display("::::::::::::::::::::::::::::::::::::");
            p = new();
            if(p.randomize()) begin
                foreach(p.mat[i]) begin
                    foreach(p.mat[i][j]) begin
                        $write("%0d ", p.mat[i][j]);
                    end
                    $display("");
                end
            end
            $display("::::::::::::::::::::::::::::::::::::");
        end
    end
endmodule