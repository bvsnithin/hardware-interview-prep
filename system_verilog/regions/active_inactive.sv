module test_inactive;
    int shared_var = 1;

    // Block A
    initial begin
        #0; // Yield to the Inactive Region!
        $display("[Block A - Inactive Region] shared_var is %0d", shared_var);
    end

    // Block B
    initial begin
        // This runs in the normal Active Region
        shared_var = 99; 
        $display("[Block B - Active Region] Just updated shared_var to %0d", shared_var);
    end


/****Expected Result ****

[Block B - Active Region] Just updated shared_var to 99
[Block A - Inactive Region] shared_var is 99

*************************/