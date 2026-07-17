/*******************************************************************************
Implement the behavior of a standard "fork join" block (where the parent waits 
for ALL child processes to finish) using ONLY "fork join_none" and the 
"wait fork" statement. 

Assume you have 3 processes (A, B, C) with random delays.
*******************************************************************************/

module test;
    initial begin
        fork
            begin: process_a
                int random_delay = $urandom_range(10,20);
                #(random_delay);
                $display("TIME = %0t: Process A is completed", $time);
            end
            
            begin: process_b
                int random_delay = $urandom_range(10,20);
                #(random_delay);
                $display("TIME = %0t: Process B is completed", $time);
            end

            begin: process_c
                int random_delay = $urandom_range(10,20);
                #(random_delay);
                $display("TIME = %0t: Process A is completed", $time);
            end
        join_none
        wait fork;
        $display("TIME = %0t: Parent now continues", $time);
    end
endmodule