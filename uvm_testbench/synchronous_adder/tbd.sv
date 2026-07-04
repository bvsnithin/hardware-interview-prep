/*************
uvm_test
uvm_env
uvm_scoreboard
uvm_agent
uvm_driver
uvm_sequencer
uvm_monitor
uvm_sequence
uvm_seqeunce_item

uvm_test
    |
    |
uvm_env

is-a => Inheritance


has-a => 
Composition (strong) and Aggregation (weak)

child car;
    Engine engine;

    function new();
        engine = new("engine1");
    endfunction: new

    function new(Enginer engine);
        this.engine = engine;
    endfunction: new
endclass

module test;
    Car car1 = new();
    Engine engine = new();
    Car car1 = new(engine);
endmodule

class test;
    env e;

endclass   

class env;
    agent a;
    scoreboard s;
endclass

class agent;
    driver d;
    monitor m;
    sequencer s;
endclass


*************/

`include <uvm_macros.svh>
import uvm_pkg::*;

module adder_dut(
    input logic clk,
    input logic rst_n,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [8:0] sum
);
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sum <= '0;
        end
        else begin
            sum <= a+b;
        end
    end
endmodule

interface adder_if(input logic clk);
    logic rst_n; 
    logic[7:0] a;
    logic[7:0] b;
    logic[8:0] sum;
endinterface

//Top
module uvm_tb;

    bit clk;

    initial clk = 0;
    always #5 clk = ~clk;

    adder_if inf(clk);

    adder_dut dut(
        .clk (clk),
        .rst_n (inf.rst_n),
        .a (inf.a),
        .b (inf.b),
        .sum (inf.sum)
    );

    initial begin
        uvm_config_db#(virtual adder_if)::set(null,"*","vif",inf);
        run_test("my_test");
    end
endmodule

// config db key = value
// set(context,instance_path, key, value)
this
null
// get(, key, value)