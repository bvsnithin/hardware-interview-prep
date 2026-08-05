/******************************************
Challenge: The Custom Barrier Sync 
Scenario: You are writing a multicore verification environment. You spawn 4 parallel threads. 
Each thread performs "Phase 1" (which takes a random amount of time). 
None of the threads are allowed to proceed to "Phase 2" until all 4 threads have successfully completed Phase 1. 

Implement a thread-safe barrier synchronization mechanism using a SystemVerilog semaphore or an array of events.
******************************************/

module challenge;
    semaphore mutex = new(1);
    semaphore barrier = new(0); //0 keys till all 4 threads have arrived. So, get calls are blocked
    int count = 0;
    
    task automatic core_thread(int core_id);
        int delay = $urandom_range(10, 50);
        #(delay); // Phase 1 execution
        $display("Time: %0t | Core %0d finished Phase 1", $time, core_id);
        
        mutex.get(1); //This call blocks until the lock is available for count variable
        // $display("::::::: Time: %0t | Core %0d Arrived to take the lock and increment count :::::::", $time, core_id);
        count++;

        if(count == 4) begin
            $display("*****************************************");
            barrier.put(3);   // Free other cores that are blocked
            mutex.put(1);     // Free up the lock on counter variable
        end
        else begin
            mutex.put(1);
            barrier.get(1); //Blocked till a key is available for barrier. Key is only available after 4 threads reach. Hence this blocks
        end
        
        
        
        $display("Time: %0t | Core %0d entering Phase 2", $time, core_id);
    endtask

    initial begin
        fork
            core_thread(0);
            core_thread(1);
            core_thread(2);
            core_thread(3);
        join
    end
endmodule

/*** Example flow ***/
/*
Consider the following simulation times for completion of phase 1 by each core
Time: 19 | Core 1 finished Phase 1
Time: 21 | Core 3 finished Phase 1
Time: 38 | Core 0 finished Phase 1
Time: 46 | Core 2 finished Phase 1

When core 1 finishes the p1 first, it increments count and checks if count == 4
Since count is only 1, it puts back the key to allow other cores increment count and wait till the barrier is open

Core 3 finishes at 21 and checks count and sees it's only 2
Core 3 waits for barrier to open

Core 0 finishes next at 38 and increments count and checks if it's 4 but count is only 3
Core 0 waits for barrier to open

Core 2 arrives, increments count and now count is 4
Hence if condition passes and now puts 3 barrier keys - allowing the waiting cores 1,3,0 to unblock and release
*/