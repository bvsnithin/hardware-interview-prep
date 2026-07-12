module divide_3_50(
    input clk,
    input rst_n,
    output clk_out
);
    logic [1:0] count;
    logic pos_pulse;
    logic neg_pulse;

    // Modulo 3 Counter
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
        end else if (count == 2'd2) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end

    // Generate a pulse that is high for 1 clock cycle (on posedge)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pos_pulse <= 0;
        end else if (count == 2'd0) begin
            pos_pulse <= 1;
        end else begin
            pos_pulse <= 0;
        end
    end

    // Delay the pulse by half a clock cycle (using negedge)
    always_ff @(negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            neg_pulse <= 0;
        end else begin
            neg_pulse <= pos_pulse;
        end
    end

    // Combine the pulses to get a 1.5 cycle high time (50% duty cycle)
    assign clk_out = pos_pulse | neg_pulse;

endmodule

module test_50;
    logic clk;
    logic rst_n;
    logic clk_out;

    divide_3_50 dut (.*);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;

        #20;
        rst_n = 1;

        #200;

        $finish;
    end

    initial begin
        $monitor("Time=%0t | clk=%b | rst_n=%b | clk_out=%b",
                $time, clk, rst_n, clk_out);
    end
endmodule
