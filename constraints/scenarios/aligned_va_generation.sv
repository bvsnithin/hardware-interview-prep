/***********************
===== Aligned VA generation ====

Generate virtual addresses that are always naturally aligned to their access size. 
Access size is also randomized as 4B, 8B, 16B, or 64B.
************************/

class addr_req;
    rand bit [63:0] va;
    rand int unsigned size_bytes;

    constraint c_size_bytes{
        size_bytes inside{4,8,16,64};
    }

    constraint va_aligned{
        if(size_bytes == 4){
            va[1:0] == 2'b00;
        }
        else if(size_bytes == 8){
            va[2:0] == 3'b000;
        }
        else if(size_bytes == 16){
            va[3:0] == 4'b0000;
        }
        else if(size_bytes == 64){
            va[4:0] == 6'b000000;
        }
    }
endclass: addr_req

module test;
    addr_req req;
    initial begin
        repeat(5) begin
            req = new();
            if(req.randomize()) begin
                $display("Virtual Address: %0h, Size Bytes = %0d", req.va, req.size_bytes);
            end
        end
    end
endmodule