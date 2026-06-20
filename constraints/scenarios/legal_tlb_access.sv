/********************************************
Legal TLB access type
Constrain a TLB request so the access type is always read-only when the page is marked non-writable, and never executable when the page has NX bit set
**********************************************/

class tlb_req;
    rand bit [39:0] va;         //Virtual Address
    rand bit [2:0] access_type; // 0 = read, 1 = write, 2 = exec
    bit page_writeable;
    bit page_nx;

    constraint c_legal_tlb_access{
        (page_writeable == 0) -> (access_type == 3'b000);
        (page_nx == 1) -> (access_type != 3'b010);
    }

    constraint c_access_types{
        access_type inside {3'b000, 3'b001, 3'b010};
    }

endclass: tlb_req

module test;
    tlb_req req;
    initial begin
        req = new();
        req.page_writeable = 0;
        req.page_nx = 0;
        if(req.randomize()) begin
            $display("Virtual Address: %40b, Access Type: %03b, Page Writeable = %01b, Page NX = %01b",req.va,req.access_type,req.page_writeable, req.page_nx);
        end
        req = new();
        req.page_writeable = 1;
        req.page_nx = 1;
        if(req.randomize()) begin
            $display("Virtual Address: %40b, Access Type: %03b, Page Writeable = %01b, Page NX = %01b",req.va,req.access_type,req.page_writeable, req.page_nx);
        end

        repeat(5) begin
            req = new();
            req.page_writeable = $urandom_range(0,1);
            req.page_nx = $urandom_range(0,1);
            if(req.randomize()) begin
                $display("Virtual Address: %40b, Access Type: %03b, Page Writeable = %01b, Page NX = %01b",req.va,req.access_type,req.page_writeable, req.page_nx);
            end
        end
    end
endmodule
