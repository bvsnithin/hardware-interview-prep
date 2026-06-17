/*******************
Write systemverilog constraint to generate factorial of a random number
*******************/

class packet;
    rand int data;
    int factorial;

    constraint c_data_range{
        data inside {[0:10]};
    }

    function int calc_factorial(int num);
        int result = 1;
        for(int i = 2;i<=num;i++) begin
            result = result*i;
        end
        return result;
    endfunction: calc_factorial

    function void post_randomize();
        factorial = calc_factorial(data);
    endfunction: post_randomize

endclass

module test;
    packet p;

    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                $display("Random Number: %0d, Factorial: %0d",p.data, p.factorial);
            end
        end
    end
endmodule