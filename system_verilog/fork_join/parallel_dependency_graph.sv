/*******************************************************************************
Write code that will create four parallel processes: Process_A, Process_B, 
Process_C, and Process_D. 

- Process_A and Process_B must start executing immediately.
- Process_C must start as soon as EITHER Process_A OR Process_B finishes.
- Process_D must start only after BOTH Process_A AND Process_B have finished.
*******************************************************************************/

module test;
    logic process_a_done = 0;
    logic process_b_done = 0;
    initial begin
        fork: process_A_or_B
            begin: Process_A
                #10;
                $display("Process A completed at: %0t", $time);
                process_a_done = 1;
            end

            begin: Process_B
                #25;
                $display("Process B completed at: %0t", $time);
                process_b_done = 1;
            end
        join_any

        fork
            begin: process_C
                wait(process_b_done || process_a_done);
                #100;
                $display("Process C completed at: %0t", $time);
            end

            begin: Process_D
                wait(process_b_done && process_a_done);
                #20;
                $display("Process D completed at: %0t", $time);
            end
        join
        $display("All Processes completed at: %0t", $time);
    
        
    end
endmodule