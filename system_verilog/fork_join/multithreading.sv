// module test_fork_join;
//     //This created a total of 10 child processes.
//     initial begin
//         repeat(5) begin
//             fork
//                 begin
//                     #10 $display("[FORK_JOIN] Hello, this is fork join process #1 %0t",$time);
//                 end
//                 begin
//                     #20 $display("[FORK_JOIN] Hello, this is fork join process #2 %0t",$time);
//                 end
//             join
//         end
//         $display("I am parent: child process have completed running, I am running at; %0t",$time);
//     end
// endmodule  

module test_fork_join_any;
    initial begin
        $display("----------------------------");
        repeat(5) begin
            fork
                begin
                    #10 $display("[FORK_JOIN_ANY] Hello, this is fork join process #1 %0t",$time);
                end
                begin
                    #20 $display("[FORK_JOIN_ANY] Hello, this is fork join process #2 %0t",$time);
                end
            join_any
        end
        $display("I am parent: a child process has completed running, I am running at; %0t",$time);
    end
endmodule 

module test_fork_join_none;
    initial begin
        $display("----------------------------");
        repeat(5) begin
            fork
                begin
                    #10 $display("[FORK_JOIN_NONE] Hello, this is fork join process #1 %0t",$time);
                end
                begin
                    #20 $display("[FORK_JOIN_NONE] Hello, this is fork join process #2 %0t",$time);
                end
            join_any
        end
        $display("I am parent: I will execute right away; %0t",$time);
    end
endmodule 

module tb;
    initial begin
        for(int i=0;i<3;i++) begin
            // #1
            fork 
                automatic int j=i;
                $display("Value of j: %0d at time = %0t",j,$time);
            join
            // $display("Value of i: %0d",i);
        end
    end
endmodule