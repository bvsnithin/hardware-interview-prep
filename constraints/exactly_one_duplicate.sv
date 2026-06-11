/************
Create a constraint for an int array with 10 elements. 
Value is 1 to 10. 2 of the elements will have the same number and the rest will all have different numbers, the index of the 2 same elements also have to be randomized.
*************/

class packet;
    rand int array[];
    rand int index_1, index_2;


    constraint c_size{
        array.size == 10;
    }

    constraint c_range{
        foreach(array[i]){
            array[i] inside {[1:10]};
        }

        array[index_1] == array[index_2];
    }

    constraint c_rest_values_uniques{
        foreach(array[i]){
            foreach(array[j]){
                if(i<j){
                    if((i==index_1 && j == index_2) || (i==index_2 && j == index_1)){
                        array[i] == array[j];
                    }
                    else{
                        array[i]!=array[j];
                    }
                }
            }
        }
    }

    constraint c_index{
        index_1 != index_2;
        index_1 inside{[0:9]};
        index_2 inside{[0:9]};
    }


endclass: packet

module test;
    packet p = new();

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                $display("Array Generated: %p",p.array);
            end
        end
    end
endmodule