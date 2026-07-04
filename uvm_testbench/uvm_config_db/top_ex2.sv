/********************
This is an example of monitors and drivers use the virtual interface 

command - xrun -sv top_ex2.sv -uvm -access +rwc +UVM_CONFIG_DB_TRACE
*******************/

`include "uvm_macros.svh"
import uvm_pkg::*;

interface adder_if;
    
    logic clk;
    logic rst_n;
    logic [7:0] a;
    logic [7:0] b;
    logic [8:0] sum;
    
endinterface

module top_ex2;
    
    adder_if intf();

    initial begin
        uvm_config_db#(virtual adder_if)::set(null,"*","vif",intf);
        run_test("my_test");
    end

endmodule

//----------------------------------------------------------------------------------------------------------/

class my_monitor extends uvm_monitor;

    `uvm_component_utils(my_monitor)

    virtual adder_if vif;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("MON","Inside the UVM Monitor class", UVM_LOW)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif)) begin
            `uvm_info("MON","-------- I can access the virtual interface --------", UVM_LOW)
        end
        else `uvm_error("MON", "-------- I cannot access the virtual interface, check the set function --------")
    endfunction: build_phase

endclass: my_monitor

//----------------------------------------------------------------------------------------------------------/

class my_driver extends uvm_driver;

    `uvm_component_utils(my_driver)

    virtual adder_if vif;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("DRV", "Inside the UVM Driver Constructor", UVM_LOW)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif)) begin
            `uvm_info("DRV","-------- I can access the virtual interface --------", UVM_LOW)
        end
        else `uvm_error("DRV", "-------- I cannot access the virtual interface, check the set function --------")
    endfunction: build_phase

endclass: my_driver

//----------------------------------------------------------------------------------------------------------/

class my_agent extends uvm_agent;

    `uvm_component_utils(my_agent)

    my_monitor monitor;
    my_driver driver;
    uvm_active_passive_enum is_active;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("AGENT","Inside the UVM Agent Constructor", UVM_LOW)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        if(uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active)) begin
            `uvm_info("AGENT","-------- Agent is active, Creating both monitor and driver --------", UVM_LOW)
            monitor = my_monitor::type_id::create("monitor", this);
            driver = my_driver::type_id::create("driver", this);
        end
        else begin
            `uvm_info("AGENT","-------- Agent is passive, Creating only monitor --------", UVM_LOW)
            monitor = my_monitor::type_id::create("monitor", this);
        end


    endfunction: build_phase

endclass: my_agent

//----------------------------------------------------------------------------------------------------------/

class my_env extends uvm_env;

    `uvm_component_utils(my_env)

    my_agent agent;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("ENV","Inside the UVM Env Constructor", UVM_LOW)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = my_agent::type_id::create("agent", this);
    endfunction: build_phase

endclass: my_env

//----------------------------------------------------------------------------------------------------------/
class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_env env;
    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        `uvm_info("TEST","Inside the UVM Test Constructor", UVM_LOW)
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        env = my_env::type_id::create("env", this);
        uvm_config_db#(uvm_active_passive_enum)::set(this,"env.*","is_active", UVM_ACTIVE);
    endfunction: build_phase

endclass: my_test


