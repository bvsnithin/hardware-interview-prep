/**********
Given an input array, randomly map elements to N output queues (N parameterized). 
Use UVM SystemVerilog constraints so that: 
(1) each input element appears in exactly one output queue, 
(2) all N output queues are non-empty, and 
(3) feasibility requires N ≤ input_size.
***********/

class packet;
    rand int M, N; // M: size of the input array, N: number of queues N <= m

    rand int input_array[]; // Input array of size M;

    rand int output_queues[][$]; // An associative array: An array of queues. Number of queues = N

    // Indexes that indicate in which queue should the input_array element be placed in 
    rand int indexes[];

    // Constraint to generate M and N sizes
    constraint c_sizes{
        M inside {[5:10]};
        N inside {[1:M]};

        // Constraint to generate the input array with size M and output array with size N
        input_array.size() == M;
        indexes.size() == M;

        output_queues.size() == N;
    }

    // Constraint to generate elements for input array
    constraint c_input_array{
        foreach(input_array[i]){
            input_array[i] inside {[0:15]};
        }

        unique {input_array};
    }

    // Constraint to populate indexes array to determine into which queue should each element go into
    constraint c_indexes{
        foreach(indexes[i]){
            indexes[i] inside {[0:N-1]};
        }
    }

    // None of the queues should be empty
    constraint c_use_all_queues{
        foreach(output_queues[i]) {
            indexes.sum() with (int'(item == i)) !=0;
        }
    }

    // Populate queues
    function void post_randomize();
        // Everynew randomization clears the previous entries
        foreach(output_queues[i]) begin
            output_queues[i].delete();
        end


        foreach(input_array[i]) begin
            output_queues[indexes[i]].push_back(input_array[i]);
        end
    endfunction

    
endclass

module test;
    packet p;
    int n;
    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                $display(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
                $display("Input array size M : %0d, Input Array: %p", p.M, p.input_array);
                $display("Output array size N: %0d", p.N);
                $display("Indexes: %p", p.indexes);
                n = p.N;
                $display("Output Queues: ");
                for(int i = 0;i<n;i++) begin
                    $display("%p", p.output_queues[i]);
                end
                $display(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
            end
        end
        
    end
endmodule