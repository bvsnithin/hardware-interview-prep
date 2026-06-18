/*****************
Write a constraint to divide values of 1 queue into 3 queues so that all 3 queues have unique elements
*****************/

class packet;
    rand int queue[$]; //Randomizing this queue and then sharing it's elements with 3 queues
    rand int q1[$], q2[$], q3[$];
    rand int indexes[];

    constraint c_queue_size{
        queue.size() inside {[5:50]};
    }

    constraint c_other_queue_sizes{
        indexes.size() == queue.size();

        q1.size() inside {[1:50]};
        q2.size() inside {[1:50]};
        q3.size() inside {[1:50]};

        q1.size()+ q2.size()+q3.size() == queue.size();

        q1.size()!= q2.size();
        q2.size()!=q3.size();
    }

    constraint c_unique_queues{
        unique {queue};
        unique {indexes};
    }

    constraint c_range_of_values{
        foreach(indexes[i]){
            indexes[i] inside {[0:indexes.size()-1]};
        }

        foreach(queue[i]){
            queue[i] inside {[-10:50]};
        }
    }

    function void post_randomize();

        foreach(q1[i]) q1[i] = queue[indexes[i]];
        foreach(q2[i]) q2[i] = queue[indexes[i+q1.size()]];
        foreach(q3[i]) q3[i] = queue[indexes[i+q1.size()+q2.size()]];
    endfunction: post_randomize

    
endclass: packet

module test;
    packet p;
    initial begin
        p = new();
        if(p.randomize()) begin
            $display("Original queue: %p",p.queue);
            $display("Queue 1: %p",p.q1);
            $display("Queue 2: %p",p.q2);
            $display("Queue 3: %p",p.q3);
        end
    end
endmodule