class mem_seq_item extends uvm_sequence_item;

    logic [3:0] addr;
    logic [7:0] wdata;
    logic [7:0] rdata;

    logic wr_en;
    logic rd_en;

    //Register with the factory
    `uvm_object_utils(mem_seq_item)

    function new(string name = "mem_seq_item");
        super.new(name);
        `uvm_info("[MEM_SEQ_ITEM]","Memory Sequence Item Created",UVM_LOW)
    endfunction: new

    constraint c_read_write{
        wr_en != rd_en;
    }
endclass: mem_seq_item