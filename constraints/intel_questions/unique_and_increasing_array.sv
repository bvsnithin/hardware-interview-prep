/****************************
Generate a unique array without using any unique keyword with values in ascending order
****************************/

class packet;
    rand bit[7:0] array[];

    constraint c_array_size{
        array.size() inside {[5:15]};
    }

    constraint c_unique_and_ascending{
        foreach(array[i]) {
            if(i < (array.size() - 1)) {
                array[i] < array[i+1];
            }
        }
    }
endclass: packet

module test;
    packet p;
    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                $display("%p",p.array);
                $display(":::::::::::::::::::");
            end
        end
    end
endmodule