/******************
Add "size" number of entries to a queue. The entry of queue is randomized between 0 to "size"
******************/

class packet;
    rand int queue[$];
    rand int size;

    constraint c_size_queue{
        size inside {[5:15]};
    }

    constraint c_queue_size{
        queue.size() == size;
    }

    constraint c_queue_entry{
        foreach(queue[i]){
            queue[i] inside{[0:size]};
        }
    }
endclass: packet

module test;
    packet p = new();

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                $display("Queue element; %p, Queue size randomized = %0d",p.queue, p.size);
            end
        end
    end
endmodule