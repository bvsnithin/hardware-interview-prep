class Parent;
    int addr = 10;

    function new();
        $display("Parent Constructor!");
    endfunction: new

    function void display();
        $display("Parent Display");
    endfunction: display

    virtual function void display1();
        $display("Parent Display1");
    endfunction: display1
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

    function void display1();
        $display("Child Display1 is called");
    endfunction: display1
endclass: Child

module test;
    Child c, c1;
    Parent p1, p;
    initial begin

        // Upcasting
        // Child Object ----> Parent Handle
        // Upcasting happens implicitly because a Child is a Parent

        c = new();
        p = c;

        c.display();  // Will print "Child Display is called!" because we called the display() on child handle pointed to child object

        p.display();  // Will print "Parent Display" because display() in Parent class is not virtual function

        p.display1(); // Will print "Child Display1 is called" because display1() in Parent class is virtual function

        $display("Value of addr is: %0d",c.addr); // Prints 10 because Child is a Parent and hence can see address
 
        $display("Value of data is: %0d",c.data); // Prints 20 because data is an attribute of child

        // $display("Value of data is: %0d", p.data); // Fails because attributes are resolved during compile time and data is not a class item of "Class Parent"


        // Downcasting
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