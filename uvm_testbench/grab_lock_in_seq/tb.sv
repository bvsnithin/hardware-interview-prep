/*******************
When there are multiple sequences running in the testbench on a single sequencer, how can one sequence get full/exclusive access to the sequencer?

- By using lock() and grab() methods

- lock() locks the sequencer to be used by a particular sequence only. However, if the sequencer is running a particular sequence - lock() waits for that transaction to 
  complete and also waits for it's turn in the sequencer's arbitration queue.

- Once lock() is acquired, no other sequence can obtain a grant until the locking sequence calls unlock()

- grab() does not immediately take control of the sequencer.
  It bypasses normal arbitration requests and gets priority at the next arbitration point.
  It still waits for the currently active transaction to complete.

- lock() waits its turn according to the sequencer's arbitration policy before becoming exclusive.

- grab() is inserted ahead of other waiting requests, giving it the highest priority at the next arbitration point. However, it still waits for the currently 
  executing transaction to finish before taking control.

 Sequencer has various arbitaration modes. 
  UVM_SEQ_ARB_FIFO - First in First Out. 
  UVM_SEQ_ARB_WEIGHTED - Arbitration based on sequence priority
  UVM_SEQ_ARB_RANDOM - Randomly selects a sequence from all the requesting sequences
  UVM_SEQ_ARB_STRICT_FIFO - Mix of weighted priority and FIFO. If the priorities are same, then then tiebreaker is the FIFO
  UVM_SEQ_ARB_STRICT_RANDOM - Here tiebreaker is random when same priorities exist
  UVM_SEQ_ARB_USER - User defined priority logic. 
*******************/


`include "uvm_macros.svh"
import uvm_pkg::*;

// ********** Sequence Item **********

class my_item extends uvm_sequence_item;
  rand bit [7:0] data;

  `uvm_object_utils(my_item)

  function new(string name="my_item");
    super.new(name);
  endfunction
endclass

// ********** Driver **********

class my_driver extends uvm_driver #(my_item);
  `uvm_component_utils(my_driver)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual task run_phase(uvm_phase phase);

    forever begin
      seq_item_port.get_next_item(req);

      `uvm_info(
        "DRIVER",
        $sformatf("Received item from %s at %0t",req.get_full_name(),$time),
        UVM_LOW
        )

      #5;

      seq_item_port.item_done();
    end

  endtask

endclass

// ********** LOCK SEQUENCE **********

class lock_seq extends uvm_sequence #(my_item);

  `uvm_object_utils(lock_seq)

  function new(string name="lock_seq");
    super.new(name);
  endfunction

  virtual task body();

    my_item req;

    #1;

    // ********** Two items before lock **********
    repeat(2) begin
      req = my_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end

    lock();

    `uvm_info("LOCK_SEQ","LOCK ACQUIRED",UVM_LOW)

    repeat(5) begin
      req = my_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end

    unlock();

    `uvm_info("LOCK_SEQ","LOCK RELEASED",UVM_LOW)

  endtask

endclass

// ********** GRAB SEQUENCE **********

class grab_seq extends uvm_sequence #(my_item);

  `uvm_object_utils(grab_seq)

  function new(string name="grab_seq");
    super.new(name);
  endfunction

  virtual task body();

    my_item req;

    #2;

    grab();

    `uvm_info("GRAB_SEQ","GRAB ACQUIRED",UVM_LOW)

    repeat(5) begin
      req = my_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end

    ungrab();

    `uvm_info("GRAB_SEQ","GRAB RELEASED",UVM_LOW)

  endtask

endclass

// ********** NORMAL SEQUENCE **********

class normal_seq extends uvm_sequence #(my_item);

  `uvm_object_utils(normal_seq)

  function new(string name="normal_seq");
    super.new(name);
  endfunction

  virtual task body();

    my_item req;

    repeat(10) begin
      req = my_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end

  endtask

endclass

class normal_seq_1 extends uvm_sequence #(my_item);

  `uvm_object_utils(normal_seq_1)

  function new(string name="normal_seq_1");
    super.new(name);
  endfunction

  virtual task body();

    my_item req;

    repeat(10) begin
      req = my_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end

  endtask

endclass

// ********** TEST **********

class my_test extends uvm_test;

  `uvm_component_utils(my_test)

  uvm_sequencer #(my_item) sqr;
  my_driver drv;

  lock_seq   l_seq;
  grab_seq   g_seq;
  normal_seq n_seq;
  normal_seq_1 n_1_seq;

  function new(string name="my_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);

    sqr   = uvm_sequencer#(my_item)::type_id::create("sqr",this);
    drv   = my_driver::type_id::create("drv",this);

    l_seq = lock_seq::type_id::create("l_seq");
    g_seq = grab_seq::type_id::create("g_seq");
    n_seq = normal_seq::type_id::create("n_seq");
    n_1_seq = normal_seq_1::type_id::create("n_1_seq");

  endfunction

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction

  virtual task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    fork
      n_seq.start(sqr);
      l_seq.start(sqr);
      g_seq.start(sqr);
      n_1_seq.start(sqr,null,1000);
    join

    phase.drop_objection(this);

  endtask

endclass


module test;

  initial
    run_test("my_test");

endmodule