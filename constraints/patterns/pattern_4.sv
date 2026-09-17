/****
1. Write a constraint to generate the following pattern in an array
N=3: 1 11 111
N=4: 1 11 111 1111

2. Write a constraint to generate the following pattern in a 2D array
N=4:
[1]
[1, 1]
[1, 1, 1]
[1, 1, 1, 1]
****/

// Pattern Constraint 1
class packet_1#(parameter int N = 3);
    rand int unsigned array[];

    constraint c_array_size{
        array.size() == N;
    }

    constraint c_fill_array{

        foreach(array[i]){
            if(i==0){
                array[0] == 1;
            }
            else {
                array[i] == array[i-1]*10 + 1;
            }
        }
    }
endclass:packet_1

// Pattern Constraint 2
class packet_2#(parameter int N = 3);
    rand int unsigned array[][];

    constraint c_array_size{
        array.size() == N;
    }

    constraint c_fill_array{
        foreach(array[i]){
            array[i].size() == i+1;

            foreach(array[i][j]){
                array[i][j] == 1;
            }
        }
    }

endclass:packet_2

module test;
    packet_1#(3) p1_3;
    packet_1#(4) p1_4;
    packet_1#(5) p1_5;

    packet_2#(2) p2_2;
    packet_2#(3) p2_4;
    packet_2#(6) p2_5;

    initial begin
        p1_3 = new();
        p1_4 = new();
        p1_5 = new();

        p2_2 = new();
        p2_4 = new();
        p2_5 = new();

        if(p1_3.randomize()) begin
            $display("%p", p1_3.array);
        end
        else $display("Randomization has failed");

        if(p1_4.randomize()) begin
            $display("%p", p1_4.array);
        end
        else $display("Randomization has failed");

        if(p1_5.randomize()) begin
            $display("%p", p1_5.array);
        end
        else $display("Randomization has failed");
        //::::::::::::::::::::::::::::::::::::::::::::::::::
        if(p2_2.randomize()) begin
            foreach(p2_2.array[i]) begin
                $display("%p", p2_2.array[i]);
            end
        end
        else $display("Randomization has failed");

        if(p2_4.randomize()) begin
            foreach(p2_4.array[i]) begin
                $display("%p", p2_4.array[i]);
            end
        end
        else $display("Randomization has failed");

        if(p2_5.randomize()) begin
            foreach(p2_5.array[i]) begin
                $display("%p", p2_5.array[i]);
            end
        end
        else $display("Randomization has failed");
    end
endmodule

/*** OUTPUT PRINT STATEMENTS ****/
/*
# '{1, 11, 111}
# '{1, 11, 111, 1111}
# '{1, 11, 111, 1111, 11111}
# '{1}
# '{1, 1}
# '{1}
# '{1, 1}
# '{1, 1, 1}
# '{1}
# '{1, 1}
# '{1, 1, 1}
# '{1, 1, 1, 1}
# '{1, 1, 1, 1, 1}
# '{1, 1, 1, 1, 1, 1}
*/
