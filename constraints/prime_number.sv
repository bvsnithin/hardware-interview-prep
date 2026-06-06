/********
You have an 8-bit random variable:
rand bit [7:0] num;
Write constraints such that:
num is a prime number.
num is between 2 and 255.
Consecutive randomizations should not generate the same prime number.
********/


class packet;
    rand bit [7:0] num;
    bit [7:0] prev_val;
    int intialize = 0;

    constraint c_range{
        num inside {[2:255]};
    }

    constraint c_not_equals_last_value{
        if(intialize) num!=prev_val;
    }

    constraint c_prime {
        (num inside {2, 3, 5, 7, 11, 13}) || 
        (
            num > 13 &&
            num % 2  != 0 &&
            num % 3  != 0 &&
            num % 5  != 0 &&
            num % 7  != 0 &&
            num % 11 != 0 &&
            num % 13 != 0
        );
    }

    function void post_randomize();
        prev_val = num;
        intialize = 1;

    endfunction: post_randomize

    function int is_prime(input int n);
        if(n<2) return 0;
        else begin
            for(int i = 2;i*i<=n;i++) begin
                if(n%i == 0) return 0;
            end
        end
        return 1;
    endfunction: is_prime


endclass: packet

module prime_number;

    packet p = new();

    initial begin
        repeat(5) begin
            if(p.randomize()) begin
                $display("Randomization is successful");
                if(p.is_prime(p.num)) $display("Generated: %0d",p.num);
                else $display("Generated: %0d, but it's not prime",p.num);
            end
            else $display("Randomization has failed");
        end
    end

endmodule: prime_number