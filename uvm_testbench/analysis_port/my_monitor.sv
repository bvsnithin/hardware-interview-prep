class my_monitor extends uvm_component;

    `uvm_component_utils(my_monitor)

    uvm_analysis_port #(my_item) ap;

    function new(string name = "my_monitor", uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction


    my_item tr;

    virtual task run_phase(uvm_phase phase);
        tr = my_item::type_id::create("tr");
        
        phase.raise_objection(this);

        repeat(10) begin

            if(tr.randomize()) begin
                `uvm_info("[MON]",$sformatf("Publishing transaction item, Address: %0h, Data: %0h",tr.addr, tr.data),UVM_LOW); 
                ap.write(tr);
            end
            else `uvm_fatal("[MON]","Randomization has failed");
            #10;
        end

        phase.drop_objection(this);
    endtask

endclass: my_monitor