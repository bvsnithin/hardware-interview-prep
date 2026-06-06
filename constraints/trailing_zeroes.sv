/********
Write a constraint  for a 32 bit variable, such that the number of trailing zeroes is between 5 and 10
********/

class packet;
    rand bit [31:0] data;

    rand int num_zeroes;

    constraint c_num_zeroes{
        num_zeroes inside {[5:10]};
    }

    constraint c_trailing_bits{
        foreach(data[i]) {
            if (i < num_zeroes) {
                data[i] == 0;
            } else if (i == num_zeroes) {
                data[i] == 1;
            }
        }
    }
endclass: packet

module trailing_zeroes;
    packet p = new();
    initial begin
    repeat(5) begin
        if(p.randomize()) begin
            $display("Generated: %b",p.data);
            $display("Number of trailing zeroes: %d",p.num_zeroes);
        end
        else begin
            $display("Randomization has failed!");
        end
    end
    end
endmodule: trailing_zeroes