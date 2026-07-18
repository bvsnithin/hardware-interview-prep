// A fork join_none starts all the child processes but never waits for any of them to complete. 
// Hence when we the for loop executes, it will start 

module automatic_fork_join;
    initial begin
        for (int i = 0; i < 5; i++) begin
            automatic int j = i;
            fork
                begin
                    #10;
                    $display("Time: %0t | Driver ID: %0d active", $time, j);
                end
            join_none
        end
        wait fork; // Wait for background threads to finish before ending simulation
    end
endmodule