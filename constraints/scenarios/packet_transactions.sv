/******************
1) Randomizable field pkt_type (2 bits). Constrain it so the value 0 appears 50% of the time, 1 appears 30% of the time, and 2 and 3 split the remaining 20% evenly.
2) Fields length (8 bits) and payload[] (a dynamic array of bytes). Constrain length to be between 10 and 64, and constrain payload.size() to equal length. 
   Add a constraint that the sum of all payload bytes is even.
3) class Transaction with fields mode (enum: READ, WRITE, IDLE), addr (32 bits), and data (32 bits). Constraints:

If mode == IDLE, both addr and data must be 0.
If mode == READ, data must be 0, and addr must be 4 byte aligned (lowest 2 bits are 0).
If mode == WRITE, addr must be within the range 0x1000 to 0x2000, and data must be nonzero.

******************/

typedef enum logic[1:0] {READ, WRITE, IDLE} mode_t;

class Transaction;
    rand bit[1:0]  pkt_type;
    rand bit[7:0]  length;
    rand bit[7:0]       payload[];
    rand mode_t    mode;
    rand bit[31:0] addr;
    rand bit[31:0] data;

    constraint c_pkt_type{
        pkt_type dist{
            2'b00:=50,
            2'b01:=30,
            [2'b10: 2'b11]:/20
        };
    }

    constraint c_length{
        length inside {[10:64]};
    }

    constraint c_payload_size{
        payload.size() == length;
    }

    constraint c_payload_sum{
        payload.sum()%2 == 0;
    }

    constraint c_solve_order{
        solve mode before addr, data;
    }

    constraint c_address_modes{
        if(mode == IDLE){
            addr == 32'b0;
            data == 32'b0;
        }
        else if(mode == READ){
            data == 32'b0;
            addr % 4 == 0;
        }
        else if(mode == WRITE){
            data != 0;
            addr inside {[32'h1000:32'h2000]};
        }
    }

endclass: Transaction

module test;
    Transaction tr;

    initial begin
        repeat(10) begin
            tr = new();
            if(tr.randomize()) begin
                $display("Packet Type: %02b", tr.pkt_type);
                $display("Length: %0d, Payload Generated: %p", tr.length, tr.payload);
                $display("Mode: %0s, Address Generated: %0h, Data Generated: %0h", tr.mode.name(), tr.addr, tr.data);
            end
        end
    end
endmodule