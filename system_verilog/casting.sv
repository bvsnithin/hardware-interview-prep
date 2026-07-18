class Parent;
    int addr = 10;

    function new();
        $display("Parent Constructor!");
    endfunction: new

    function void display();
        $display("Parent Display");
    endfunction: display
endclass: Parent


class Child extends Parent;
    int data = 20;
    function new();
        super.new();
        $display("Child Constructor!");
    endfunction: new

    virtual function void display();
        $display("Child Display is called!");
    endfunction: display
endclass: Child

module test;
    Child c, c1;
    Parent p1, p;
    initial begin

        // Upcasting
        c = new();
        p = c;
        c.display();
        $display("Value of addr is: %0d",c.addr);
        $display("Value of data is: %0d",c.data);


        //Downcasting
        // Here downcasting will fail
        $display("\n--------------------------\n");
        p1 = new();  // This creates a Parent object
        if ($cast(c1, p1)) begin
            $display("Downcast successful");
            c1.display();
        end else begin
            $display("Downcast FAILED — p1 is a Parent, not a Child");
        end

         $display("\n--------------------------\n");

        //This is how to do successful downcasting. 
        // Step 1: Create a Child object using a Child handle
        c1 = new();   
        // Step 2: Store it in a Parent handle (upcast — always works)
        p1 = c1;      
        // Step 3: Forget about c1 — pretend we only have p1
        c1 = null;    

        // Step 4: Now downcast — "is the thing inside p1 actually a Child?"
        if ($cast(c1, p1)) begin
            $display("Downcast successful! p1 was actually a Child");
            c1.display();
            $display("Value of addr is: %0d", c1.addr);
            $display("Value of data is: %0d", c1.data);
        end else begin
            $display("Downcast FAILED");
        end
    end

endmodule