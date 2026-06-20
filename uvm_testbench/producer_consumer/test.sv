class test extends uvm_test;

    `uvm_component_utils(test)

    test_env env;

    function new(string name = "test", uvm_component parent);   
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = test_env::type_id::create("test_env", this);
    endfunction: build_phase

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_root::get().print_topology();
    endfunction: end_of_elaboration_phase

endclass: test