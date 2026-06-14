/*******************
Write a constraint to randomize 3x3x3 array with unique elements
*******************/

//This is the comparsion of every element techinque
// class packet;
//     rand int arr[3][3][3];

//     constraint c_range_of_values{
//         foreach(arr[i,j,k]) {
//             arr[i][j][k] inside {[0:200]};
//         }
//     }

//     constraint c_unique_values{
//         foreach(arr[i,j,k]){
//             foreach(arr[x,y,z]){
//                 if(!(i==x && j==y && k==z)) {
//                     arr[i][j][k] != arr[x][y][z];
//                 }
//             }
//         }
//     }
// endclass: packet

// This is the flatten out and make it unique technique. 
class packet;
    rand int arr_flat[27];
    int arr[3][3][3];

    constraint c_range_of_values{
        foreach(arr_flat[i]) {
            arr_flat[i] inside {[0:200]};
        }
    }

    constraint c_flat_array_unique{
        unique {arr_flat};
    }

    function void post_randomize();

        int arr_index = 0;
        foreach (arr[i,j,k]) begin
            arr[i][j][k] = arr_flat[arr_index];
            arr_index++;
        end

    endfunction: post_randomize
endclass: packet

module test;
    packet p = new();

    initial begin
        if(p.randomize()) begin
            $display("Generated Array:");
            foreach(p.arr[i]) begin
                foreach(p.arr[i][j]) begin
                    foreach(p.arr[i][j][k]) begin
                        $write("%0d ",p.arr[i][j][k]);
                    end
                    $display("");
                end
                $display("");
            end
        end
    end
endmodule