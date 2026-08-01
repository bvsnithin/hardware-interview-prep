/**** Explanation of below example code ****/
/*
- Each for loop creates a child process, however since we use fork-join_none, none of these will execute right away
- All the child processes are created but not executed until loop completes iteration
- Once the loop completes iteration, the scheduled child processes will start execution
- However, all the processes point to the same "i" value and hence see the same value
- Value of i at the end of the loop's iterations will be 3
- Hence, the print statements inside the child processes print i to be 3
*/

module fork_join_none;
    initial begin
        for (int i = 0; i < 3; i++) begin
            fork
                begin
                    #1;
                    $display("[JOIN_NONE_MODULE] Time: %0t | Driver ID: %0d active", $time, i);
                end
            join_none
            $display("[JOIN_NONE_MODULE] Time: %0t | Scheduled %0d!", $time, i);
        end
        #1; 
        // The exact delay value does not matter for allowing join_none children to start.
        // Once the parent process blocks here, the forked processes are allowed to execute.
        // They do not wait for this delay to finish; they start when the parent yields control.
        
    end
endmodule
/**** PRINT STATEMENTS ****/
/*
[JOIN_NONE_MODULE] Time: 0 | Scheduled 0!
[JOIN_NONE_MODULE] Time: 0 | Scheduled 1!
[JOIN_NONE_MODULE] Time: 0 | Scheduled 2!
[JOIN_NONE_MODULE] Time: 1 | Driver ID: 3 active
[JOIN_NONE_MODULE] Time: 1 | Driver ID: 3 active
[JOIN_NONE_MODULE] Time: 1 | Driver ID: 3 active
*/


/*
- Unlike previous block, this uses a join, which blocks the execution until the child process is completed with it's own execution. 
*/
module fork_join;
    initial begin
        for (int i = 0; i < 3; i++) begin
            fork
                begin
                    #1;
                    $display("[JOIN_MODULE] Time: %0t | Driver ID: %0d active", $time, i);
                end
            join
            $display("[JOIN_MODULE] Time: %0t | Scheduled %0d!", $time, i);
        end
        #1;
    end
endmodule

// How to print the unique i value per each child block? Use - automatic
// In systemverilog, declarations are static by default and hence all processes saw the same value of i
// To dedicate separate view of i, automatic is used - which acts like a private storage for each child processes
module fork_join_none_automatic;
    initial begin
        #10;
        for (int i = 0; i < 3; i++) begin
            automatic int j = i;
            fork
                begin
                    #1;
                    $display("[JOIN_NONE_MODULE] Time: %0t | Driver ID: %0d active", $time, j);
                end
            join_none
            $display("[JOIN_NONE_MODULE] Time: %0t | Scheduled %0d!", $time, i);
        end
        #1; 
    end
endmodule
