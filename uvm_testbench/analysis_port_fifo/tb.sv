`include <uvm_macros.svh>
import uvm_pkg::*;

class producer extends uvm_component;

    `uvm_component_utils(producer)

    uvm_analysis_port#(int) ap;
    int val = 0;

    function new(string name="", uvm_component parent);
        super.new(name,parent);
        ap = new("ap", this);
    endfunction: new

    virtual task run_phase(uvm_phase phase);
        repeat(10) ap.write(val++);
    endtask: run_phase

endclass: producer

class consumer extends uvm_component;

    `uvm_component_utils(consumer)

    uvm_tlm_analysis_fifo #(int) analysis_fifo;
    int golden_reference_model[10];

    int num_matches = 0;
    int mis_matches = 0;

    function new(string name="", uvm_component parent);
        super.new(name,parent);
        analysis_fifo = new("analysis_fifo", this);
        foreach(golden_reference_model[i]) begin
            golden_reference_model[i] = i;
        end
    endfunction: new

    virtual task run_phase(uvm_phase phase);
        int received_data;
        for(int i = 0;i<10;i++) begin
            analysis_fifo.get(received_data);
            if(received_data == golden_reference_model[i]) begin
                num_matches++;
                `uvm_info("CONSUMER", $sformatf("::::::: Recevied == Expected Received = %0d, Expected = %0d :::::::", received_data, golden_reference_model[i]),UVM_LOW)
            end
            else begin
                mis_matches++;
                `uvm_error("CONSUMER", $sformatf("::::::: Recevied != Expected Received = %0d, Expected = %0d :::::::", received_data, golden_reference_model[i]))
            end
        end
    endtask: run_phase

    virtual function void report_phase(uvm_phase phase);
        `uvm_info("CONSUMER", $sformatf("------- MATCHES = %0d, MISMATCHES = %0d)", num_matches, mis_matches), UVM_LOW)
    endfunction: report_phase
endclass: consumer

class analysis_fifo_test extends uvm_test;

    `uvm_component_utils(analysis_fifo_test)

    producer prod;
    consumer cons;

    function new(string name = "", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        prod = producer::type_id::create("prod",this);
        cons = consumer::type_id::create("cons",this);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        prod.ap.connect(cons.analysis_fifo.analysis_export);
    endfunction: connect_phase

    virtual task run_phase(uvm_phase phase);

    endtask: run_phase

endclass: analysis_fifo_test

module test;
    initial begin
        run_test("analysis_fifo_test");
    end
endmodule