/**************
Write constraint to generate a random number with only 5 bits set and consecutively set for 80% of the time
**************/

class packet;
    rand bit [31:0] data;
    rand int start_pos;
    rand bit consecutive_mode;

    constraint c_consecutive_mode{
        consecutive_mode dist {
            1 := 80,
            0 := 20
        };
    }

    constraint c_start_pos{
        start_pos inside {[0:27]};
    }

    constraint c_5_set_bits{
        // foreach(data[i]){
        //     if(consecutive_mode){
        //         if(i >= start_pos && i<start_pos+5){
        //             data[i]==1;
        //         }
        //         else data[i] == 0;
        //     }
        // }

        if(consecutive_mode){
            data == 32'h1F << start_pos;
        }
        else {
            $countones(data) == 5;
        }
    }

endclass

module test;
    packet p = new();

    initial begin
        repeat(7) begin
            if(p.randomize()) begin
                $display("Generated bianry: %032b",p.data);
            end
        end
    end
endmodule