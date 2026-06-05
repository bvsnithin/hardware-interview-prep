/****
Write a constraint for 4 monkeys having to share 10 bananas and make sure every monkey gets atleast 1 banana
****/

class packet;
    rand int arr[];

    constraint c{
        arr.size() == 4;

        arr.sum() == 10;

        foreach(arr[i]){
            arr[i] inside {[1:7]};
        }
    }


endclass: packet

module four_monkeys;

    packet p = new();

    initial begin
        if(p.randomize()) begin
            $display("Randomization is successful");
            foreach(p.arr[i]) begin
                $display("arr[%0d]: %0d", i, p.arr[i]);
            end
        end
        else begin
            $display("Randomization has failed");
        end
    end
endmodule