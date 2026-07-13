/**********************
Write a function to generates numbers that alternate between even and odd numbers. 
The generated number should not match any of the last 10 values
***********************/

class packet;
    rand int val;
    bit prev_val;     //If prev value is even, prev_val = 1, else 0
    int queue[$];       

    constraint c_val_range{
        val inside {[1:100]};
    }

    constraint c_check_prev_val{
        //If previous value is even, then next random number has to be odd
        if(prev_val){
            val%2 == 1;
        }
        else{
            val%2 == 0;
        }
    }

    constraint c_val_not_repeat{
        !(val inside {queue});
    }

    function void post_randomize();
        prev_val = (val%2==0)?1:0;
        queue.push_back(val);
        if(queue.size() > 10) begin
            queue.pop_front();
        end
    endfunction: post_randomize

endclass: packet

class main;
    packet p;

    function new();
        p = new();
    endfunction: new

    function int alternating_odd_even();
        if(p.randomize()) begin
            return p.val;
        end
        return 0;
    endfunction: alternating_odd_even
endclass: main

module test;
    main obj;
    initial begin
        obj = new();
        repeat(15) begin
            $display("%0d",obj.alternating_odd_even());
        end
    end
endmodule