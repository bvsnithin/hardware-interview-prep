/********** Encapsulation in SystemVerilog **********/
// Encapsulation binds the properties and behaviour into a single unit - called the class and restricts direct access to them
// Properties are the attributes of the class and behaviour is the funtions/methods inside the class. 
// Encapsulation binds them to the class and restricts access to them from outside.
// Access Modifiers - local(private) and protected keep the properties and behaviour restricted to the class and sometimes to the child class

class A;
    local int a;
    local int b;
    protected int c;

    function new(int a, int b, int c);
        this.a = a;
        this.b = b;
        this.c = c;
    endfunction: new

    local function void increment_a();
        this.a = this.a+1;
    endfunction: increment_a

    // Public methods to demonstrate encapsulation (Information Hiding & Getters/Setters)
    function void print_a();
        $display("Value of local a: %0d", this.a);
    endfunction

    function void call_increment_a();
        increment_a(); // Legal: Calling a local method from within the class
    endfunction

endclass: A

class B extends A;
    function new(int a, int b, int c);
        super.new(a, b, c);
    endfunction

    // Accessing protected property 'c' from parent class
    function void print_c();
        $display("Value of protected c (accessed from child class): %0d", this.c);
        // $display("a: %0d", this.a); // ILLEGAL: 'a' is local to A, cannot be accessed here
    endfunction
endclass: B

module test;
    A obj_A;
    B obj_B;

    initial begin
        obj_A = new(10, 20, 30);
        obj_B = new(100, 200, 300);

        // 1. Legal accesses (using public interfaces provided by the class)
        $display("--- Legal Accesses ---");
        obj_A.print_a();
        obj_A.call_increment_a(); // Modifies local 'a' via a public method
        obj_A.print_a();
        obj_B.print_c();          // Accesses protected 'c' via a public child method

        // 2. Illegal accesses (Encapsulation preventing direct modification)
        // Uncommenting any of the lines below will cause a compilation error:
        
        obj_A.a = 50;          // ERROR: Access to local member 'a' in class 'A' is not allowed here.
        obj_A.b = 60;          // ERROR: Access to local member 'b' in class 'A' is not allowed here.
        obj_A.c = 70;          // ERROR: Access to protected member 'c' in class 'A' is not allowed here.
        obj_A.increment_a();   // ERROR: Access to local member 'increment_a' in class 'A' is not allowed here.
        obj_B.c = 80;          // ERROR: 'c' is protected, so outside access is invalid even from an instance of B
    end
endmodule: test