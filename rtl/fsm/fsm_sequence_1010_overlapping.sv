/*********
Design an FSM for serial sequence detector with the pattern “1010” with overlapping 
**********/

module fsm_1010_overlapping(
    input clk,
    input reset,

    input logic data_in,
    output logic detected
);

    typedef enum logic[2:0] {IDLE, A,B,C} states;
    states state, next_state;

    logic [3:0] data_history;

    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= IDLE;
            data_history <= 4'b0000;
        end
        else begin
            state <= next_state;
            data_history <= {data_history[2:0],data_in};
        end
    end

    always_comb begin
        next_state = state;
        detected = 0;

        case(state)
            IDLE: begin
                next_state = data_in?A:IDLE;
                detected = 0;
            end
            A: begin
                next_state = data_in?A:B;
                detected = 0;
            end
            B: begin
                next_state = data_in?C:IDLE;
                detected = 0;
            end
            C: begin
                next_state = data_in?A:B;
                detected = data_in?0:1;
            end
            default: begin
                next_state = IDLE;
                detected = 0;
            end
        endcase
    end

endmodule


module test;
    logic clk;
    logic reset;

    logic data_in;
    logic detected;

    fsm_1010_overlapping dut(.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        data_in = 0;
        repeat(2) @(posedge clk);
        reset = 0;
        @(posedge clk); #1 data_in = 1;
        @(posedge clk); #1 data_in = 0;
        @(posedge clk); #1 data_in = 1;
        @(posedge clk); #1 data_in = 0;
        @(posedge clk); #1 data_in = 1;
        @(posedge clk); #1 data_in = 0;

        @(posedge clk);
        #1;

        repeat(15) begin
            @(posedge clk);
            #1 data_in = $random();
        end

        @(posedge clk);
        $finish;
    end
endmodule