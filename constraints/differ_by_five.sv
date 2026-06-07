/*************
Write a constraint for two random variables such that one variable does not match
the other, and five bits are toggled.
*************/

class packet;
    rand bit [9:0] val;
    rand bit [9:0] prev_val;

    constraint c_not_equal{
        prev_val != val;
    }

    constraint c_five_toggle_bits{
        $countones(val) == 5;
        $countones(prev_val) == 5;
    }

endclass: packet

module differ_by_two_bits;

    packet p = new();

    initial begin
        repeat(10) begin
            if(p.randomize()) begin
                $display("Randomization is successful --- VAL1: %09b --- VAL2: %09b",p.val, p.prev_val);
            end
            else $display("Randomization has failed");
        end
    end

endmodule: differ_by_two_bits