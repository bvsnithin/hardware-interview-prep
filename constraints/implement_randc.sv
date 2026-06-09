/****************
Write a code to simulate cyclic randomization behavior without using the "randc"
keyword. 
****************/

// 4,2,1,6,3,7,5 - 5,4,7,6,1,3,2

class packet;
    rand bit [2:0] data;
    int queue[$];

    constraint c_not_in_queue{
        !(data inside {queue});
    }

    function void post_randomize();
        queue.push_back(data);
        if(queue.size()==8) begin
            queue = {}; //Empty the queue. 
        end
    endfunction

endclass: packet

module test;
    packet p = new();

    initial begin
        for(int i =0;i<=31;i++) begin
            if(p.randomize()) begin
                $display("%0d",p.data);
            end
            if(i%8==7) $display("--");
        end
    end

endmodule