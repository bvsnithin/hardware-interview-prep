/*********************
Write a constraint for a variable such that the number of ones depends on the value of another variable
*********************/

class packet;
    rand bit [31:0] data;
    rand int random_ones;

    constraint c_range{
        random_ones inside {[0:32]};
    }
    
    constraint c_countones {
        $countones(data) == random_ones;
    }

endclass: packet

module test;
    packet p = new();

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                $display("Randomization is successful! --- Generated value: %032b --- Number of ones: %0d",p.data,p.random_ones);
            end
            else begin
                $display("Randomization has failed");
            end
        end
    end
endmodule