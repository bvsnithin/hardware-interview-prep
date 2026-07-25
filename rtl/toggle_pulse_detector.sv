/**********************
Write RTL code to detect toggle (0 -> 1 or 1->0) and a pulse
**********************/

module toggle_detector(
    input clk, 
    input rst_n,
    input data_in,
    output toggle_detect
);
    logic prev;
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            prev <= 1'b0;
        end
        else begin
            prev <= data_in;
        end
    end

    assign toggle_detect = prev ^ data_in;
endmodule

// Negative Edge Detector 
module pulse_detector(
    input clk,
    input rst_n,
    input data_in,
    output pulse_detect
);

    logic prev;
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            prev <= 1'b0;
        end
        else begin
            prev <= data_in;
        end
    end

    assign pulse_detect = prev & ~data_in;

endmodule

module test;
    logic clk;
    logic rst_n;
    logic data_in;
    logic toggle_detect;
    logic pulse_detect;

    toggle_detector dut1(.*);

    pulse_detector dut2(.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        data_in = 0;

        repeat(2) @(posedge clk);

        rst_n = 1;
        repeat(50) begin
            @(posedge clk);
            data_in <= $random();
        end

        $finish;
    end
endmodule