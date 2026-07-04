class consumer extends uvm_component;

    `uvm_component_utils(consumer)

    uvm_blocking_get_port #(int) get_port;

    function new(string name="consumer", uvm_component parent = null);
        super.new(name, parent);
        get_port = new("get_port",this);
    endfunction: new

    virtual task run_phase(uvm_phase phase);
        int data;
        forever begin
            get_port.get(data);
            `uvm_info("[CONSUMER]",$sformatf("Received data: %0d",data),UVM_LOW)
        end
    endtask: run_phase
endclass: consumer