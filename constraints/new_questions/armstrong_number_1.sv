/*********  Write a code to check whether the randomized number is an Armstrong number. *****/

/* 
This question asks to generate a random number and then check if it's armstrong or not! 

Check out armstrong_number_2 where you need to constraint an integer to be armstrong number instead without using a post randomize function! 

An armstrong number is also known as an narcissistic number. Lol, that's a cool name. 
A number is called armstrong if it equals the sum of its own digits. And each digit is raised to the power of the total number of digits in the number. 

This rule creates a pretty cool list of numbers.

1 digit numbers: All numbers from 0 to 9 are armstrong because each number is raised to 1 (just 1 number) and sum is the number itself
2 digit numbers: None
3 digit numbers: 153. 1^3 + 5^3 + 3^3 = 1+125+27 = 153

This approach asks to generate a random number and then check if it's armstrong or not! 
*/
class packet;
    rand int num;
    
    constraint c_list_of_numbers{
        num inside {1,4,270,153,957,9474,407,12,43};
    }

    function void post_randomize();
        int num_of_digits = 0; // Number of digits. This is the power
        int n = num;
        int sum = 0;
        while (n>0) begin
            n = n/10;
            num_of_digits++;
        end
        n = num;
        while(n>0) begin
            int r = n%10;
            sum = sum + (r ** num_of_digits);
            n = n/10; // Calculate the sum. Sum of each digit raised to the power(number of digits in the number)
        end

        if(sum == num) begin
            $display("%0d is an armstrong number!", num);
        end
        else begin
            $display("%0d is not an armstrong number! :')", num);
        end


    endfunction: post_randomize


endclass

module test;
    packet p;

    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                
            end
            else begin
                $display("Randomization has failed");
            end
        end
    end
endmodule