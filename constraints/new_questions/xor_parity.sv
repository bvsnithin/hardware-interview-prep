/************************************************************************************************************
Given an 8-bit data field and a separate 1-bit parity field, randomize both such that parity equals the XOR-reduction of data

Asked to solve using a function
************************************************************************************************************/
class packet;
    rand logic[7:0] data;
    rand logic parity;

    //Since this question needs to be solved using function, there are some things to consider when using functions with constraints
    // 1) Function should be automatic
    // 2) It should only have an input argument and return a value
    // 3) No output or inout arguments. 
    function automatic logic calculate_xor(input logic [7:0] data);
        return ^data;
    endfunction: calculate_xor

    constraint c_parity{
        parity == calculate_xor(data);
    }
endclass

module test;
    packet p;
    initial begin
        p = new();
        repeat(5) begin
            if(p.randomize()) begin
                $display("Data: %0b", p.data);
                $display("Parity: %0b", p.parity);
            end
        end
    end
endmodule