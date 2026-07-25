/****** This RTL code shows what happens when we send a data from fast clock domain to slow clock domain ******/
/* When we pass a data signal in fast clock domain directly to slow domain, then the fast pulse might rise and fall between two 
risingedges of the slow clock domain to miss the entire event. In this RTL code, let's simulate that and show why 2FF synchronizer is not enough */

module fast_domain(
    input fast_clk, 
    input rst_n,
    input data_in,
    output logic fast_domain_out
);  
    always_ff @(posedge fast_clk or negedge rst_n) begin
        if(!rst_n) begin
            fast_domain_out <= 1'b0;
        end
        else begin
            fast_domain_out <= data_in;
        end
    end
endmodule

module slow_domain(
    input slow_clk, 
    input rst_n, 
    input slow_data_in, // Input comes from fast clock
    output slow_domain_out
);
    logic ff1; //Current cycle value
    logic ff2; //Last cycle value

    always_ff @(posedge slow_clk or negedge rst_n) begin
        if(!rst_n) begin
            ff1 <= 1'b0;
            ff2 <= 1'b0;
        end
        else begin
            ff1 <= slow_data_in;
            ff2 <= ff1;
        end
    end

    assign slow_domain_out = ff1 & ~ff2;

endmodule

module test;

    logic fast_clk;
    logic fast_domain_out;
    logic data_in;

    logic rst_n;

    logic slow_clk;
    logic slow_data_in;
    logic slow_domain_out;

    initial begin
        fast_clk = 0;
        slow_clk = 0;
    end

    always begin
        #5 fast_clk = ~fast_clk;
    end

    always begin
        #25 slow_clk = ~slow_clk;
    end

    fast_domain dut1(
        .fast_clk(fast_clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .fast_domain_out(fast_domain_out)
    );
    slow_domain dut2(
        .slow_clk(slow_clk),
        .rst_n(rst_n),
        .slow_data_in(fast_domain_out),
        .slow_domain_out(slow_domain_out)
    );

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, test);
        rst_n   = 1'b1;
        data_in = 1'b0;
        #5;

        rst_n   = 1'b0;
        #20;

        rst_n   = 1'b1;
        #20;

        // 4. Drive a 1-cycle fast pulse (10ns wide)
        @(posedge fast_clk);
        data_in <= 1'b1;

        @(posedge fast_clk);
        data_in <= 1'b0;

        #200;
        $finish;
    end
endmodule


