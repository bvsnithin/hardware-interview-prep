// Moore FSM: The output is a function of the current state
// Mealy FSM: The output is a function of current state and current input
module fsm_moore_1011(
    input logic clk, 
    input logic rst_n,
    input logic in, 
    output logic out
);

    typedef enum logic[2:0] {A,B,C,D,E} state_t;

    state_t state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        case(state)
            A: begin
                next_state = in?B:A;
            end
            B: begin
                next_state = in?B:C;
            end
            C: begin
                next_state = in?D:A;
            end
            D: begin
                next_state = in?E:C;
            end
            E: begin
                next_state = in?B:C;
            end
        endcase
    end

    assign out = (state == E);
endmodule


module test;
    logic clk;
    logic rst_n;
    logic in;
    logic out;

    fsm_moore_1011 dut(.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $monitor("[TIME: %0t] rst_n = %0b, input = %0b, output = %0b, state = %0s, next_state = %0s",$time, rst_n, in, out, dut.state.name(), dut.next_state.name());
    end

    logic test_case[10] = '{1,0,0,0,1,0,1,1,1,0};
    initial begin
        rst_n = 0;
        in = 0;
        repeat(2) @(posedge clk);
        rst_n = 1;
        for(int i =0;i<10;i++) begin
            @(posedge clk);
            in <= test_case[i];
        end
        #50;
        $finish;
    end
endmodule