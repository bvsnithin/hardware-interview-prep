/*****************************
Design a sequence detector for the bit pattern 1101 on a serial input. Overlapping matches should be allowed, 
meaning a pattern like 110101101 should trigger a detect signal at every valid occurrence, including cases where the end of one match overlaps with the start of the next.

Note: In a moore machine, output shows up one cycle after the final bit of a sequence has been fully processed
      In a mealy machine, output goes high immediately, in the same cycle that the final bit arrives because the o/p depends on both i/p and current state
*****************************/

// Moore machine implementation 
module moore_fsm(
    input clk,
    input rst_n,
    input in, 
    output detect
);
    // A -> input 0
    // B -> input 1, seq is now just 1. If next input is 0, it goes back to A(0)
    // C -> input 1, seq is now 11. If next input is 1, then it remains in the same state. If 0, then goes to D
    // D -> input 0, seq is now 110. If next input is 1, then it goes to E state or else goes to A state
    // E -> input 1, seq is now 1101. If next input is 1, Then it goes to C states. If 0, then it goes to A
    typedef enum logic[2:0] {A, B, C, D, E} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= A;
        end
        else state <= next_state;
    end

    always_comb begin
        next_state = state;
        case(state)
            A: next_state = in? B:A;
            B: next_state = in? C:A;
            C: next_state = in? C:D;
            D: next_state = in? E:A;
            E: next_state = in? C:A;
        endcase
    end

    assign detect = (state == E);

endmodule


// Mealy machine implementation
module mealy_fsm(
    input clk,
    input rst_n,
    input in, 
    output logic detect
);
    typedef enum logic[1:0] {A, B, C, D} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= A;
        end
        else state <= next_state;
    end

    always_comb begin
        next_state = state;
        detect = 1'b0;
        case(state)
            A: next_state = in? B:A;
            B: next_state = in? C:A;
            C: next_state = in? C:D;
            D: begin
                if(in) begin
                    detect = 1'b1;
                    next_state = B;
                end
                else next_state = A;
            end
        endcase
    end
endmodule

// Testbench
module tb;
    logic clk;
    logic rst_n;
    logic in;
    logic detect_moore, detect_mealy;

    initial clk = 0;
    always #5 clk = ~clk;

    moore_fsm dut1(.clk(clk), .rst_n(rst_n), .in(in), .detect(detect_moore));
    mealy_fsm dut2(.clk(clk), .rst_n(rst_n), .in(in), .detect(detect_mealy));

    bit test_bits[] = '{1,1,0,1,0,1,1,0,1};

    initial begin
        $monitor("Time=%0t Input=%0b Moore_State=%s Detect=%0b Mealy_State=%s Detect=%0b", 
                 $time, in, dut1.state.name(), detect_moore, dut2.state.name(), detect_mealy);

        rst_n = 0;
        in = 0;
        repeat(2) @(posedge clk);

        rst_n = 1;
        
        foreach(test_bits[i]) begin
            @(posedge clk);   // Wait for the clock edge...
            in <= test_bits[i]; // ...then drive the input non-blockingly
        end
        
        @(posedge clk); // Give it one final cycle to let the Moore machine display its last state
        $finish();
    end
endmodule