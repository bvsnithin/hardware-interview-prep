/********
Write constraint for number to be power of 4.
*******/

class packet;
 rand int unsigned value;
 rand int unsigned exp;
 constraint exponent{
    exp inside {[0:15]};
 }


 function void post_randomize();
    value = 4**exp;
 endfunction: post_randomize

endclass:packet

module power_of_4;
    packet p = new();
    initial begin
        for(int i = 0;i<10;i++) begin
            if(p.randomize()) begin
                $display("Value: %0d",p.value);
            end
            else begin
                $display("Randomization Failed!");
            end
        end
    end
endmodule

