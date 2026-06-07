/******************
RTL for a fixed priority arbiter with increasing priority from LSB to MSB.
******************/

module arbiter #(
    N = 8
)(
    input logic [N-1:0] req,
    output logic [N-1:0] onehot_ouput,
    output logic [$clog2(N)-1:0] grant_index
);
    always_comb begin
        onehot_ouput = '0;
        for(int i = N-1;i>=0;i--) begin
            if(req[i] == 1'b1) begin
                onehot_ouput[i] = 1'b1;
                grant_index = i;
                break;
            end
        end
    end
    
endmodule

module arbiter_tb;
    localparam N = 8;

    logic [N-1:0] req;
    logic [N-1:0] onehot_ouput;
    logic [$clog2(N)-1:0] grant_index;

    arbiter dut(.*);

    initial begin
        repeat(5) begin
            req = $random;
            #1;
            $display("Request: %08b, Output: %08b, Grand Index: %0d",req,onehot_ouput,grant_index);
        end
    end
endmodule