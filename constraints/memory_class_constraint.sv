/**********************
Suppose you have a memory transaction class with:
address: 32 bits
data: 64 bits
read/write bit

How would you write constraints to generate:

70% reads and 30% writes
Addresses only within the range 0x1000 to 0x1FFF
Data should be aligned to 8 bytes
8-byte aligned means the address should be a multiple of 8, not that the data is 64 bits.
For example:
Valid:
0x1000
0x1008
0x1010

Invalid:
0x1001
0x1002
0x1007
*************************/

class mem_transaction;
    rand bit [31:0] addr;
    rand bit [63:0] data;
    rand bit        write;          //Write - 1, Read - 0

    constraint c_read_write_distribution{
        write dist {
            1:= 30,
            0:= 70
        };
    }

    constraint c_address_range{
        addr inside {[32'h1000:32'h1fff]};
    }

    constraint c_data_alignment{
        addr[2:0] == 3'b000; 
    }
endclass: mem_transaction

module test;
    mem_transaction packet;

    initial begin
        packet = new();
        repeat(5) begin
            if(packet.randomize()) begin
                $display("Address: %04h, Data: %08h, Write/Read: %0b",packet.addr, packet.data, packet.write);
            end
        end
    end
endmodule