/******************
You are given a queue of integers:

int array[$] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};

Write SystemVerilog constraints to divide the elements of this queue into three new queues (q1, q2, and q3) such that:

• Every element from the original queue appears in exactly one of the three new queues
• All three queues together contain unique elements (no duplicates)
• Each queue must have at least one element
• You cannot use post_randomize() to perform the split — it must be handled entirely within the constraint block
******************/

class packet;
    int arr[$] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
    rand int q1[$], q2[$], q3[$];
    rand int index[15];

    constraint q_size{
        q1.size()+q2.size()+q3.size() == 15;
    }

    constraint c_range{
        q1.size() inside {[1:13]};
        q2.size() inside {[1:13]};
        q3.size() inside {[1:13]};

        q1.size()!=q2.size();
        q2.size()!=q3.size();

        foreach(index[i]){
            index[i] inside {[0:14]};
        }
    }

    constraint c_unique{
        unique {index};
    }

    constraint c_queue_unique{
        foreach(arr[i]){
            foreach(q1[i]) q1[i] == arr[index[i]];
            foreach(q2[i]) q2[i] == arr[index[i+q1.size()]];
            foreach(q3[i]) q3[i] == arr[index[i+q1.size()+q2.size()]];
        }
    }

    

endclass: packet

module divide_queue_elements;

    packet p = new();

    initial begin
        if(p.randomize()) begin
            $display("Randomization is successful");
            foreach(p.q1[i]) begin
                $write("q1[%0d]: %0d ", i, p.q1[i]);
            end
            $display("");
            foreach(p.q2[i]) begin
                $write("q2[%0d]: %0d ", i, p.q2[i]);
            end
            $display("");
            foreach(p.q3[i]) begin
                $write("arr[%0d]: %0d ", i, p.q3[i]);
            end
        end
        else begin
            $display("Randomization has failed");
        end
    end
endmodule