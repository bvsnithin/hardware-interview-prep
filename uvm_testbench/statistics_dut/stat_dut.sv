/**********************
This is a design file for a statistics DUT. That performs mean, median, count of unique values, count of all values. 
These operations are performed on the values that are received until a reset is called
***********************/

module stat_dut(
    input clk, 
    input rst_n,
    input logic signed [7:0] x,

    output logic signed [7:0] mean, median, 
    output logic [4:0] count, unique_count
);

    // Internal tracking registers
    logic signed [12:0] sum_reg;
    logic [4:0]         count_reg;
    logic [4:0]         unique_reg;
    logic [255:0]       seen_values;
    logic [4:0]         histogram [0:255]; // 256 bins, each can count up to 32

    // Map signed input (-128 to 127) to unsigned index (0 to 255)
    logic [7:0] index;
    assign index = x + 128;

    // Sequential Logic: Update registers on every sample
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum_reg      <= '0;
            count_reg    <= '0;
            unique_reg   <= '0;
            seen_values  <= '0;
            for (int i = 0; i < 256; i++) begin
                histogram[i] <= '0;
            end
        end else if (count_reg < 31) begin // Cap at 31 samples (max 5-bit val)
            sum_reg             <= sum_reg + x;
            count_reg           <= count_reg + 1'b1;
            histogram[index]    <= histogram[index] + 1'b1;
            
            if (!seen_values[index]) begin
                seen_values[index] <= 1'b1;
                unique_reg         <= unique_reg + 1'b1;
            end
        end
    end

    // Drive simple outputs
    assign count        = count_reg;
    assign unique_count = unique_reg;

    // Combinational Logic: Mean with rounding
    always_comb begin
        if (count_reg == 0) begin
            mean = '0;
        end else begin
            // Classic rounding trick: add half the denominator before dividing
            if (sum_reg >= 0)
                mean = (sum_reg + int'(count_reg >> 1)) / int'(count_reg);
            else
                mean = (sum_reg - int'(count_reg >> 1)) / int'(count_reg);
        end
    end

    // Combinational Logic: Median Finder (Histogram Traversal Tree)
    always_comb begin
        logic [5:0] running_sum;
        logic [4:0] target;
        
        median = '0;
        running_sum = '0;
        target = (count_reg + 1) >> 1; // Middle element threshold

        if (count_reg > 0) begin
            for (int i = 0; i < 256; i++) begin
                running_sum = running_sum + histogram[i];
                if (running_sum >= target) begin
                    median = i - 128; // Convert back to signed value
                    break;
                end
            end
        end
    end

endmodule
