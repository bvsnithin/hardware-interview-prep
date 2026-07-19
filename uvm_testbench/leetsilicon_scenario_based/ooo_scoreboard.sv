/************ Design Out-of-Order Transaction Matching Scoreboard Using Transaction IDs ***********/
/*
Implement UVM scoreboard that handles out-of-order transaction arrival from multiple sources (predictor and monitor). 
Transactions matched by unique transaction_id field. 
Support scenarios where expected transaction arrives before/after actual, or transactions arrive with arbitrary ordering. 
Report mismatches and manage memory by removing matched pairs.

Requirements
▸ CLASS STRUCTURE: Extend uvm_scoreboard base class. Implement two uvm_analysis_imp ports (or separate imp_expected and imp_actual).
▸ STORAGE: Maintain two associative arrays: 
  (1) expected_q[transaction_id] for expected transactions, 
  (2) actual_q[transaction_id] for actual transactions. Use transaction_id as key.
▸ TRANSACTION ID: Each transaction has unique transaction_id field (int or similar). Used as key for matching.
▸ WRITE METHODS: Implement write_expected(T trans) and write_actual(T trans) analysis imp callback functions.
▸ MATCHING LOGIC (Expected Arrival): On write_expected: Check if actual_q[trans.id] exists. If yes: compare, report pass/fail, delete from actual_q. If no: store in expected_q[trans.id].
▸ MATCHING LOGIC (Actual Arrival): On write_actual: Check if expected_q[trans.id] exists. If yes: compare, report pass/fail, delete from expected_q. If no: store in actual_q[trans.id].
▸ COMPARISON: Use transaction compare() method or field-by-field comparison. If mismatch: `uvm_error("MISMATCH", message).
▸ MEMORY MANAGEMENT: Delete entries from associative arrays after successful match to prevent memory leak.
▸ END-OF-TEST CHECK: In check_phase or final_phase, verify both expected_q and actual_q are empty. Report unmatched transactions as errors.
*/


`include<uvm_macros.svh>
import uvm_pkg::*;

//Dummy/Mock for lint checking
class my_transaction extends uvm_sequence_item;
    `uvm_object_utils(my_transaction)

    int transaction_id;

    function new(string name = "");
        super.new(name);
    endfunction: new
endclass: my_transaction

//Create declarations for two analysis_imp ports
`uvm_analysis_imp_decl(_expected)
`uvm_analysis_imp_decl(_actual)

class ooo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(ooo_scoreboard)

  // TODO: Declare storage for expected and actual transactions.

  // Expected transactions come from predictor
  uvm_analysis_imp_expected#(my_transaction, ooo_scoreboard) expected;
  // Actual transactions come from monitor
  uvm_analysis_imp_actual#(my_transaction, ooo_scoreboard) actual;

  //Creating associative arrays, key is the transaction_id, value is the transaction itself
  my_transaction expected_q[int];
  my_transaction actual_q[int]; 

  function new(string name = "ooo_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    expected = new("expected", this);
    actual = new("actual", this);
  endfunction: build_phase

  // TODO: Add analysis implementation methods for expected and actual streams.

  function void write_expected(my_transaction t);
    if(actual_q.exists(t.transaction_id)) begin
        // Compare the actual 
        bit equal = actual_q[t.transaction_id].compare(t);
        if(equal == 1) begin
            `uvm_info(
                "SCB MATCH",
                $sformatf("Predictor and Monitor values match! for transaction_id = %0d", t.transaction_id),
                UVM_LOW
            )
        end
        else begin
            `uvm_error(
                "SCB MIS-MATCH",
                $sformatf("Predictor and Monitor values don't match! for transaction_id = %0d", t.transaction_id)
            )
        end
        actual_q.delete(t.transaction_id);
    end
    else begin
        expected_q[t.transaction_id] = t;
    end
  endfunction: write_expected

  function void write_actual(my_transaction t);
    if(expected_q.exists(t.transaction_id)) begin
        //Compare the expected with actual
        bit equal = expected_q[t.transaction_id].compare(t);

        if(equal == 1) begin
            `uvm_info(
                "SCB MATCH",
                $sformatf("Predictor and Monitor values match! for transaction_id = %0d", t.transaction_id),
                UVM_LOW
            )
        end
        else begin
            `uvm_error(
                "SCB MIS-MATCH",
                $sformatf("Predictor and Monitor values don't match! for transaction_id = %0d", t.transaction_id)
            )
        end

        expected_q.delete(t.transaction_id);
    end
    else begin
        actual_q[t.transaction_id] = t;
    end
  endfunction: write_actual

  function void check_phase(uvm_phase phase);
    // TODO: Compare expected and actual transactions when both are available.
    if(expected_q.size()>0 || actual_q.size()>0) begin
        `uvm_error(
            "SCB MIS-MATCH",
            "Some values are still present in the associative arrays - SCB failed"
        )
    end
    else begin
        `uvm_info(
                "SCB MATCH",
                "No Unmatched transactions left in the arrays",
                UVM_LOW
            )
    end

  endfunction
endclass
