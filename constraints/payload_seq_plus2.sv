/**************************
Write a constraint for payload generation, where the size is between 11 and 22, and each value is 2 greater than the previous.
**************************/

class packet;

    rand int arr[];

    constraint c_size_range{
        arr.size() inside {
            [11:22]
        };
    }

    constraint c_range{
        foreach(arr[i]){
            arr[i] dist {
                [1:100]:=75,
                [100:200]:=25
            };
        }
    }

    constraint plus_2{
        foreach(arr[i]) {
            if(i>0){
                arr[i] == arr[i-1]+2;
            }
        }
    }

endclass: packet

module payload_seq_plus2;
    packet p = new();

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                $display("Randomization is successful: Generated Array: %p", p.arr);
            end
            else begin
                $display("Randomization has failed");
            end
        end
    end
endmodule