//Execution in NBA region

module test;
    int a = 2;
    int b = 3;

    initial begin
        // This code below swaps a and b. But why? Because they are using Non blocking assignments and 
        // the assignment happens parallely in NBA region
	    a <= b;
        b <= a;
        $display("a: %0d, b: %0d", a,b);
        $monitor("a: %0d, b: %0d", a,b);

        // When you run this, you will observe that the display statement will print a:2, b:3. Why?
        // Because display executes in Active region and hence it finishes before the NBA assignment is completed.
        // However, Monitor executes in the postponed region, and this occurs after NBA region, hence it prints the values after NBA is done 
    end

endmodule