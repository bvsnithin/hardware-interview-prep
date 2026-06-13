/*********
Constraint for generating the sequence 01002000300004000005.

0 1 00 2 000 3 0000 4 00000 5
0 1 00 2 000 3 0000 4 00000 5 000000 6
*********/

class packet;
    rand int num;
    int queue[$];

    constraint c_num{
        num  inside {[1: 10]};
    }

    function void post_randomize();
        queue.delete(); //To clear out the queue after every randomization. Since queue is class property, it persists with every randomize() call
        for(int i = 1;i<=num;i++) begin
            repeat(i) begin
                queue.push_back(0);
            end
            queue.push_back(i);
        end
    endfunction: post_randomize

endclass

module test;
    packet p = new();

    initial begin
        repeat(4) begin
            if(p.randomize()) begin
                $display("Pattern = %p",p.queue);
            end
        end
    end
endmodule