`include "uvm_macros.svh"
import uvm_pkg::*;

class router_packet extends uvm_sequence_item;
  
  rand bit [7:0]  addr;
  rand bit [31:0] payload;
  rand bit [7:0]  crc;

  `uvm_object_utils_begin(router_packet)
    `uvm_field_int(addr,    UVM_DEFAULT)
    `uvm_field_int(payload, UVM_DEFAULT)
    `uvm_field_int(crc,     UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "router_packet");
    super.new(name);
  endfunction

  function void post_randomize();
    crc = addr ^ payload[7:0]; 
  endfunction

endclass

class corrupt_packet extends router_packet;

    rand bit [7:0] corrupt_crc;

  `uvm_object_utils_begin(corrupt_packet)
    `uvm_field_int(corrupt_crc, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name="corrupt_packet");
    super.new(name);
  endfunction: new

  function void post_randomize();
    super.post_randomize();
    if(corrupt_crc) begin
        crc = ~crc;
    end
  endfunction: post_randomize
endclass

class my_sequence extends uvm_sequence#(router_packet);

    `uvm_object_utils(my_sequence)

    function new(string name = "my_sequence");
        super.new(name);
    endfunction: new

    virtual task body();
        repeat(3) begin
            req = router_packet::type_id::create("req");

            assert(req.randomize()) else `uvm_error("SEQUENCE", "Assertion failed!");

            $display("Type Name: %s", req.get_type_name());  //This will give us the corrup packet name. Get type name is Dynamic
            $display("Type Handle: %p", req.get_type());     // This will give the router packet because get type is static
            req.print();
        end
    endtask: body
endclass: my_sequence

class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_sequence seq;
    uvm_sequencer#(router_packet) seqr;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        router_packet::type_id::set_type_override(corrupt_packet::type_id::get());
        seq = my_sequence::type_id::create("seq");
        seqr = uvm_sequencer#(router_packet)::type_id::create("seqr",this);
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq.start(seqr);
        #200;
        phase.drop_objection(this);
    endtask: run_phase
    
endclass: my_test

module tb;
    initial begin
        run_test("my_test");
    end
endmodule