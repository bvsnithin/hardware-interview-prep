module sync_fifo #(
    WIDTH = 4,
    DEPTH = 8
)(
    input              clk, 
    input              reset,   //Active low reset
    input              wr_en,
    input              rd_en,
    input  [WIDTH-1:0] data_in,

    output logic [WIDTH-1:0] data_out,
    output             full_out,
    output             empty_out
);

    logic [WIDTH-1:0] fifo_mem [DEPTH-1:0]; //This means each entry is WIDTH bits wide and there are DEPTH entries

    logic [$clog2(DEPTH)-1:0] wptr;
    logic [$clog2(DEPTH)-1:0] rptr;
    logic [$clog2(DEPTH+1)-1:0] count;

    //Write
    always @(posedge clk) begin
        if(!reset) begin
            wptr <= 0;
        end
        else begin
            if(wr_en && !full_out) begin
                fifo_mem[wptr] <= data_in;
                wptr <= wptr + 1;
            end
        end
    end


    //Read
    always @(posedge clk) begin
        if(!reset) begin
            rptr <= 0;
        end
        else begin
            if(rd_en && !empty_out) begin
                data_out <= fifo_mem[rptr];
                rptr <= rptr + 1;
            end
        end
    end

    //Count and status
    always @(posedge clk) begin
        if (!reset) begin
            count <= 0;
        end else begin
            count <= count + (wr_en && !full_out) - (rd_en && !empty_out);
        end
    end

    assign empty_out = (count == 0);
    assign full_out = (count == DEPTH);

endmodule

module fifo_tb;
    localparam WIDTH = 8;
    localparam DEPTH = 4;

    logic             clk;
    logic             reset;
    logic             wr_en;
    logic             rd_en;
    logic [WIDTH-1:0] data_in;
    logic [WIDTH-1:0] data_out;
    logic [WIDTH-1:0] read_data;
    logic             empty_out;
    logic             full_out;

    sync_fifo #(.WIDTH(WIDTH), .DEPTH(DEPTH)) tb(.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        clk   <= 0;
        reset <= 1;
        wr_en <= 0;
        rd_en <= 0;

        repeat(2) begin
            @(posedge clk);
        end;

        reset <= 0;
        repeat(2) begin
            @(posedge clk);
        end
        reset <= 1;
        @(posedge clk);

        for (int i = 0; i < 5; i++) begin
            if (full_out) begin
                $display("[%0t] FIFO is full, wait for reads to happen", $time);
                wait (!full_out);
            end

            wr_en = $random;
            data_in = $random;
            $display("[%0t], clk i = %0d, wr_en = %0d, data_in = %0d", $time, i, wr_en, data_in);

            @(posedge clk);
            wr_en = 0;
        end

        for (int i = 0; i < 5; i++) begin
            if (empty_out) begin
                $display("[%0t] FIFO is empty, wait for writes to happen", $time);
                wait (!empty_out);
            end

            rd_en = $random;
            @(posedge clk);
            read_data = data_out;
            $display("[%0t], clk i = %0d, rd_en = %0d, data_out = %0d", $time, i, rd_en, read_data);
            rd_en = 0;
        end


    $finish(50);
    end
endmodule