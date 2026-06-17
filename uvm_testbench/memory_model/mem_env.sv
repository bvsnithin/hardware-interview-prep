class mem_env extends uvm_env;
    `uvm_component_utils(mem_env)

    function new(string name = "mem_env", uvm_component parent);
    endfunction: new

    function void connect_phase(uvm_phase phase);
    endfunction
endclass: mem_env