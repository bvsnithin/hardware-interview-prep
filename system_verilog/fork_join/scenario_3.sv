/*******
Resume simulation when any 2 threads out of 3 get completed within fork-join_any

There are three parallel threads running in fork-join_any.
I want to come-out from that when any two threads get completed.
How to do this?
********/

// Solving this using semaphore
// We will wait until we get 2 keys -> Then kill the fork
module scenario_3;
    semaphore sem = new(0);
    initial begin
        fork 
            begin: process_1
                automatic int random_delay = $urandom_range(0,20);
                #(random_delay);
                $display("Process 1 completed at [TIME: %0t]", $time);
                sem.put(1);
            end
            
            begin: process_2
                automatic int random_delay = $urandom_range(0,20);
                #(random_delay);
                $display("Process 2 completed at [TIME: %0t]", $time);
                sem.put(1);
            end

            begin: process_3
                automatic int random_delay = $urandom_range(0,20);
                #(random_delay);
                $display("Process 3 completed at [TIME: %0t]", $time);
                sem.put(1);
            end
        join_any
        sem.get(2);
        disable fork;
        $display("2 Processes completed, quitting the fork! [TIME: %0t]", $time);
    end
endmodule
