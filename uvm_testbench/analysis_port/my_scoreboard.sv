class my_scoreboard extends uvm_component;

    uvm_analysis_imp #(my_item, my_scoreboard) analysis_export;

    `uvm_component_utils(my_scoreboard)

    function new(string name="my_scoreboard", uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
    endfunction: new

    virtual function void write(my_item tr);
        `uvm_info("[SCB]",$sformatf("Received Address: %0h, Data: %0h",tr.addr, tr.data),UVM_LOW)
    endfunction: write

endclass: my_scoreboard