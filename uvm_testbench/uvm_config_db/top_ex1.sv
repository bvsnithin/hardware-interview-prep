/***************
Command xrun -sv top_ex1.sv -uvm -access +rwc +UVM_CONFIG_DB_TRACE

What's uvm_config_db?
* Config Database as the name suggests is a database to store the configuration for uvm components. 
* It facilitates the communication/information sharing across a UVM testbench. 
* uvm_config_db is a parameterized class and it the child class of uvm_resource_db
* resource_db is a more general purpose database unlike config db - which is a hierarchy based configuration. Whereas resource_db is not dependent on hierarchy but rather
a generic named resource repository. 

set(context, instance_name, key, value)
get(context, instance_name, key, value)
Key and Value explain themselves.
Context -> This tells uvm from where to start interpreting the instance. 
"this" -> Start searching from the component that you are in. If it's called from component my_test, then start from here. 
"root" -> Start searching from the absolute top/root of the hierarchy. 

Instance_name -> This tells where should the configuration be applied. 
env -> Configuration only applies to env, 
env.agent -> Configuration applies only to agent, 
env.*-> Every component below env will have the config applied

set(this, "env", "mode", 1); -> Starting from this test(if this set is called in a test class), go to env and set mode to 1
set(this, "*", "mode", 1); -> Starting from this test, every descendent can access mode
set(null, "uvm_test_top.env", "mode", 1); -> Start searching from root and apply the config to only uvm_test_top.env

get(this, "", "WIDTH", width); -> "this" start searching from the the current component. "" -> Empty quotes mean, are there any configurations for me?
So basically, this get method searches the current component config databse to see if there is any key "WIDTH" set for the current instance. 
***************/ 
import uvm_pkg::*;
`include "uvm_macros.svh"

module top_ex1;
    initial begin
        run_test("my_test");
    end
endmodule

//--------------------------------------------------------------------------------------------------------------//

class my_env extends uvm_env;

    `uvm_component_utils(my_env)

    string capital;

    function new(string name="", uvm_component parent=null);
        super.new(name, parent);
        `uvm_info("[ENV]","Inside the constructor of my_env",UVM_LOW)
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(uvm_config_db#(string)::get(this,"","What is the capital of Japan?",capital)) begin
            `uvm_info("[ENV]",$sformatf("Capital is: %s:", capital), UVM_LOW)
        end
        else begin
            `uvm_fatal("[ENV]", "Config DB call failed")
        end
    endfunction: build_phase

endclass: my_env

//--------------------------------------------------------------------------------------------------------------//

class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_env env; //Handle to my_env

    function new(string name="", uvm_component parent=null);
        super.new(name, parent);
        `uvm_info("[TEST]","Inside the constructor of my_test",UVM_LOW)
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        // Wait, where is uvm_top coming from? Well, uvm_top is a global handle to the singleton uvm_root instance(cool fact - uvm_root is a singleton class). uvm_top is automatically available once we import uvm_pkg::*
        // Also, print_topology is a method of uvm_root
        uvm_top.print_topology();
        uvm_top.print_topology(uvm_default_tree_printer);
    endfunction: end_of_elaboration_phase

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = my_env::type_id::create("env", this);
        uvm_config_db#(string)::set(this,"env","What is the capital of Japan?","Tokyo");
    endfunction: build_phase

endclass: my_test

