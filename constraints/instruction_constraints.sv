/*************************
Write a constraint that generates Add, mul, sub, nop instructions. 
Such that no Add instruction is repeated in 3 clock cycles and sub is not repeated in the last 3 valid instructions. Nop is not a valid instruction
*************************/
typedef enum logic[1:0] {ADD, MUL, SUB, NOP} inst_t;
class packet;
    rand inst_t inst;
    inst_t last3_all[$];
    inst_t last3_valid[$];

    constraint c_add{
        !(inst == ADD && (ADD inside {last3_all}));
    }

    constraint c_sub{
        !(inst == SUB && (SUB inside {last3_valid}));
    }

    function void post_randomize();
        // always track ALL instructions (including NOP)
        last3_all.push_back(inst);
        if (last3_all.size() > 3)
            last3_all.pop_front();

        // track only VALID instructions (exclude NOP)
        if (inst != NOP) begin
            last3_valid.push_back(inst);
            if (last3_valid.size() > 3)
                last3_valid.pop_front();
        end
    endfunction
endclass: packet

module test;
    packet p;
    int cycle_count;
    initial begin
        p = new();
        cycle_count = 1;
        repeat(12) begin
            if(p.randomize()) begin
                $display("CYCLE %0d: %s",cycle_count,p.inst.name());
                cycle_count = cycle_count+1;
            end
        end
    end
endmodule