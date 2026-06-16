
class transaction;
    logic [3:0] data;
    logic [8:0] id;

    function new(input logic [3:0] data = 0, input logic [8:0] id = 0);
        this.data = data;
        this.id = id;
    endfunction : new

    function void print();
        $display("Data: %04b --- ID: %09b",this.data, this.id);
    endfunction: print

endclass: transaction

module test;
    transaction tr = new();
    transaction tr1 = new(4'b1010, 9'b110001101);

    initial begin
        tr = new();
        tr1 = new(4'b1010, 9'b110001101);

        tr.print();
        tr1.print();
    end

endmodule