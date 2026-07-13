`include<uvm_macros.svh>
import uvm_pkg::*;

module tb_top;
    //Top file should instantiate the dut and the interface

    logic clk;

    initial clk = 0;
    always #5 clk = ~clk;

    stat_intf intf(clk);

    stat_dut dut(
        .clk (intf.clk),
        .rst_n (intf.rst_n),
        .x (intf.x),
        .mean (intf.mean),
        .median (intf.median),
        .count (intf.count),
        .unique_count (intf.unique_count)
    ); 

    initial begin
        uvm_config_db#(virtual stat_intf)::set(null,"*.agent.*","vif",intf);
        `uvm_info(
            "TOP",
            "Interface set inside the config db successfully",
            UVM_LOW
        )
        run_test("my_test");
    end
endmodule

//****************************************  TRANSACTION ITEM ****************************************//

class my_item extends uvm_sequence_item;

    rand logic [7:0] x;
    rand logic rst_n;

    logic signed [7:0] mean;
    logic signed [7:0] median;
    logic [4:0]        count;
    logic [4:0]        unique_count;

    `uvm_object_utils_begin(my_item)
        `uvm_field_int(mean, UVM_PRINT)
        `uvm_field_int(median, UVM_PRINT)
        `uvm_field_int(count, UVM_PRINT)
        `uvm_field_int(unique_count, UVM_PRINT)
        `uvm_field_int(x, UVM_PRINT)
        `uvm_field_int(rst_n, UVM_PRINT)
    `uvm_object_utils_end 


    function new(string name="");
        super.new(name);
    endfunction: new
endclass: my_item

//****************************************  SEQUENCE ****************************************//

