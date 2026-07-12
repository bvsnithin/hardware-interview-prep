/******************************
Write constraint for the below requirements :
a. The queue size will be 15. Randomize a queue such that it exactly has four 7 in it.
b. No 7's should be at the consecutive next to each other
******************************/

class packet;

    rand int queue[$];

    constraint c_size_of_queue{
        queue.size() == 15;
    }

    constraint c_range_of_values{
        foreach(queue[i]) {
            queue[i] inside {[0:50]};
        }
    }

    constraint c_num_of_sevens{
        queue.sum() with (int'(item==7)) == 4;
    }

    constraint c_no_consecutive_sevens{
        foreach(queue[i]){
            if(i<14){
                (queue[i] == 7) -> queue[i+1]!=7;
            }
        }
    }

    function void print();
        foreach(queue[i]) begin
            $write("%0d ",queue[i]);
        end
        $display("");
    endfunction:print
endclass: packet

module test;
    packet p;

    initial begin
        repeat(5) begin
            p = new();
            if(p.randomize()) begin
                p.print();
            end
        end
    end
endmodule