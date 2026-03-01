module testbench;
localparam DEPTH = 16;
localparam WIDTH = 8;
reg wr_en, rd_en;
reg [WIDTH-1:0] data_in;
reg clk, reset;
wire [WIDTH-1:0] data_out;
wire fifo_full, fifo_empty;

sync_fifo #(.DEPTH(DEPTH),.WIDTH(WIDTH)) dut (.wr_en(wr_en),.rd_en(rd_en),.data_in(data_in),.data_out(data_out),.fifo_full(fifo_full),.fifo_empty(fifo_empty),.clk(clk),.reset(reset));

always #5 clk = ~clk;
initial begin
    $dumpfile("fifo_waves.vcd");
    $dumpvars(0,testbench);
    wr_en = 1'b0; rd_en = 1'b0; clk = 1'b0; reset = 1'b1; data_in = 0;
    #15; reset = 1'b0;
    $monitor("%ts | Data in = %h | Write enable = %b | Read Enable = %b | Data out = %h\n\t\t\tFIFO full = %b | FIFO empty = %b\n",$time,data_in,wr_en,rd_en,data_out,fifo_full,fifo_empty);

    repeat(DEPTH) begin
        @(negedge clk);
        wr_en = 1'b1;
        data_in = data_in + 1;
    end
    @(negedge clk) wr_en = 1'b0;

    #20;

    repeat(DEPTH) begin
        @(negedge clk);
        rd_en = 1'b1;
    end
    @(negedge clk) rd_en = 1'b0;

    #20; $finish;
end
endmodule
    

