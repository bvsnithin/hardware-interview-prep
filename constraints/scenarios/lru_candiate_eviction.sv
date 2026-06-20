/***************************
TLB eviction: LRU candidate selection

An 8-way set-associative TLB has age counters per way (0 = LRU, 7 = MRU). 
Constrain a new fill so it always targets the way with the lowest age. 
If there is a tie, pick the lowest way index. 

Example:
Way : 0 1 2 3 4 5 6 7
Age : 3 0 5 0 2 1 7 4
Evict way should be 1 because Age[1] is the lowest

Way : 0 1 2 3 4 5 6 7
Age : 4 2 1 5 3 6 7 0

Minimum age = 0 only at way 7.

evict_way = 7

Way : 0 1 2 3 4 5 6 7
Age : 4 2 1 1 3 6 7 0

Minimum age = 0 only at way 7.

evict_way = 2
***************************/

class tlb_fill;
  rand bit [2:0] age   [8];         // age per way
  rand bit [2:0] evict_way;

  constraint c_min_age{
    foreach(age[i]){
        age[evict_way] <= age[i];
    }
  }

  constraint c_same_age_lower_index{
    foreach(age[i]){
        if(i<evict_way){
            age[i]> age[evict_way];
        }
    }
  }

endclass

module test;
    tlb_fill obj;
    initial begin
        repeat(5) begin
            obj = new();
            if(obj.randomize()) begin
                $display("%p",obj.age);
                $display("%0d",obj.evict_way);
                $display("------------");
            end
        end
    end
endmodule