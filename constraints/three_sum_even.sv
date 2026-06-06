/*********************
Write a constraint such that the sum of any three consecutive elements in an array is even. 
*********************/

class packet;
    rand int arr[10];

    constraint c_range{
        foreach(arr[i]){
            arr[i] dist {
                [1:100] := 80,
                [101:1000] := 20
            };

            // arr[i] inside {[1:1000]};
        }
    }

    constraint c_data{

        foreach(arr[i]) {
            if(i <= 7){
                (arr[i]+arr[i+1]+arr[i+2])%2 == 0;
            }
        }

    }

endclass: packet

module different_from_last_five;
    packet p = new();

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                $display("Randomization is successful!. Generated value: %p",p.arr);
            end
            else begin
                $display("Randomization has failed");
            end
        end
    end
endmodule