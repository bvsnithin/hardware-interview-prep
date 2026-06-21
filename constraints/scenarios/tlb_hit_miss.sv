/***********************
===== TLB Hit vs Miss Distribution ====

You want 70% of transactions to be TLB hits and 30% misses. 
Hits must reuse a VA from a pre-populated hot set of 16 addresses. Misses must pick a fresh VA not in the hot set.
************************/

class tlb_traffic;
    rand bit [39:0] va;
    rand bit is_hit;
    bit [39:0] hot_set[16];
    rand int unsigned hit_index;


    constraint c_hit_miss_distribution{
        is_hit dist {
            1:= 70,
            0:= 30
        };
    }

    constraint c_va_on_hit_miss{
        if(is_hit) {
            hit_index inside {[0:15]};
            va == hot_set[hit_index];
        }
        else{
            foreach(hot_set[i]){
                va != hot_set[i];
            }
        }
    }

    function new();
        foreach(hot_set[i]) begin
            hot_set[i] = 40'h1000 + i;
        end
    endfunction: new
endclass: tlb_traffic

module test;
    tlb_traffic obj = new();
    initial begin
        repeat(5) begin
            if(obj.randomize()) begin
                $display("Address: %0h, Is hit: %0b", obj.va, obj.is_hit);
                $display("Addresses in TLB: %p", obj.hot_set);
            end
        end
    end
endmodule