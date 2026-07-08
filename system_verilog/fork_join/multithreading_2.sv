/******************************
Write code that will create the four processes. Process_C should begin when Process_A has finished,
and then Process_D. However, Process_B ought to wait for Process_D to finish.

This solution only uses fork join
*******************************/

module  test;
    initial begin
        //Since we are using join, it blocks the execution of lines after the join block until all 
        //children inside the fork are completed with execution. 
        fork: Process_A
            $display("Process A started execution: %0t", $time);
            #10
            $display("Process A completed execution: %0t", $time);
        join

        fork: Process_C
            $display("Process C started execution: %0t", $time);
            #12
            $display("Process C completed execution: %0t", $time);
        join

        fork: Process_D
            $display("Process D started execution: %0t", $time);
            #16
            $display("Process D completed execution: %0t", $time);
        join

        fork: Process_B
            $display("Process B started execution: %0t", $time);
            #20
            $display("Process B completed execution: %0t", $time);
        join
    end
endmodule