/************
In SystemVerilog, given an array of 100 random integers, 
write a constraint to ensure that the last four digits of each integer (i.e., the lower 4 decimal digits) are unique across all 100 integers.
************/

class packet;
    //An array of size 100 
    rand int unsigned array[100];

    // To get the last 4 digits of a number, we simply need to divide the number by 10,000
    // The remainder is the last 4 digits. 18290%10000 = 8290

    constraint c_unique_last_4_digits{
        foreach(array[i]){
            foreach(array[j]){
                if(i<j){
                    array[i]%10000 != array[j]%10000;
                }
            }
        }
    }

endclass: packet

module test;
    packet p;

    initial begin
        p = new();
        if(p.randomize()) begin
            for(int i = 0;i<100;i = i+4) begin
                $write("%0d | ", p.array[i]);
                $write("%0d | ", p.array[i+1]);
                $write("%0d | ", p.array[i+2]);
                $write("%0d", p.array[i+3]);
                $display("");   
            end
        end
    end 
endmodule