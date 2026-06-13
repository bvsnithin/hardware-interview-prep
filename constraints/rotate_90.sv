/**********************
Write a constraint for square matrix and then rotate 90 counter clock wise
**********************/

class packet;
    
    rand int arr[][];

    constraint c_square_matrix{
        arr.size() inside {[2:9]};

        foreach(arr[i]){
            arr.size() == arr[i].size();
        }
    }

    function void post_randomize();
        int count = 1;

        foreach(arr[i,j]) begin
            arr[i][j] = count++;
        end
    endfunction: post_randomize

endclass: packet

// Display rotated array without actually rotating the array
// module test;
//     packet p = new();
//     int n;

//     initial begin
//         if(p.randomize()) begin
//             //Get size
//             n = p.arr[0].size();

//             $display("Originial Matrix");
//             foreach(p.arr[i]) begin
//                 foreach(p.arr[i][j]) begin
//                     $write("%0d ",p.arr[i][j]);
//                 end
//                 $display();
//             end

//             $display("-------------------\nCounter clockwise 90 Degree Rotated Matrix");
//             foreach(p.arr[i]) begin
//                 foreach(p.arr[i][j]) begin
//                     $write("%0d ",p.arr[j][n-1-i]);
//                 end
//                 $display();
//             end
//         end
//     end
// endmodule


// Write a function to rotate the array.
module test;
    packet p = new();
    int n;
    int rotated_mat[][];

    initial begin
        if(p.randomize()) begin
            n = p.arr[0].size();
            $display("Original Matrix");
            foreach(p.arr[i]) begin
                foreach(p.arr[i][j]) begin
                    $write("%0d ",p.arr[i][j]);
                end
                $display("");
            end

            rotate_by_90_degree(p.arr,n,rotated_mat);

            $display("Rotated Matrix");
            foreach(rotated_mat[i]) begin
                foreach(rotated_mat[i][j]) begin
                    $write("%0d ",rotated_mat[i][j]);
                end
                $display("");
            end


        end
    end

    function void rotate_by_90_degree(input int mat[][], input int n, output int rotate[][]);
        rotate = new[n];
        foreach(rotate[i]) rotate[i] = new[n];
        foreach(mat[i,j]) begin
            rotate[i][j] = mat[j][n-1-i];
        end
    endfunction: rotate_by_90_degree
                    
    
endmodule