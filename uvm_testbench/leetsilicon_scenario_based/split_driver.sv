// Split-beat driver starter
/************************************************
Design UVM driver for 32-bit data interface that receives 64-bit transactions from sequencer and splits each into two 32-bit beats. 
First beat transmits lower 32 bits [31:0], second beat transmits upper 32 bits [63:32]. Handle ready/valid handshake with backpressure. 
Support configurable inter-beat gap. Call item_done() only after both beats transmitted.
Requirements

▸   CLASS STRUCTURE: Extend uvm_driver#(my_transaction_64bit). Transaction has 64-bit data field.
▸   INTERFACE: 32-bit data bus, valid signal (driver asserts), ready signal (DUT asserts for backpressure).
▸   BEAT SPLITTING: For each 64-bit transaction:
        (1) First beat: drive data[31:0], assert valid, 
        (2) Wait for ready, 
        (3) Second beat: drive data[63:32], assert valid, (4) Wait for ready.
▸   BACKPRESSURE: Before each beat, wait for ready signal. If ready=0, hold valid and data until ready=1.
▸   INTER-BEAT GAP (Optional): Configurable cycles between beats. If gap=0, back-to-back. If gap>0, deassert valid for gap cycles.
▸   ITEM DONE: Call seq_item_port.item_done() only after second beat completes (ready seen for second beat).
▸   TRANSACTION INTEGRITY: Both beats belong to same transaction. If transaction has ID field, maintain same ID for both beats (if ID sent on bus).
▸   RESET HANDLING: If reset asserts mid-transaction, abort current transaction and restart.
************************************************/


`include<uvm_macros.svh>
import uvm_pkg::*;

//Mock Representation of my_transaction
class my_transaction extends uvm_sequence_item;
    logic [63:0] data;
    logic gap;
endclass: my_transaction

class split_beat_driver extends uvm_driver #(my_transaction);
  `uvm_component_utils(split_beat_driver)

  virtual split_bus_if vif;

  function new(string name = "split_beat_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(uvm_config_db#(virtual split_bus_if)::get(null,"","vif",vif)) begin
        `uvm_info(
            "DRIVER",
            "Virtual Interface is available!",
            UVM_LOW
        )
    end
    else begin
        `uvm_error(
            "DRIVER",
            "Virtual Interface is not available"
        )
    end
  endfunction

  task run_phase(uvm_phase phase);
    // reset_signals();
    my_transaction req;
    // To monitor reset, we wil use 2 parallel process
    // 1. Polls the req from sequencer and driver to dut
    // 2. Monitors reset. 
    // Since parallel process 1 is a forever loop, we will only disable/exit fork if there is a reset
    forever begin
        fork
            begin: drive_to_dut
                forever begin
                    seq_item_port.get_next_item(req);
                    send_to_dut(req);
                    seq_item_port.item_done();
                    req = null; //Clear the req
                end
            end

            begin: monitor_reset
                // If reset is seen, this parallel process ends, ending the fork
                @(posedge vif.rst);
                `uvm_info(
                    "DRIVER-RUN PHASE",
                    "Reset observed, exiting the current transaction",
                    UVM_LOW
                )
            end
        join_any
        disable fork;
        reset_signals();

        // Complete sequencer handshake because we exited midway during the reset
        if(req!=null) begin
            seq_item_port.item_done();
        end

        // Restart loop after reset is removed
        wait(vif.rst == 0);
    end
    
  endtask

  task reset_signals();
    vif.valid <= 0;
    vif.data <= 32'h0;
  endtask

  task send_to_dut(my_transaction req);
    bit[31:0] lower_bits = req.data[31:0];
    bit[31:0] upper_bits = req.data[63:32];

    //Assert valid signal and place the lower bits on the bus
    vif.data <= lower_bits;
    vif.valid <= 1;

    //Wait till ready is seen
    do begin
        @(posedge vif.clk);
    end while(!vif.ready);

    //After ready is high, data is sampled by the slave. 

    // Handle inter beat gap
    if(req.gap > 0) begin
        //De-assert valid during the inter-beat gap
        vif.valid <= 0;
        vif.data <= 32'h0;
        repeat(req.gap) begin
            @(posedge vif.clk);
        end
    end
    else begin
        @(posedge vif.clk);
    end

    //Drive the upper bits
    vif.data <= upper_bits;
    vif.valid <= 1;

    // Wait till ready is seen
    do begin
        @(posedge vif.clk);
    end while(!vif.ready);

    // Deassert valid after transaction is completed
    vif.valid <= 0;
    vif.data <= 32'h0;
  endtask
endclass
