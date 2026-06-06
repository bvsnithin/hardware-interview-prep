/******
122122122122.....
******/


class packet;
    rand int arr [0:31];
    constraint c_122 {
        foreach(arr[i]) {
            if(i%3==0) {
                arr[i] == 1;
            }
            else arr[i] == 2;
        }
    }
endclass

module pattern_1;
    packet p = new();

    initial begin
        repeat(5) begin
            if (p.randomize()) begin
                $display("Randomization is successful: %p", p.arr);
            end
            else $display("Randomization has failed");
        end
    end
endmodule