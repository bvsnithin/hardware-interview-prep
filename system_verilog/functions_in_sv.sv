// Basic Function usage
// Functions in systemverilog are by default passed by value
module test;
    function void increment(input x);
        x = x + 1;
    endfunction

    function void increment_1(input int x, output int y);
        y = x + 1;
    endfunction

    // Note: functions using 'ref' must be declared 'automatic'
    function automatic void increment_2(ref int x);
        x = x+1;
    endfunction
    
    int a;
    int b;
    initial begin
        a = 10;
        increment(a);
        $display("a is %0d",a); // Prints 10 because 'a' is passed by value.
        // The increment happens on a local copy inside the function, leaving the original unchanged.

        increment_1(a,b);
        $display("b is %0d",b); // Prints 11 because 'b' is passed as an output argument,
        // returning the modified value back to the caller.

        a = 10;
        increment_2(a);
        $display("a is %0d",a); // Prints 11 because 'a' is passed by reference. 
        // The increment happens directly on the original variable without creating a copy.
        // NOTE: Functions using 'ref' must explicitly be declared as 'automatic' (as done above).
    end

endmodule