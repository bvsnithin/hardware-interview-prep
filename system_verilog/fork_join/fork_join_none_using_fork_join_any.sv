/********************************************************
How to implement fork join_none block using fork join_any?
********************************************************/

// A join_any will wait for one of the child processes to complete, before moving forward to the execution.
// A join_none does not wait for any child prcoesses to complete. 
// Hence to implement join_none behaviour, we just need to create a dummy block inside the fork
module test;
    initial begin
        fork
            begin: process_A
                //This is a dummy block that finishes right away
            end
            
            begin: process_B
                #12;
                $display("Time: %0t, Process B is completed", $time);
            end

            begin: process_C
                #15;
                $display("Time: %0t, Process C is completed", $time);
            end
        join_any
        $display("Time: %0t, Parent continues", $time);
    end
endmodule