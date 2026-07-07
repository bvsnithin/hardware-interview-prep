/**********************
Below are possible interview questions related to objections and answers for them

::::::::::::::: What is Objection? :::::::::::::::
- Objection is the mechanism that tells UVM testbench whether the simulation should keep running or it can finish. 
- Simply put, it is a "dont stop yet" signal, wherein a component raises an objection when it has work to do and drops it when the work is completed. 
- If an objection is raised, the simulation only ends after it is dropped.
- A simulation continues as long as atleast there is one objection that is active and stops only when all the objections are dropped. Or else simulation hangs. 

::::::::::::::: Why we need Objection? :::::::::::::::
UVM has two types of phases 1) Function Phases 2) Task Phases
- Function phases like build_phase, connect_phase dont need any simulation time. They return immediately. 
  Also, they execute either top-down(build phase) or bottom-up(connect phase)
- Task phases like run_phase, main_phase, reset_phase, shutdown_phase consume simulation time. 
  Run phases execute parallely. That means all component's run_phase starts at the same simulation time. 
- Suppose driver needs 1200ns, monitor needs 1500ns, and sequence only needs 1000ns. The run_phase returns after sequence completes execution because a sequence is called 
  inside the test component's run phase. This begs the question - should the simulation stop now at 1000ns because run_phase of test component returned? However, the monitor and driver
  are still running. 
- Without objection, uvm has no idea when the run_phase should stop. 

::::::::::::::: Why not simply wait until all run phases return? :::::::::::::::
- Monitors, Drivers, and sometimes scoreboards in UVM have a run phase with forever loop inside them. This means that - UVM will not be able to return from the run phase 
  if it keeps on waiting for all run phases to end

::::::::::::::: Why happens internally when we raise an objection? :::::::::::::::
- Objection is simply a counter. 
- raise_objection increases the counter to 1
- drop_objection decreases the counter to 0
- When objection count is 0, simulation can finish

::::::::::::::: Why cant we simply use a delay? :::::::::::::::
- Interviewer follow up would be - "Why cant we just use a delay after starting the sequence?"
- But how can we predict how much delay will be needed. 

*********************/
`include<uvm_macros.svh>
import uvm_pkg::*;

module objection_tb;
    initial begin
        run_test("my_test");
    end
endmodule


/* Component A: raises objection once and drops once */
class component_a extends uvm_component;

    `uvm_component_utils(component_a)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this, "component_a raises objection");
        `uvm_info(
            "COMP A",
            $sformatf("Raised objection at time %0t | Active Objections = %0d", $time, phase.phase_done.get_objection_total(this)), 
            UVM_LOW
        )
        #10;
        phase.drop_objection(this);
        `uvm_info(
            "COMP A",
            $sformatf("Dropped objection at time %0t | Active Objections = %0d", $time, phase.phase_done.get_objection_total(this)),
            UVM_LOW
        )
    endtask
endclass: component_a

class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    component_a comp_a;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        comp_a = component_a::type_id::create("comp_a", this);
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        `uvm_info(
            "TEST",
            "------------------------ Inside the run phase of TEST class ------------------------",
            UVM_LOW
        )
    endtask: run_phase
endclass: my_test