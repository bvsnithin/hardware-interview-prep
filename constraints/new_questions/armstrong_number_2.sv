/*** Write a constraint to generates armstrong numbers! ***/
 
/* For this question we will create 3 and 4 digit armstrong numbers */

class packet;
    rand int armstrong3;
    rand int armstrong4;

    rand int a3,b3,c3;
    rand int a4, b4, c4, d4;

    constraint c_digits{
        a3 inside {[0:9]};
        b3 inside {[0:9]};
        c3 inside {[0:9]};

        a4 inside {[0:9]};
        b4 inside {[0:9]};
        c4 inside {[0:9]};
        d4 inside {[0:9]};
    }
    constraint c_number_limit{
        armstrong3 inside {[100:999]};
        armstrong4 inside {[1000:9999]};
    }

    constraint c_digit_sum{
        armstrong3 == a3*100 + b3*10 + c3;
        armstrong4 == a4*1000 + b4*100 + c4*10 + d4;

        armstrong3 == a3**3 + b3**3 + c3**3;
        armstrong4 == a4**4 + b4**4 + c4**4 + d4**4;
    }

endclass

module test;
    packet p;

    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                $display("3 digit armstrong is: %0d, 4 digit armstrong is: %0d", p.armstrong3, p.armstrong4);
            end
        end
    end
endmodule