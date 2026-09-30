/*********
Real Apple Interview Question
a. Constrain an 8-bit random value so exactly 5 of its bits are 1.
b. Now make those 5 ones consecutive.
**********/

class packet;
    rand logic[7:0] data;

    // To have exactly 5 bits equal to 1, we can use $countones == 5. This constraints 5 bits to be 1

    // constraint c_5_bits_one{
    //     $countones(data) == 5;
    // }

    // To make those 5 bits consecutive, we can take the bits 0001_1111 and shift left by 1,2,or 3 times. 
    // Let's use a random 2 bit value. It can be between 0 and 3 and hence does not need to be constrained. 
    rand logic[1:0] shift_num;

    constraint c_shift{
        data == 8'b0001_1111 << shift_num;
    }
endclass: packet

module test;
    packet p;
    initial begin
        p = new();
        repeat(10) begin
            if(p.randomize()) begin
                $display("Data = %08b", p.data);
            end
        end
    end
endmodule