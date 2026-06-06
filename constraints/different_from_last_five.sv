/*********************
Write a constraint such that a 4-bit variable is not the same as the last five occurrences
*********************/

class packet;
    rand bit [3:0] data;
    int queue[$]; //To store last 5 occurances;

    constraint c_data{
        data inside {[0:15]};
        !(data inside {queue});
    }

    function void post_randomize();
        queue.push_back(data);
        if(queue.size()==6) begin
            queue.pop_front();
        end
    endfunction: post_randomize


endclass: packet

module different_from_last_five;
    packet p = new();

    initial begin
        repeat(15) begin
            if(p.randomize()) begin
                $display("Randomization is successful!. Generated value: %0d",p.data);
            end
            else begin
                $display("Randomization has failed");
            end
        end
    end
endmodule