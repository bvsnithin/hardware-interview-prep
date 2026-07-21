/******** Mailbox in SystemVerilog ********/

// Mailbox facilities communication between processes to exchange data. 
// Mailbox behaves like a FIFO. One process can put a some data that can be read by another process

/* Mailbox Types
    1) Generic Mailbox - The generic mailbox can be put or get data of any data_type like int, bit, byte, string, etc. 
                         By default, the mailbox is a typeless or generic mailbox.

    2) Parameterized Mailbox - The parameterized mailbox can be put or get data of particular data_type. 
                               The parameterized mailbox is useful when data_type needs to be fixed. 
                               For differences in data_type, a compilation error is expected.
    3) Bounded Mailbox - Size is defined during creation of the mailbox. 
                         When the mailbox is full, no further write's can be done and all put calls are blocked
    4) Unbounded Mailbox - Size is undefined and hence the mailbox has unlimited size
*/

module test;
    mailbox mb = new(4); //Generic mailbox of size 4

    initial begin
        fork
            process_A();
            process_B();
        join
    end

    task process_A();
        mb.put(10);
        $display("Put data = %0d", 10);
        mb.put("Hello!");
        $display("Put data = %0s", "Hello!");
    endtask: process_A

    task process_B;
        int value;
        string string_value;
        mb.get(value);
        $display("Retrieved data = %0d", value);
        mb.get(string_value);
        $display("Retrieved data = %0s", string_value);
    endtask: process_B
endmodule