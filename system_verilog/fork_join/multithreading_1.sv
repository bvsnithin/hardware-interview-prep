/******************************
Write code that will create the four processes. Process_C should begin when Process_A has finished,
and then Process_D. However, Process_B ought to wait for Process_D to finish.

This solution uses events, wait, event.triggered and ->event concepts
*******************************/

module test;
    event process_a_done;
    event process_c_done;
    event process_d_done;

    initial begin
        fork: process_fork
            begin: process_a
                $display("Process A started: %0t",$time);
                #10
                $display("Process A completed: %0t",$time);
                -> process_a_done;
            end
            
            begin: process_b
                wait(process_d_done.triggered);
                $display("Process B started: %0t", $time);
                #20
                $display("Process B completed: %0t",$time);
            end

            begin: process_c
                wait(process_a_done.triggered);
                $display("Process C started: %0t", $time);
                #12;
                $display("Process C completed: %0t",$time);
                ->process_c_done;
            end
            
            begin: process_d
                wait(process_c_done.triggered);
                $display("Process D started: %0t", $time);
                #18;
                $display("Process D completed: %0t", $time);
                -> process_d_done;
            end
        join
    end
endmodule