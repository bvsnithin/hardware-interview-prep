/******************
Write UVM SV constraint for array where parity of index matches parity of value. 
Even indices (0,2,4,...) contain even values. Odd indices (1,3,5,...) contain odd values. 
Support arbitrary integer values (positive, negative, or zero).
******************/

class packet;
    rand int arr[10];

    constraint even_odd{
        unique {arr};

        foreach(arr[i]){
            arr[i] inside {[-200:200]};
        }

        foreach(arr[i]) {
            (i%2) == (arr[i]%2);
        }
    }


endclass: packet

module even_odd_constraint;

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