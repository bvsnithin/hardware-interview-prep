module half_subtractor(
    input a, b,
    output diff_half, borrow_half
);
    assign diff_half = a^b;
    assign borrow_half = b & (~a);   
endmodule

module full_subtractor(
    input a,b, b_in,
    output diff_full, borrow_out
);

    assign diff_full = a ^ b ^ b_in;
    assign borrow_out = ((~a) & (b | b_in)) | (a & (b & b_in));
endmodule

module test;
    logic a,b,b_in;
    logic diff_half, diff_full, borrow_half, borrow_out;

    half_subtractor dut1 (
        .a(a), .b(b), 
        .diff_half(diff_half), .borrow_half(borrow_half)
    );
    
    full_subtractor dut2 (
        .a(a), .b(b), .b_in(b_in), 
        .diff_full(diff_full), .borrow_out(borrow_out)
    );

    initial begin
        $monitor("TIME: %0t | HALF -> A:%b B:%b | Diff:%b Borrow:%b || FULL -> A:%b B:%b Bin:%b | Diff:%b Borrow Out:%b", 
                       $time, a, b, diff_half, borrow_half, a, b, b_in, diff_full, borrow_out);
        repeat(10) begin
            a = $random;
            b = $random;
            b_in = $random;
            #1;
        end
        $finish;
    end
endmodule