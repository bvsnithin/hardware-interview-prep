/*****************
Randomize two 6-bit values where Consecutive Gray Codes Differ by One Bit.
******************/

class packet;
    rand bit [5:0] g1;
    rand bit [5:0] g2;

    rand bit [5:0] bin1;
    rand bit [5:0] bin2;

    constraint c_differ_by_1_bit{
        $countones(g1^g2) == 1;
    }

    constraint c_gray_code{
        g1 == bin1 ^ (bin1>>1);
        g2 == bin2 ^ (bin2>>1);
    }
    
endclass: packet

module test;
    packet p = new();

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                $display("g1 = %06b ----- g2 = %06b",p.g1, p.g2);
            end
        end
    end
endmodule