class mem_monitor extends uvm_monitor;

    virtual mem_if vif;

    `uvm_component_utils(mem_monitor)

    uvm_analysis_port#(mem_seq_item) item_collected_port;

    mem_seq_item collected_item;

    function new(string name="mem_monitor", uvm_component parent);
        super.new(name,parent);
        collected_item = new();
        item_collected_port = new("item_collected_port",this);
    endfunction: new

    function void build_phase(uvm_phase phase);
        if(!(uvm_config_db#(virtual mem_if)::get(this,"","vif",vif))) begin
            `uvm_fatal("[NO VIF]",{"Virtual interface is not present for",get_full_name(),".vif"})
        end
    endfunction: build_phase

endclass: mem_monitor