class mem_test extends uvm_test;
    `uvm_component_utils(mem_test)

    function new(string name="mem_test", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual task run_phase();
        
    endtask: run_phase
endclass: mem_test