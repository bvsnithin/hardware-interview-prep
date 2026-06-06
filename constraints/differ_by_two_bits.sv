/**********
Write a constraint where you have a 32 bit value bit [31:0] val where you’d want to randomize this to 
where every randomization would only allow 2 bits to differ from the previous randomization.
***********/

class packet;
    rand bit [31:0] val;
    bit [31:0] prev_val;

    constraint differ_by_2_bits{
        $countones(prev_val ^ val) == 2;
    }

    function void post_randomize();
        prev_val = val;
    endfunction: post_randomize

endclass: packet

module differ_by_two_bits;

    packet p = new();

    initial begin
        repeat(10) begin
            if(p.randomize()) begin
                $display("Randomization is successful");
                $display("%032b",p.val);
            end
            else $display("Randomization has failed");
        end
    end

endmodule: differ_by_two_bits