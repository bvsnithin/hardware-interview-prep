class mem_sequence extends uvm_sequence#(mem_seq_item);

    `uvm_object_utils(mem_sequence)

    function new(string name = "mem_sequence");
        super.new(name);
        `uvm_info("[BASE_SEQ]","Base sequence created",UVM_LOW)
    endfunction: new

    virtual task body();
        `uvm_do(req)
    endtask: body
    
endclass: mem_sequence

class mem_write_sequence extends mem_sequence;
    `uvm_object_utils(mem_write_sequence)

    function new(string name = "mem_write_sequence");
        super.new(name);
        `uvm_info("[MEM_WRITE_SEQ]","Write sequence created",UVM_LOW)
    endfunction: new

    virtual task body();
        `uvm_do_with(req, {req.wr_en == 1;})
    endtask: body
endclass: mem_write_sequence

class mem_read_sequence extends mem_sequence;
    `uvm_object_utils(mem_read_sequence)

    function new(string name = "mem_read_sequence");
        super.new(name);
        `uvm_info("[MEM_Read_SEQ]","Read sequence created",UVM_LOW)
    endfunction: new

    virtual task body();
        `uvm_do_with(req, {req.rd_en == 1;})
    endtask: body
endclass: mem_read_sequence