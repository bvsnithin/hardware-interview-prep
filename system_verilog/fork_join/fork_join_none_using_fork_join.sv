/*******************************************************
Implement fork join_none behaviour using fork join only!

This is a trick question and an interviewer generally asks this to see how you can play around with different concepts in systemverilog. 

You can try to emulate the join_none behaviour in a different ways. I have listed one way of using it in an interview
********************************************************/

/* 
- A fork join_none schedules all the child processes. 
- These child processes do not run right away. 
- A fork join on the other hand is a blocking behaviour. 
- All child processes in fork join start execution right away and the parent process yields and waits till they complete.
- The parent thread cannot pass the join line until every child process inside terminates.

 - fork..join_none: Spawns child threads without blocking the parent; child threads execute in the background once the parent yields or blocks.
 - fork..join: Strictly blocking; the parent thread cannot proceed past 'join' until ALL child threads complete.

This approach uses events and always block
*/


module test;

    event e_start_child_processes;

    initial begin
        $display("[TIME: %0t] Parent: Triggering background tasks", $time);

        -> e_start_child_processes; 
        $display("[TIME: %0t] Parent: Proceeding immediately! (join_none achieved)", $time);

        #100;
        $display("[TIME: %0t] Simulation complete.", $time);
        $finish; 
    end

    task automatic task_a();
        int random_delay = $urandom_range(10,30);
        #(random_delay);
        $display("[TIME: %0t], Task A completed", $time);
    endtask

    task automatic task_b();
        int random_delay = $urandom_range(10,30);
        #(random_delay);
        $display("[TIME: %0t], Task B completed", $time);
    endtask

    always @(e_start_child_processes) begin
        fork 
            task_a();
            task_b();
        join
    end

    
endmodule
