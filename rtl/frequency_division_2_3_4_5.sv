/*************************************
Frequency division for divide by 2,3,4,5
**************************************/

// :::::::::::::::::: DIVIDE BY 2 :::::::::::::::::: //

module div_2(
    input clk,
    input rst_n,
    output logic clk_out
);

    //To get frequency division by 2, we toggle the out clock every posedge if clk. 
    //Posedge of main clock occurs every 10ns, hence the clk_out stays high for 10ns and then low for 10ns
    //Thus t_out = 2*t_in in other words, f_out = f_in/2
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            clk_out <= 0;
        end
        else begin
            clk_out <= ~clk_out;
        end
    end

endmodule

// :::::::::::::::::: DIVIDE BY 3 - 33% DUTY CYCLE :::::::::::::::::: //

module div_3_33(
    input clk,
    input rst_n,
    output clk_out
);

    // To divide clock by 3 (33% duty cycle), we can achieve by build a modulo 3 counter
    reg[1:0] count;
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 0;
        end
        else if(count == 2'b10) begin
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end

    assign clk_out = count == 2'b01;
endmodule

// :::::::::::::::::: DIVIDE BY 3 - 50% DUTY CYCLE :::::::::::::::::: //

module div_3_50(
    input clk,
    input rst_n,
    output clk_out
);
    // To divide clock by 3 (50% duty cycle), we can achieve by build a modulo 3 counter
    // Then create 2 pulses that are 33% duty cycle
    // However, the second pulse if half cycle delayed from first pulse
    // Perform "or" between first and second pulse to get perfect 50% duty cycle

    reg[1:0] count;
    reg pos_pulse;
    reg neg_pulse;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 0;
        end
        else if(count == 2'b10) begin
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            pos_pulse <= 0;
        end
        else if(count == 2'b00) begin
            pos_pulse <= 1;     //High exactly for 1 cycle
        end
        else pos_pulse <= 0;    //Low for 2 cycles
    end

    // Create a half cycle delayed pulse by sampling at neg edge of clock
    always_ff @(negedge clk or negedge rst_n) begin
        if(!rst_n) begin
            neg_pulse <= 0;
        end
        else neg_pulse <= pos_pulse;
    end

    assign clk_out = pos_pulse | neg_pulse;
endmodule

// :::::::::::::::::: DIVIDE BY 4 :::::::::::::::::: //

module div_4(
    input clk,
    input rst_n,
    output clk_out
);

    // To divide frequency by 4, we can first divide frequency by 2 and then divide the
    // freq_2 clk by 2 to get freq_4 output
    // Or we can build a modulo 4 counter.

    reg[1:0] count;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <=0;
        end
        else begin
            count <= count+1;
        end
    end

    assign clk_out = count[0] ^ count[1];
endmodule

// :::::::::::::::::: DIVIDE BY 5 :::::::::::::::::: //

module div_5(
    input clk,
    input rst_n,
    output clk_out
);

    // To divide clock by 5 (50% duty cycle), we can achieve by build a modulo 5 counter
    // Then create 2 pulses that are 40% duty cycle
    // However, the second pulse if half cycle delayed from first pulse
    // Perform "or" between first and second pulse to get perfect 50% duty cycle

    reg[3:0] count;
    reg pos_pulse;
    reg neg_pulse;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 0;
        end
        else if(count == 3'd4) begin
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            pos_pulse <= 0;
        end
        else if(count == 3'd0 || count == 3'd1) begin
            pos_pulse <= 1;     //High exactly for 2 cycles
        end
        else pos_pulse <= 0;    //Low for 3 cycles
    end

    // Create a half cycle delayed pulse by sampling at neg edge of clock
    always_ff @(negedge clk or negedge rst_n) begin
        if(!rst_n) begin
            neg_pulse <= 0;
        end
        else neg_pulse <= pos_pulse;
    end

    assign clk_out = pos_pulse | neg_pulse;
endmodule

// :::::::::::::::::: TESTBENCH :::::::::::::::::: //

module test;
    logic clk;
    logic rst_n;
    logic clk_2;
    logic clk_3_33;
    logic clk_3_50;
    logic clk_4;
    logic clk_5;

    div_2 dut2(
        .clk     (clk),
        .rst_n   (rst_n),
        .clk_out (clk_2)
    );

    div_3_33 dut3_33(
        .clk     (clk),
        .rst_n   (rst_n),
        .clk_out (clk_3_33)
    );

    div_3_50 dut3_50(
        .clk     (clk),
        .rst_n   (rst_n),
        .clk_out (clk_3_50)
    );

    div_4 dut4(
        .clk     (clk),
        .rst_n   (rst_n),
        .clk_out (clk_4)
    );

    div_5 dut5(
        .clk     (clk),
        .rst_n   (rst_n),
        .clk_out (clk_5)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        #20;        //Reset state stays for 2 clock cycles (1clock cycle is 10ns)
        rst_n = 1; //Reset removed
        #200;    //Continue simulation for 20 clock cycles
        $finish;

    end

    
endmodule

