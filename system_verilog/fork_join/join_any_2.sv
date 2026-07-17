/*******************************************************************************
Write code that spawns 4 independent, parallel processes (A, B, C, D), each 
taking a completely random amount of processing time (#delay). 

The parent thread must unblock and continue execution as soon as ANY TWO 
processes have completed. It should not wait for the 3rd or 4th process.
*******************************************************************************/

module test;

    logic process_a_done = 0;
    logic process_b_done = 0;
    logic process_c_done = 0;
    logic process_d_done = 0;

    initial begin
        fork
        
            begin: Process_A
                automatic int delay = $urandom_range(1,20);
                #(delay);
                $display("[TIME: %0t], Process A Completed", $time);
                process_a_done = 1;
            end

            begin: Process_B
                automatic int delay = $urandom_range(1,20);
                #(delay);
                $display("[TIME: %0t], Process B Completed", $time);
                process_b_done = 1;
            end

            begin :Process_C            
                automatic int delay = $urandom_range(1,20);
                #(delay);
                $display("[TIME: %0t], Process C Completed", $time);
                process_c_done = 1;
            end

            begin :Process_D            
                automatic int delay = $urandom_range(1,20);
                #(delay);
                $display("[TIME: %0t], Process D Completed", $time);
                process_d_done = 1;
            end

        join_none
        wait($countones({process_a_done, process_b_done, process_c_done, process_d_done}) == 2);
        $display("[TIME: %0t], 2 Processes Completed!!!",$time);
    end

endmodule