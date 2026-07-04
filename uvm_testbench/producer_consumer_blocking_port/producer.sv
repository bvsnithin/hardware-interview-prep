class producer extends uvm_component;

    `uvm_component_utils(producer)
    
    uvm_blocking_put_port #(int) put_port;

    function new(string name="producer", uvm_component parent=null);
        super.new(name,parent);
        put_port = new("put_port", this);
    endfunction: new

    virtual task run_phase(uvm_phase phase);
        repeat(10) begin
            int data = $urandom_range(0,10);
            put_port.put(data);
            `uvm_info("[PRODUCER]", $sformatf("Produced Value: %0d",data),UVM_LOW)
        end
    endtask: run_phase
endclass: producer