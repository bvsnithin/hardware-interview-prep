/******************
Implement a Round-Robin Arbiter with 3 I/p requests.
*******************/


module round_robin_arbiter #(
    parameter N = 3
)(
    input                        clk,
    input                        reset,  //Active low reset
    input  logic [N-1:0]         req,
    output logic [N-1:0]         grant,
    output logic [$clog2(N)-1:0] grant_index
);
    logic [$clog2(N)-1:0] ptr, next_ptr;
    
    always_comb begin
        grant = 'b0;
        grant_index = 'b0;
        next_ptr = ptr;

        if (reset) begin 
            for(int i = 1; i <= N; i++) begin
                logic [$clog2(N)-1:0] index;
                index = (ptr + i) % N;

                if(req[index] == 1'b1) begin
                    grant[index] = 1'b1;
                    grant_index = index;
                    next_ptr = index;
                    break;
                end
            end
        end
    end

    always_ff @(posedge clk or negedge reset) begin
        if(!reset) begin
            ptr <= N - 1; // Reset to N-1 so first grant searches from index 0
        end
        else begin
            ptr <= next_ptr;
        end
    end

endmodule

module arbiter_tb;
    localparam N = 3;
    logic clk;
    logic reset;
    logic [N-1:0] req;
    logic [N-1:0] grant;
    logic [$clog2(N)-1:0] grant_index;

    round_robin_arbiter #(.N(N)) dut (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        req = 'b0;

        repeat(2) @(posedge clk);
        reset <= 0;
        repeat(2) @(posedge clk);
        reset <= 1;

        repeat(15) begin
            @(posedge clk);
            req <= $urandom;
            @(negedge clk);
            $display("time=%0t req=%03b grant=%03b index=%0d ptr=%0d next_ptr=%0d", $time, req, grant, grant_index, dut.ptr, dut.next_ptr);
        end

        $finish;
    end

    // always @(negedge clk) begin
    //     $display("-- [MON] -- time=%0t ptr=%0d next_ptr=%0d grant=%03b index=%0d", $time, dut.ptr, dut.next_ptr, grant, grant_index);
    // end

endmodule