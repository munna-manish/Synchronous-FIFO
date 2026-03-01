module sync_fifo #(
    parameter DEPTH = 16,
    parameter WIDTH = 8,
    parameter ADDR_WIDTH = $clog2(DEPTH)
) (
    input wr_en, rd_en,
    input [WIDTH-1:0] data_in,
    input clk, reset,
    output [WIDTH-1:0] data_out,
    output fifo_full, fifo_empty
    
);
    reg [WIDTH-1:0] mem [DEPTH-1:0];
    reg [ADDR_WIDTH-1:0] wr_pntr, rd_pntr;
    reg [ADDR_WIDTH:0] fifo_count;
    assign fifo_full = (fifo_count == DEPTH);
    assign fifo_empty = (fifo_count == 0);


    always @(posedge clk) begin
        if (reset)
            fifo_count <= 0;
        else begin
            case({wr_en && !fifo_full, rd_en && !fifo_empty})
                2'b10: fifo_count <= fifo_count+1;
                2'b01: fifo_count <= fifo_count-1;
                default: fifo_count <= fifo_count;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset)
            wr_pntr <= 1'b0;
        else begin
            if(wr_en && !fifo_full) begin
                mem[wr_pntr] <= data_in;
                wr_pntr <= wr_pntr + 1;
            end
        end
    end

    always @(posedge clk) begin
        if(reset)
            rd_pntr <= 1'b0;
        else begin
            if(rd_en && !fifo_empty) begin
                rd_pntr <= rd_pntr + 1;
            end
        end
    end

    assign data_out = mem[rd_pntr];

endmodule