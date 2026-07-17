/****************
Implement fork join_any using fork join_none.
****************/

// To make this happen we can use events in systemverilog
// A fork join_none let's the program continue it's execution without waiting for the child processes to complete
// While the parent executes, children run in the background. 
// A for join_any on other hand, makes the parent wait until atleast one child is compelted. Once a child is compelted, the main program unblocks
// and continues execution. Rest of the children execute in the background. 
// For this particular question we will place a wait block after join_none. Thus we wait till one of the processes will be compelted

module test;
    event some_child_done;

    initial begin
        fork
            begin:process_a
                #10;
                $display("Process A completed at: %0t", $time);
                -> some_child_done;
            end
            begin:process_b
                #12;
                $display("Process B completed at : %0t", $time);
                -> some_child_done;
            end
        join_none
        wait(some_child_done.triggered);
        $display("Some child process completed, Parent continues..... :%0t",$time);
    end
endmodule