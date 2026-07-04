/**********************
This is an example of how monitor and scoreboard can be build for a simple adder. 
We extend the testbench from uvm_config_db/top_ex2.sv file
**********************/

`include <uvm_macros.svh>
import uvm_pkg::*;

interface adder_if(input logic clk);
    logic rst_n; 
    logic[7:0] a;
    logic[7:0] b;
    logic[8:0] sum;
endinterface

module adder_dut(
    input logic clk,
    input logic rst_n,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [8:0] sum
);
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sum <= '0;
        end
        else begin
            sum <= a+b;
        end
    end
endmodule

module uvm_tb;

    bit clk;

    initial clk = 0;
    always #5 clk = ~clk;

    adder_if inf(clk);

    adder_dut dut(
        .clk (clk),
        .rst_n (inf.rst_n),
        .a (inf.a),
        .b (inf.b),
        .sum (inf.sum)
    );

    initial begin
        uvm_config_db#(virtual adder_if)::set(null,"*","vif",inf);
        run_test("my_test");
    end
endmodule

/************ UVM TESTBENCH ***************/

class my_item extends uvm_sequence_item;

    rand logic[7:0] a;
    rand logic[7:0] b;
    logic [8:0] sum;

    `uvm_object_utils_begin(my_item)
        `uvm_field_int(a, UVM_PRINT)
        `uvm_field_int(b,UVM_PRINT)
        `uvm_field_int(sum, UVM_PRINT)
    `uvm_object_utils_end

    function new(string name = "");
        super.new(name);
    endfunction: new

    constraint c_a_and_b_dist{
        a dist {
            [8'h00:8'hAA]:=50,
            [8'hAB:8'hFF]:=50
        };

        b dist {
            [8'h00:8'hBB]:=80,
            [8'hBC:8'hFF]:=20
        };
    }

endclass: my_item


//::::::::::::::::::::::::: DRIVER ::::::::::::::::::::::::://

class my_driver extends uvm_driver#(my_item);

    `uvm_component_utils(my_driver)

    virtual adder_if vif;

    int count = 0;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("DRIVER","====== Driver Constructor Called ====== ",UVM_INFO)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(uvm_config_db#(virtual adder_if)::get(this,"","vif",vif)) begin
            `uvm_info("DRV","** Driver can access the virtual interface **", UVM_INFO)
        end
        else `uvm_error("DRV","=== Driver Cannot Access the virtual interface")
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        // Initial condition 
        vif.rst_n = 0;
        vif.a = 0;
        vif.b = 0;

        repeat(2) @(posedge vif.clk);
        vif.rst_n = 1;

        forever begin
            seq_item_port.get_next_item(req);
            // Converted object level attributes to pin leve
            vif.a <= req.a;
            vif.b <= req.b;
            @(posedge vif.clk);
            seq_item_port.item_done();
            count++;
        end
    endtask: run_phase

    virtual function void report_phase(uvm_phase phase);
        `uvm_info("DRV",$sformatf(":::::: Sent %0d packets ::::::", count),UVM_LOW);
    endfunction: report_phase
endclass: my_driver

//::::::::::::::::::::::::: MONITOR ::::::::::::::::::::::::://

class my_monitor extends uvm_monitor;

    `uvm_component_utils(my_monitor)

    uvm_analysis_port#(my_item) ap;

    virtual adder_if vif;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("MONITOR","====== Monitor Constructor Called ====== ",UVM_INFO)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(uvm_config_db#(virtual adder_if)::get(this,"","vif",vif)) begin
            `uvm_info("MONITOR","** Monitor can access the virtual interface **", UVM_INFO)
        end
        else `uvm_error("MONITOR","=== Monitor Cannot Access the virtual interface")
        ap = new("ap",this);
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        //Store the values obsered here    
        logic [7:0] captured_a, captured_b;

        //Wait till reset is removed
        @(posedge vif.rst_n);

        forever begin
            my_item txn;
            //On posedge capture the values of a and b
            @(posedge vif.clk);
            captured_a = vif.a;
            captured_b = vif.b;
            
            @(posedge vif.clk);
            txn = my_item::type_id::create("txn");
            txn.a = captured_a;
            txn.b = captured_b;
            txn.sum = vif.sum;

            `uvm_info("MONITOR",$sformatf("Observed a = %0d, b = %0d, sum = %0d", txn.a, txn.b, txn.sum),UVM_LOW);
            ap.write(txn);
        end
    endtask: run_phase

