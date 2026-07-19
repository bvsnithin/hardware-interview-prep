/***********************************
Question: Iterate an associative array and print the key and value using for loop
Next iteratre the associate array without using for loop and only using first() and next()
***********************************/

module test;
    int array[int]; // An associative array with key of int type and value of int type
    int x; //Key for iteration
    initial begin
        array[111] = 10;
        array[121] = 12;
        array[113] = 14;
        array[112] = 17;

        // Using foreach will print in order
        foreach(array[i]) begin
            $display("Key: %0d, Value: %0d", i, array[i]); 
        end

        $display("\n ::::::::::::: \n");
        //Using first() and next()
        if(array.first(x)) begin
            do begin
                $display("Key: %0d, Value: %0d", x, array[x]); 
            end
            while(array.next(x));   //next() updates the key x with new value and iterates till next() returns 0
        end
    end
endmodule