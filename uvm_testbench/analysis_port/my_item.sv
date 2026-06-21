class my_item extends uvm_sequence_item;

    `uvm_object_utils(my_item)

    rand bit [7:0] addr;
    rand bit [7:0] data;

    function new(string name="my_item");
        super.new(name);
    endfunction:new

endclass: my_item