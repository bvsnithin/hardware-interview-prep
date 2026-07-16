
module test;
    
    // 1. Static Function
    // By default, tasks and functions in a module are static.
    // Their internal variables are allocated once and share memory across all calls (retaining their values between calls).
    function void count_static();
        int count = 0; // Static by default in a static function
        count++;
        $display("Static count is: %0d", count);
    endfunction

    
    // 2. Automatic Function
    // Using the 'automatic' keyword makes the function re-entrant.
    // Its internal variables are dynamically allocated on the stack for each call and destroyed when the function exits.
    function automatic void count_automatic();
        int count = 0; // Created fresh on each call
        count++;
        $display("Automatic count is: %0d", count);
    endfunction

    
    // 3. Static vs Automatic Variables inside an Automatic Task
    // Even if a task/function is automatic, you can explicitly declare a variable as 'static'. 
    // Conversely, in a static task/function, you can explicitly declare a variable as 'automatic'.
    
    task automatic mixed_task();
        int auto_var = 0;         // Automatic by default here
        static int stat_var = 0;  // Explicitly made static

        auto_var++;
        stat_var++;

        $display("mixed_task -> auto_var: %0d, stat_var: %0d", auto_var, stat_var);
    endtask

    
    initial begin
        $display("--- Calling Static Function ---");
        count_static(); // Prints 1
        count_static(); // Prints 2 (remembers previous value)
        count_static(); // Prints 3

        $display("--- Calling Automatic Function ---");
        count_automatic(); // Prints 1
        count_automatic(); // Prints 1 (re-initialized to 0 on every call)
        count_automatic(); // Prints 1

        $display("--- Calling Mixed Task ---");
        mixed_task(); // auto_var: 1, stat_var: 1
        mixed_task(); // auto_var: 1, stat_var: 2 (stat_var remembers its value)
        mixed_task(); // auto_var: 1, stat_var: 3


        $display("--- Fork Join_none with Automatic vs Static ---");
        // Problem: If you spawn threads in a loop using join_none, 
        // the loop finishes before the threads execute. They will all see the final value.
        // Solution: Use an automatic variable inside the loop to capture the current value!
        
        for (int i = 0; i < 3; i++) begin
            // We create a local automatic variable. A new instance is created for each loop iteration.
            automatic int auto_i = i;
            
            // If we use static, all threads share the SAME memory location,
            // so they will all print the last assigned value.
            static int stat_i; 
            stat_i = i;

            fork
                $display("Thread spawned at i=%0d -> auto_i=%0d, stat_i=%0d", i, auto_i, stat_i);
            join_none
        end
        wait fork; // Wait for all spawned threads to finish
    end
endmodule