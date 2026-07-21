

module fork_join;
    initial begin
        for (int i = 0; i < 3; i++) begin
            fork
                begin
                    #1;
                    $display("Time: %0t | Driver ID: %0d active", $time, i);
                end
            join_none
        end
        #1;
    end
endmodule