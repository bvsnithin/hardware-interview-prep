

module fsm_three_consequtive_ones(
    input clk, 
    input reset,

    input logic data_in,
    output logic ones_detected
);

    typedef enum logic [1:0] {S0,S1,S11,S111} state_t;

    state_t state, next_state;

    always_ff @( posedge clk or posedge reset) begin : sequential_bloc
        if(reset) begin
            state <= S0;
        end
        else begin 
            state <= next_state;
        end
    end

    always_comb begin : combinational_block
        case(state)
            S0:   next_state = data_in?S1:S0;
            S1:   next_state = data_in?S11:S0;
            S11:  next_state = data_in?S111:S0;
            S111: next_state = data_in?S111:S0;
        endcase
    end

    assign ones_detected = (state == S111);
endmodule


module test;
    logic clk;
    logic reset;
    logic data_in;
    logic ones_detected;

    fsm_three_consequtive_ones dut(.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
         reset = 1;
         data_in = 0;
         @(posedge clk);
         #1;
         reset = 0;

         @(posedge clk) #1 data_in = 0;
         @(posedge clk) #1 data_in = 1;
         @(posedge clk) #1 data_in = 0;
         @(posedge clk) #1 data_in = 1;
         @(posedge clk) #1 data_in = 0;
         @(posedge clk) #1 data_in = 1;
         @(posedge clk) #1 data_in = 1;
         @(posedge clk) #1 data_in = 1;
         @(posedge clk) #1 data_in = 1;
         @(posedge clk) #1 data_in = 1;
         @(posedge clk) #1 data_in = 0;
         @(posedge clk) #1 data_in = 1;
         @(posedge clk) #1 data_in = 1;
         @(posedge clk) #1 data_in = 1;
         #1;
        $finish;
    end

    initial begin
        $monitor("[%0t] data_in=%0b state_detect=%0b",$time, data_in, ones_detected);
    end
endmodule