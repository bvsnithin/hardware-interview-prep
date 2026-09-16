/*******
This one is a pretty good question I found on the verification academy forum. 
-------------------------------------------------------------------------------
https://verificationacademy.com/forums/t/system-verilog-interview-question/39735

Given an integer n, create an array such that each value is repeated twice.
For example;
n=3->[1,1,2,2,3,3]
n=4->[1,1,2,2,3,3,4,4]

After creating it, find a permutation such that each number is spaced in such a way that they are at a “their value” distance from the second occurrence of the same number.

For example: n=3 → This is the array - [1,1,2,2,3,3]

Your output should be [3,1,2,1,3,2]

The second 3 is 3 digits away from the first 3.
The second 2 is 2 digits away from the first 2.
The second 1 is 1 digit away from the first 1.

Return any 1 permutation if it exists.
Empty array if no permutation exists.
-------------------------------------------------------------------------------
- This is called the Langford Pairing Problem. 
- For each number k, we need to place exactly two copies of k in the array. 
- These two copies need to be placed in such a way that only "k" elements are present in between them. 

For n = 3 -> [3,1,2,1,3,2]
The difference in index for "k" is k+1
- k==1 is at two locations: i = 1 and i = 3. 
- Index Difference = 2(3-1) (k+1 == 1+1 == 2)

- For a given value of n, langford pairing is only possible if it satisfies the following condition:
n%4 == 0 or n%4 == 3
********/

/*******
To constrain an array for this problem, we will fix the first position of the occurances for a given number k.
For find the index of the second occurance => second_index = first_index + k + 1

If k=3 is in it's first position at index 0, then the second occurance should be at index 4
Because index 0 and 4 have 3 elements between them 3 _ _ _ 3
*******/

class langford_pairing#(parameter int N = 3);

    rand int array[]; // Final generated dynamic array

    localparam bit POSSIBLE = (N%4 == 0) || (N%4==3);
    // If POSSIBLE == 0: Langford pairing is not possible a given N value

    rand int first_position [1:N];  // Array with indexing 1 to N
    rand int second_position [1:N];

    // Unique first and second positons
    constraint c_unique_first_second_positions{
        if(POSSIBLE) {
            unique { first_position };
            unique {second_position };
        }
    }

    // Positions must be different
    constraint c_different_positions{
        if(POSSIBLE){
            foreach(first_position[i]){
                foreach(second_position[j]){
                    first_position[i] != second_position[j];
                }
            }
        }
    }

    constraint c_pair_spacing {
        if (POSSIBLE) {
            foreach (first_position[k]) { 
                second_position[k] == first_position[k] + k + 1; // Second position index(j) for a given first position(i): j = i + k + 1
                // Both positions must fit inside an array of size 2*N.
                first_position[k] inside {[0 : 2*N-k-2]}; // This is the acceptable range for the first position
            }
        }
    }

    constraint c_array{
        if(!POSSIBLE){
            array.size() == 0;
        }
        else {
            array.size() == 2*N;
        }
    }

    function void post_randomize();
        if(POSSIBLE) begin
            foreach(first_position[i]) begin
                array[second_position[i]] = i;
                array[first_position[i]] = i;
            end
        end
    endfunction

    function void display();
        $display("Array for N = %0d | %p",N,array);
    endfunction
endclass:langford_pairing

module test;
    langford_pairing#(7) packet_7;
    langford_pairing packet_3;
    langford_pairing#(4) packet_4;
    langford_pairing#(5) packet_5;


    initial begin
        packet_7 = new();
        if(packet_7.randomize()) begin
            packet_7.display();
        end
        else begin
            $display("Randomization failed for N = 7");
        end
        // -------------------------------------------------------
        packet_3 = new();
        if(packet_3.randomize()) begin
            packet_3.display();
        end
        else begin
            $display("Randomization failed for N = 3");
        end
        // -------------------------------------------------------
        packet_4 = new();
        if(packet_4.randomize()) begin
            packet_4.display();
        end
        else begin
            $display("Randomization failed for N = 4");
        end
        // -------------------------------------------------------
        packet_5 = new();
        if(packet_5.randomize()) begin
            packet_5.display();
        end
        else begin
            $display("Randomization failed for N = 5");
        end
    end
endmodule
