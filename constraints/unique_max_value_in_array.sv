/********************
Write a constraint for a 2d array such that it has a unique max value in each row and that max value should not be equal to any other max value in other rows
*********************/

class packet;
    rand int arr[][];  //2d array arr[m][n] m - rows and n- columns

    rand int max_values[]; //Array to store m max values - m rows. Each row has a unique max value. 
    rand int indexes[];      //Random indexes to place the max values. n columns = 0 to n-1 random values indexes[0] = 5 means place the max value in row0 at 5th indexes column


    //Array elements will be in between 1 to 100
    constraint c_arr_range{
        foreach(arr[i,j]){
            arr[i][j] inside {[1:100]};
        }
        foreach(max_values[i]){
            max_values[i] inside {[1:100]};
        }
    }

    //Each row should have unique max value and each index where max value is present should be unique
    constraint c_unique_max_values_indexeses{
        unique {max_values};
        unique {indexes};
    }

    
    constraint c_max_values_size{
        max_values.size() == arr.size();   // We only need m max values. 
        indexes.size() == arr.size();     // We need n indexeses for the columns. 
    } 

    constraint c_indexes_range{
        foreach(indexes[i]){
            indexes[i] inside {[0:arr[i].size()-1]};
        }
    }

    constraint c_size{
        arr.size() inside {[2:5]}; //2<=m<=5
        arr[0].size() inside {[2:5]};
        
        foreach(arr[i]){
            arr[i].size() == arr[0].size();  //2<=n<=5
        }
    }

    constraint c_unique_value_per_row{
        foreach(arr[i,j]){
            if(j==indexes[i]){
                arr[i][j] == max_values[i];
            }
            else{
                arr[i][j] < max_values[i];
            }
        }
    }



endclass: packet

module test;
    packet p = new();

    initial begin
        if(p.randomize()) begin
            
            $display("Array: %0d X %0d matrix",p.arr.size(), p.arr[0].size());
            foreach(p.arr[i]) begin
                foreach(p.arr[i][j]) $write("%0d ",p.arr[i][j]);
                $display("");
            end
            $display("Max Values Array: %p",p.max_values);
            $display("Indexeses Array: %p",p.indexes);
        end
    end
endmodule