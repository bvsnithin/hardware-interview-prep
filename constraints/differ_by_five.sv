/*************
Write a constraint for two random variables such that one variable does not match the other, and five bits are toggled.
*************/

class packet;
    rand bit [9:0] val1;
    rand bit [9:0] val2;

    constraint c_not_equal{
        val2 != val1;
    }

    constraint c_five_toggle_bits{
        $countones(val1) == 5;
        $countones(val2) == 5;
    }

endclass: packet

module differ_by_five;

    packet p = new();

    initial begin
        repeat(10) begin
            if(p.randomize()) begin
                $display("Randomization is successful --- VAL1: %09b --- VAL2: %09b",p.val1, p.val2);
            end
            else $display("Randomization has failed");
        end
    end

endmodule: differ_by_five