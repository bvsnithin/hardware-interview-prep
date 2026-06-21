class test_env extends uvm_env;

    `uvm_component_utils(test_env)
    
    producer prod;
    consumer consume;
    uvm_tlm_fifo #(int) fifo;

    function new(string name="test_env", uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        prod = producer::type_id::create("prod", this);
        consume = consumer::type_id::create("consumer", this);
        fifo = new("fifo", this, 1);
    endfunction: build_phase
 
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        prod.put_port.connect(fifo.put_export);
        consume.get_port.connect(fifo.get_export);
    endfunction: connect_phase
endclass: test_env