endclass: my_monitor

//::::::::::::::::::::::::: SCOREBOARD ::::::::::::::::::::::::://

class my_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(my_scoreboard)

    uvm_analysis_imp#(my_item, my_scoreboard) analysis_imp;
    int match = 0;
    int mis_match = 0;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("SCB","====== Scoreboard Constructor Called ====== ",UVM_INFO)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        analysis_imp = new("analysis_imp", this);
    endfunction: build_phase

    virtual function void write(my_item txn);
        logic [8:0] expected_sum = txn.a + txn.b;
        if(expected_sum == txn.sum) begin
            match++;
            `uvm_info("SCB",$sformatf("Observed == Expected, Observed Sum = %0d, Expected Sum = %0d", txn.sum, expected_sum),UVM_LOW);
        end
        else begin
            mis_match++;
            `uvm_error("SCB",$sformatf("****** Observed != Expected, Observed Sum = %0d, Expected Sum = %0d ******", txn.sum, expected_sum));
        end
    endfunction: write

    virtual function void report_phase(uvm_phase phase);
        `uvm_info("SCB",$sformatf("Total Matches = %0d, Total Mismatches = %0d", match, mis_match),UVM_LOW);
    endfunction: report_phase

endclass: my_scoreboard


//::::::::::::::::::::::::: SEQUENCE ::::::::::::::::::::::::://

class my_seq extends uvm_sequence#(my_item);

    `uvm_object_utils(my_seq)

    function new(string name = "");
        super.new(name);
        `uvm_info("SEQ","====== Sequence Constructor Called ====== ",UVM_INFO)
    endfunction: new

    virtual task body();
        `uvm_info("SEQ","-- Sequence body --",UVM_LOW)

        repeat(10) begin
            my_item req = my_item::type_id::create("req");
            start_item(req);
            assert(req.randomize()); 
            finish_item(req);
        end
    endtask

endclass: my_seq

//::::::::::::::::::::::::: AGENT ::::::::::::::::::::::::://

class my_agent extends uvm_agent;

    my_driver driver;
    my_monitor monitor;
    uvm_sequencer#(my_item) sequencer;

    `uvm_component_utils(my_agent)

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("AGENT","====== Agent Constructor Called ====== ",UVM_INFO)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        monitor = my_monitor::type_id::create("monitor", this);
        sequencer =uvm_sequencer#(my_item)::type_id::create("sequencer", this);
        driver = my_driver::type_id::create("driver", this);
    endfunction:build_phase


    virtual function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction: connect_phase

endclass: my_agent

//::::::::::::::::::::::::: ENV ::::::::::::::::::::::::://

class my_env extends uvm_env;

    `uvm_component_utils(my_env)

    my_agent agent;
    my_scoreboard scoreboard;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("ENV","====== Env Constructor Called ====== ",UVM_INFO)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = my_agent::type_id::create("agent", this);
        scoreboard = my_scoreboard::type_id::create("scoreboard", this);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        agent.monitor.ap.connect(scoreboard.analysis_imp);
    endfunction

endclass: my_env

//::::::::::::::::::::::::: TEST ::::::::::::::::::::::::://

class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_env env;
    my_seq seq;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("TEST","====== Test Constructor Called ====== ",UVM_INFO)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = my_env::type_id::create("env", this);
        seq = my_seq::type_id::create("seq", this);
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);    
        phase.raise_objection(this);
        seq.start(env.agent.sequencer);
        #100;
        phase.drop_objection(this);
    endtask: run_phase

endclass: my_test