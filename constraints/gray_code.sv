/*****************
Write constraints to generate a 5-bit Gray code from a randomized binary number.
******************/

class packet;
    rand bit [4:0] binary_data;
    rand bit [4:0] gray_code;

    constraint c_gray_code{
        gray_code == (binary_data)^(binary_data>>1);
    }
endclass: packet

module test;
    packet p = new();

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                $display("%05b",p.gray_code);
            end
        end
    end
endmodule