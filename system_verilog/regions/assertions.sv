/*************** Assertions ***************/
// There are two types of assertions
// 1) Immediate assertions
// 2) Concurrent assertions
// Immediate assertions execute right away and they are sampled and executed in the active region.
// Concurrent assertions use the syntax: assert property (<<property>>);
// In concurrent assertions, we sample the values in the preponed region, however, they get evaluated in the observed region. 

// Deferred assertions are in-between immediate and concurrent assertions, because they are sampled in the active region just like the
// immediate assertions, but the reporting happens in the observed region (assert #0). 

// Final deferred assertion defers the reporting to the postponed region (assert final).

module test;
    logic clk = 0;
    int a = 1;

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        a = 2;

        assert (a==2) 
            $display("[IMMEDIATE ASSERTION] The value of a is %0d",a);
        else 
            $display("[IMMEDIATE ASSERTION] The value of a is not 2");

        assert #0 (a==2) 
            $display("[DEFERRED IMMEDIATE ASSERTION] The value of a is %0d",a);
        else 
            $display("[DEFERRED IMMEDIATE ASSERTION] The value of a is not 2");

        assert final (a==2) 
            $display("[DEFERRED FINAL ASSERTION] The value of a is %0d",a);
        else 
            $display("[DEFERRED FINAL ASSERTION] The value of a is not 2");
        
        #20 $finish;
    end

    assert property(
        @(posedge clk)
        a == 1
    )
    else $error("[CONCURRENT ASSERTION] The value of a is not 1");

endmodule