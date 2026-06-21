class my_test extends uvm_component;

    `uvm_component_utils(my_test)

    my_env env;

    function new(string name = "my_test", uvm_component parent);   
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = my_env::type_id::create("env", this);
    endfunction: build_phase

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_root::get().print_topology();
    endfunction: end_of_elaboration_phase

endclass: my_test