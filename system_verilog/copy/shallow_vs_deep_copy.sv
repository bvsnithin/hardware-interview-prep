class header;
  int addr = 10;
endclass: header

class packet;
  int length;
  header h;

  function new();
    length = 100;
    h = new();
  endfunction: new

  function void deep_copy(packet pkt);
    this.length = pkt.length;
    if (pkt.h != null) begin
      this.h = new();
      this.h.addr = pkt.h.addr;
    end else begin
      this.h = null;
    end
  endfunction: deep_copy
endclass: packet

module test;
  packet p1 = new();
  // Copying the pointer
  packet p2 = p1;
  // Shallow copy. 
  packet p3 = new p1;

  // Deep Copy
  packet p4 = new();

  initial begin
    p4.deep_copy(p1);

    if(p1 == p2) begin
      $display("P1 and P2 point to same memory location because p2 = p1");
    end
    
    if(p1 != p3) begin
      $display("P1 and P3 are not pointing to same memory location, hence the pointers are different");
    end
    
    if(p1.h == p3.h) begin
      $display("P1 header and P3 header pointers point to the same memory location (Shallow Copy)");
    end
    
    if(p1 != p4 && p1.h != p4.h) begin
      $display("P1 and P4 point to different memory locations. Even p1.h and p4.h point to different locations (Deep Copy)");
    end
  end
endmodule