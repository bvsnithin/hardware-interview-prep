class my_env extends uvm_component;
    `uvm_component_utils(my_env)

    function new(string name="my_env", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    my_monitor mon;
    my_scoreboard scb;
    my_logger log;
    my_coverage cov;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon = my_monitor::type_id::create("mon", this);
        scb = my_scoreboard::type_id::create("scb",this);
        log = my_logger::type_id::create("log",this);
        cov = my_coverage::type_id::create("cov",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon.ap.connect(scb.analysis_export);
        mon.ap.connect(log.analysis_export);
        mon.ap.connect(cov.analysis_export);
    endfunction: connect_phase
endclass: my_env