/******************************************
Write a SystemVerilog constraint to satisfy the following requirements:
Each element of the queue should have a value between 0 and 9 (inclusive).

No two consecutive elements in the queue should have the value 7.
******************************************/

class packet;
    rand int q[50];

    constraint c_range{
        foreach(q[i]){
            q[i] inside {[0:9]};
        }
    }

    constraint c_no_consequtive_7{
        foreach(q[i]){
            ((i<49) && (q[i] == 7)) -> (q[i+1]!=7);
        }
    }
endclass: packet

module test;
    packet p;
    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                $display("%p", p.q);
            end
        end
    end
endmodule