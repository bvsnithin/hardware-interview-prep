class mem_driver extends uvm_driver #(mem_seq_item);

    virtual mem_if vif;

    `uvm_component_utils(mem_driver)
    
    function new(string name="mem_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("[DRIVER]","Driver Build Phase in Execution",UVM_LOW)
        if(!uvm_config_db#(virtual mem_if)::get(this,"","vif",vif)) begin
            // `uvm_fatal("[NO VIF]",$sformat("Virtual Instance is not found in the DB for %0s.vif",get_full_name()))
            `uvm_fatal("[NO VIF]", {"Virtual interface is missing for ",get_full_name(),".vif"})
        end
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            send_to_dut();
            seq_item_port.item_done(req);
        end
    endtask: run_phase

    virtual task send_to_dut();
        
    endtask

endclass: mem_driver