/**********************
Write a function that generates a random 8-bit value with odd parity, 
where the value must not repeat within the last 4 generations.
***********************/

class packet_odd_parity;   
    rand bit[7:0] data;
    bit[7:0] queue[$];w

    constraint c_odd_parity{
        ^data == 1'b1;
    }
    constraint c_not_in_last_4{
        !(data inside {queue});
    }

    function void post_randomize();
        queue.push_back(data);
        if(queue.size()>4) begin
            queue.pop_front();
        end
    endfunction: post_randomize
endclass: packt_odd_parity

module test;
    packet_odd_parity p;

    initial begin
        repeat(5) begin
            p = new();
            if(p.randomize()) begin
                $display("%08b", p.data);
            end
        end
    end
endmodule