//Since we are using parameter my_item into the class definition, UVM will automatically create the handle for us inside the class
class my_sequence extends uvm_sequence#(my_item);
    
    `uvm_object_utils(my_sequence)

    function new(string name = "");
        super.new(name);
    endfunction: new

    virtual task body();
        
        //Total 5 transaction
        //Each transaction has 5 to 10 values
        repeat(5) begin
            int n = $urandom_range(5,10);
            `uvm_do_with(req, {rst_n == 0;});
            repeat(n) begin
                `uvm_do_with(req, {rst_n == 1;});
            end
        end

    endtask: body

endclass: my_sequence

//**************************************** DRIVER ****************************************//

class my_driver extends uvm_driver#(my_item);

    `uvm_component_utils(my_driver)

    //Virtual interface handle
    virtual stat_intf vif;

    function new(string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(uvm_config_db#(virtual stat_intf)::get(this,"","vif",vif)) begin
            `uvm_info(
                "DRV",
                "----------- Virtual Interface available for the driver -----------",
                UVM_LOW
            )
        end
        else begin
            `uvm_error(
                "DRV",
                "----------- Virtual Interface not found for the driver -----------"
            )
        end
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        
        forever begin

           seq_item_port.get_next_item(req);
           @(posedge vif.clk);
           vif.rst_n <= req.rst_n;
           vif.x <= req.x;
           seq_item_port.item_done();

        end
    endtask: run_phase

endclass: my_driver

//**************************************** INPUT MONITOR ****************************************//

class my_monitor_in extends uvm_monitor;

    `uvm_component_utils(my_monitor_in)

    uvm_analysis_port#(my_item) ap_in;

    //Virtual interface handle
    virtual stat_intf vif;

    function new(string name =" ", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_in = new("ap_in",this);
        if(uvm_config_db#(virtual stat_intf)::get(this, "", "vif", vif)) begin
            `uvm_info(
                "MON",
                "----------- Virtual Interface found for the monitor -----------",
                UVM_LOW
            )
        end
        else begin
            `uvm_error(
                "MON",
                "----------- Virtual Interface not found for the monitor -----------"
            )
        end
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        my_item tr;
        forever begin
            tr = my_item::type_id::create("tr");
            @(posedge vif.clk);
            tr.x = vif.x;
            tr.rst_n = vif.rst_n;
            ap_in.write(tr);
        end
    endtask: run_phase

endclass: my_monitor_in

//**************************************** OUTPUT MONITOR ****************************************//

class my_monitor_out extends uvm_monitor;

    `uvm_component_utils(my_monitor_out)

    uvm_analysis_port#(my_item) ap_out;

    //Virtual interface handle
    virtual stat_intf vif;

    function new(string name =" ", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_out = new("ap_out",this);
        if(uvm_config_db#(virtual stat_intf)::get(this, "", "vif", vif)) begin
            `uvm_info(
                "MON",
                "----------- Virtual Interface found for the monitor -----------",
                UVM_LOW
            )
        end
        else begin
            `uvm_error(
                "MON",
                "----------- Virtual Interface not found for the output monitor -----------"
            )
        end
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        my_item tr;
        forever begin
            tr = my_item::type_id::create("tr");
            @(negedge vif.clk);
            if (vif.rst_n == 0) continue; // Skip sampling outputs during reset
            tr.mean = vif.mean;
            tr.median = vif.median;
            tr.count = vif.count;
            tr.unique_count = vif.unique_count;
            ap_out.write(tr);
        end
    endtask: run_phase

endclass: my_monitor_out

//**************************************** AGENT ****************************************//

class my_agent extends uvm_agent;

    `uvm_component_utils_begin(my_agent)
        `uvm_field_enum(uvm_active_passive_enum, is_active,UVM_ALL_ON)    
    `uvm_component_utils_end

    my_driver driver;
    my_monitor_in monitor_in;
    my_monitor_out monitor_out;
    uvm_sequencer#(my_item) sequencer;

    function new(string name =" ", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        monitor_in     = my_monitor_in::type_id::create("monitor_in", this);
        monitor_out = my_monitor_out::type_id::create("monitor_out", this);

        if(get_is_active() == UVM_ACTIVE) begin
            driver = my_driver::type_id::create("driver", this);
            sequencer = uvm_sequencer#(my_item)::type_id::create("sequencer", this);
        end
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        if(get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
    endfunction: connect_phase

endclass: my_agent

//**************************************** SCOREBOARD ****************************************//

`uvm_analysis_imp_decl(_input_mon)
`uvm_analysis_imp_decl(_output_mon)
class my_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(my_scoreboard)

    uvm_analysis_imp_input_mon   #(my_item, my_scoreboard)  ap_imp_in;
    
    uvm_analysis_imp_output_mon  #(my_item, my_scoreboard) ap_imp_out;
    
    logic signed [7:0] storage[$];
    logic unique_set[logic signed [7:0]];

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp_in = new("ap_imp_in", this);
        ap_imp_out = new("ap_imp_out", this);
    endfunction: build_phase

    virtual function void write_input_mon(my_item t);
        //On reset, delete the queue and array. Flush old values. 
        if(t.rst_n === 1'bx) return; // Skip uninitialized inputs
        if(t.rst_n == 0) begin
            storage.delete();
            unique_set.delete();
        end
        else begin
            storage.push_back(t.x);
            if(!unique_set.exists(t.x)) begin
                unique_set[t.x] = 1;
            end
        end
    endfunction: write_input_mon

    virtual function void write_output_mon(my_item t);
        int expected_mean;
        int expected_median;
        int sum;
        
        if (storage.size() == 0) return; // Skip if reset or no items

        // 1. Calculate Expected Mean
        sum = storage.sum() with (int'(item));
        if (sum >= 0) begin
            expected_mean = (sum + (storage.size() / 2)) / storage.size();
        end else begin
            expected_mean = (sum - (storage.size() / 2)) / storage.size();
        end

        // 2. Calculate Expected Median
        storage.sort();
        expected_median = storage[(storage.size() - 1) / 2];

        // 3. Compare and Log
        if((t.mean == expected_mean) && (t.median == expected_median) && (t.count == storage.size()) && (t.unique_count == unique_set.size())) begin
            `uvm_info("SCB_PASS", $sformatf("Matched: mean=%0d, median=%0d, count=%0d, unique_count=%0d", 
                t.mean, t.median, t.count, t.unique_count), UVM_LOW)
        end
        else begin
            `uvm_error("SCB_FAIL", $sformatf("Mismatch! Expected: mean=%0d, median=%0d, count=%0d, unique_count=%0d | Actual: mean=%0d, median=%0d, count=%0d, unique_count=%0d", 
                expected_mean, expected_median, storage.size(), unique_set.size(), 
                t.mean, t.median, t.count, t.unique_count))
        end
    endfunction: write_output_mon

endclass: my_scoreboard

//**************************************** ENV ****************************************//

class my_env extends uvm_env;

    `uvm_component_utils(my_env)

    my_agent agent;
    my_scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = my_agent::type_id::create("agent", this);
        scoreboard = my_scoreboard::type_id::create("scoreboard", this);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        agent.monitor_in.ap_in.connect(scoreboard.ap_imp_in);
        agent.monitor_out.ap_out.connect(scoreboard.ap_imp_out);
    endfunction: connect_phase

endclass: my_env

//**************************************** TEST ****************************************//

class my_test extends uvm_test;

    `uvm_component_utils(my_test)

    my_env env;
    my_sequence seq;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = my_env::type_id::create("env", this);
        seq = my_sequence::type_id::create("seq");  //Sequence is an object and will not have the "this" parent argument
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask: run_phase
endclass: my_test