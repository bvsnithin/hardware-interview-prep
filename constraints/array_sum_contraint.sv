/******
Write UVM SystemVerilog constraint to generate an integer array of size 10 with unique elements where the sum of all 
elements equals exactly 100. Implement sum calculation without using .sum() array reduction method. 
******/


class packet;
    rand int unsigned arr[];

    constraint array_sum_size {
        arr.size() == 10;

        foreach (arr[i]) {
            arr[i] < 100;
            arr[i] >= 1;
        }

        unique { arr };

        arr[0] + arr[1] + arr[2] + arr[3] + arr[4] +
        arr[5] + arr[6] + arr[7] + arr[8] + arr[9] == 100;
    }
endclass

module test;
    packet p = new();

    initial begin
        if (p.randomize()) begin
            $display("Randomization is successful");
            foreach (p.arr[i])
                $display("arr[%0d]: %0d", i, p.arr[i]);
        end
        else
            $display("Randomization has failed");
    end
endmodule