/* This file has some interesting scenarios of how fork join_none behaves with loops*/

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

//-------------------------------------------------------------------------------------------------------------------------------------//

/*
- Unlike previous block, this uses a join, which blocks the execution until the child process is completed with it's own execution. 
*/
module fork_join;
    initial begin
        #10;
        $display(":::::::::::::::::::::::::::::::::::::");

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
/**** PRINT STATEMENTS ****/
/*
[JOIN_MODULE] Time: 11 | Driver ID: 0 active
[JOIN_MODULE] Time: 11 | Scheduled 0!
[JOIN_MODULE] Time: 12 | Driver ID: 1 active
[JOIN_MODULE] Time: 12 | Scheduled 1!
[JOIN_MODULE] Time: 13 | Driver ID: 2 active
[JOIN_MODULE] Time: 13 | Scheduled 2!

Since, fork join blocks the execution of the parent process until the child process completes executing, we see the "Scheduled" logs after the child process is completed.
*/

//-------------------------------------------------------------------------------------------------------------------------------------//

// How to print the unique i value per each child block? Use - automatic
// In systemverilog, declarations are static by default and hence all processes saw the same value of i
// To dedicate separate view of i, automatic is used - which acts like a private storage for each child processes
module fork_join_none_automatic;
    initial begin
        #20;
        $display(":::::::::::::::::::::::::::::::::::::");
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
/**** PRINT STATEMENTS ****/
/*
[JOIN_NONE_MODULE] Time: 20 | Scheduled 0!
[JOIN_NONE_MODULE] Time: 20 | Scheduled 1!
[JOIN_NONE_MODULE] Time: 20 | Scheduled 2!
[JOIN_NONE_MODULE] Time: 21 | Driver ID: 2 active
[JOIN_NONE_MODULE] Time: 21 | Driver ID: 1 active
[JOIN_NONE_MODULE] Time: 21 | Driver ID: 0 active
*/

//-------------------------------------------------------------------------------------------------------------------------------------//

module fork_join_with_delay;
    initial begin
        #30;
        $display(":::::::::::::::::::::::::::::::::::::");
        for(int i=0;i<3;i++)
        begin
            #1;
            fork
                begin
                    $display("[JOIN_NONE_MODULE_] Time: %0t | Driver ID: %0d active", $time, i);
                end
            join_none
            $display("[JOIN_NONE_MODULE] Time: %0t | Scheduled %0d!", $time, i);
        end
  end
endmodule

/**** PRINT STATEMENTS ****/
/*
[JOIN_NONE_MODULE] Time: 31 | Scheduled 0!
[JOIN_NONE_MODULE_] Time: 31 | Driver ID: 1 active
[JOIN_NONE_MODULE] Time: 32 | Scheduled 1!
[JOIN_NONE_MODULE_] Time: 32 | Driver ID: 2 active
[JOIN_NONE_MODULE] Time: 33 | Scheduled 2!
[JOIN_NONE_MODULE_] Time: 33 | Driver ID: 3 active
*/

/********** IMPORTANT NOTES ON FORK JOIN_NONE BEHAVIOUR **********/
/*
- fork...join_none spawns processes asynchronously without blocking the parent thread
- However, spawned child processes DO NOT execute immediately and they are queued in the scheduler
- Child processes cannot run until the parent thread explicitly yields execution control
- Example: via #delay, @(event), wait(), or #0;


- Shared loop variables (like "int i") are evaluated by child processes at the EXACT time the child executes, NOT when it was queued/forked.
- If the parent loops to completion before yielding, all children see the final loop value (e.g., i = 3).
- If the parent yields inside the loop body, children execute mid-loop and see intermediate values of "i" at that point of time.

- To give each child process its own copy of the loop index, capture i into a local automatic variable 
  (automatic int j = i;) before the fork block, or pass it into an "automatic task/function"
*/