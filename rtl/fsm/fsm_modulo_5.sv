/***********************
Design a finite state machine for modulo 5 operation
8421
1001

States S0,S1,S2,S3,S4
S0 - Remainder 0
S1 - Remainder 1
S2 - Remainder 2
S3 - Remainder 3
S4 - Remainder 4

Current State | Incoming bit = 0 | Incoming bit = 1
S0                  S0                 S1
S1                  S2                 S3
S2                  S4                 S0
S3                  S1                 S2
S4                  S3                 S4


***********************/

module fsm_modulo_5(
    input clk,
    input reset,

    input logic data_in,
    output logic [2:0] remainder,
    output logic divisible_by_5
);

typedef enum logic[2:0] {S0,S1,S2,S3,S4} state;

state curr_state, next_state;

logic [3:0] data;

always@(posedge clk or posedge reset) begin
    if(reset) begin
        curr_state <= S0;
        data <= 4'b0000;
    end
    else begin
        curr_state <= next_state;
        data <= {data[2:0],data_in};
    end
end

always @(*) begin

    next_state = curr_state;
    remainder = 0;
    case(curr_state)
        S0: begin
            if(data_in) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
            remainder = 0;
        end

        S1: begin
            if(data_in) begin
                next_state = S3;
            end 
            else begin 
                next_state = S2;
            end
            remainder = 1;
        end

        S2: begin
            if(data_in) begin
                next_state = S0;
            end
            else begin
                next_state = S4;
            end
            remainder = 2;
        end

        S3: begin
            if(data_in) begin
                next_state = S2;
            end
            else begin
                next_state = S1;
            end
            remainder = 3;
        end

        S4: begin
            if(data_in) begin
                next_state = S4;
            end
            else begin
                next_state = S3;
            end
            remainder = 4;
        end

        default: begin
            next_state = S0;
            remainder = 0;
        end

    endcase
end

assign divisible_by_5 = (curr_state == S0);

endmodule

module test;
    logic clk;
    logic reset;

    logic data_in;
    logic [2:0] remainder;
    logic divisible_by_5;

    fsm_modulo_5 dut(.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        data_in = 0;
        repeat(2) @(posedge clk);
        reset = 0;
        @(posedge clk); #1 data_in = 1;
        @(posedge clk); #1 data_in = 0;
        @(posedge clk); #1 data_in = 0;
        @(posedge clk); #1 data_in = 1;

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