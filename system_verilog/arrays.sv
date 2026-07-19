/**************************
SystemVerilog has various list based datastructures like arrays, queue, dynamic arrays, and associative arrays
Arrays are regular fixed size lists, whose size is known at the compile time
Dynamic Arrays are used when the size is determiend during the run time
Queue is a FIFO datastructure 
Associative Arrays are similar to the dictionary/key-value based data structures in programming languages
**************************/

module test;
    // Arrays of fixed size 10
    bit[3:0] array[10];
    int ages[] = '{5,6,3,12,15};
    initial begin
        /* This is called the scope randomize functions We have to use std::randomize(variable) as rand and randc cannot be used outside
            of class. We can also constraint the randomization using inline constraint along with "with" keyword as shown below
        */
        if(std::randomize(array)) begin
            $display("%p", array);
        end
        $display(":::::::::::::::::");
        if(std::randomize(array) with {unique {array};}) begin
            $display("Unique Values: %p", array);
        end

        // Size and Delete functions
        $display("Size of ages array: %0d", ages.size());
        $display("Size of array: %0d", $size(array));
    end

    //Dynamic Arrays
    bit[3:0] dynamic_array[];
    initial begin
        // We allocate the size dynamically
        dynamic_array = new[5];
        if(std::randomize(dynamic_array) with {foreach(dynamic_array[i]) dynamic_array[i]%2 == 0;}) begin
            
            $display("Size of the dyanmic array: %0d", dynamic_array.size());
            $display("%p", dynamic_array);

        end
    end

    // Associate arrays: How to create them
    int associative_array1[int];    // Creates an array with key "int" and value "int"
    int associative_array2[string]; // Creates an array with key "string" and value "int"
    int associative_array3[int] []; // Key is "int" value is an array of "int"
    // Associative Array has a library of functions
    // size() to get the size of the associative array
    // delete(key) or delete() to delete a particular key or delete the entire content of the array
    // exists(key) Returns 1 if a key is present, if not 0
    // first() 


    // Queue: FIFO
    int queue[$];
    // Queue supports many methods such as push_front() push_back() pop_front() pop_back(), delete(), and inset()
endmodule