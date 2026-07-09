`include<uvm_macros.svh>
import uvm_pkg::*;

typedef enum logic {READ, WRITE} rw;
typedef enum logic {OKAY, ERROR} resp_t;

class my_item extends uvm_sequence_item;

    rand bit[7:0] addr;
    rand bit[31:0] data;
    rand rw operation;
    rand bit[3:0] pstrb;
    rand bit[2:0] pprot;
    rand int delay;
    rand resp_t resp;

    `uvm_object_utils_begin(my_item)
        `uvm_field_int(addr, UVM_DEFAULT)
        `uvm_field_int(data, UVM_DEFAULT)
        `uvm_field_enum(rw, operation, UVM_DEFAULT)
        `uvm_field_int(pstrb, UVM_DEFAULT)
        `uvm_field_int(pprot, UVM_DEFAULT)
        `uvm_field_int(delay, UVM_DEFAULT)
        `uvm_field_enum(resp_t, resp, UVM_DEFAULT)
    `uvm_object_utils_end

    function new(string name="");
        super.new(name);
    endfunction

    constraint c_delay{
        delay inside{[0:10]};
    }

    
endclass: my_item

class my_coverage extends uvm_subscriber#(my_item);

    `uvm_component_utils(my_coverage)

    my_item tr;

    covergroup cg;
        option.per_instance = 1;
        cp_rw: coverpoint tr.operation{
            bins bin_read = {READ};
            bins bin_write = {WRITE};
        }

        cp_addr: coverpoint tr.addr{
            bins bin_addr[4] = {[8'h00:8'hFF]};
        }

        cp_pstrb: coverpoint tr.pstrb{
            bins bin_all_zeroes = {4'b0000};
            bins bin_all_ones = {4'b1111};
            bins bin_partial = {[4'b0001:4'b1110]};
        }

        cp_pprot: coverpoint tr.pprot{
            bins bin_per_value[] = {[3'd0:3'd7]};
        }

        cp_resp: coverpoint tr.resp{
            bins bin_okay = {OKAY};
            bins bin_erro = {ERROR};
        }

        cp_delay: coverpoint tr.delay{
            bins zero_back_to_back = (0 => 0);
            bins normal_delay = {[1:2]};
            bins medium_delay = {[3:5]};
            bins big_delay = {[6:10]};
        }  

        x_rw_resp: cross cp_rw, cp_resp;
        x_rw_pstrb: cross cp_rw, cp_pstrb;
        x_addr_rw: cross cp_addr, cp_rw;
    endgroup

    function new(string name = "", uvm_component parent);
        super.new(name,parent);
        cg = new();
    endfunction: new

    virtual function void write(my_item t);
        tr = t;
        cg.sample();
    endfunction: write

endclass: my_coverage

class my_producer extends uvm_component;

    `uvm_component_utils(my_producer)

    uvm_analysis_port#(my_item) ap;

    function new(string name="", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        repeat(20) begin
            my_item tr = my_item::type_id::create("tr", this);
            assert (tr.randomize());
            ap.write(tr);
            tr.print();
        end
    endtask: run_phase
endclass: my_producer

class my_env extends uvm_env;
    `uvm_component_utils(my_env)

    my_producer producer;
    my_coverage cov;

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        producer = my_producer::type_id::create("producer", this);
        cov = my_coverage::type_id::create("cov", this);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        producer.ap.connect(cov.analysis_export);
    endfunction: connect_phase


endclass: my_env

class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    my_env env;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = my_env::type_id::create("env", this);
    endfunction: build_phase

    

endclass: my_test

module test;
    initial begin
        run_test("my_test");
    end
endmodule