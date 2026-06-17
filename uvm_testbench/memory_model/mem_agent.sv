class mem_agent extends uvm_agent;

    `uvm_component_utils(mem_agent)

    mem_driver driver;
    mem_sequencer sequencer;
    mem_monitor monitor;

    function new(string name = "mem_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void connect_phase(uvm_phase phase);
        
    endfunction: connect_phase

endclass: mem_agent