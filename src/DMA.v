module DMA(
    input clk,
    input reset,
    input cpu_has_bus,
    input [31:0] io_data,
    input new_io_data_ready,
    output [7:0] mem_address,
    output [31:0] mem_data,
    output mem_write_enable,
    output mem_read_enable
);
    reg [31:0] buffer;
    reg new_data_in_buffer;

    assign mem_address = (!cpu_has_bus & new_data_in_buffer) ? 8'b0 : 8'bz; // I/O is mapped to location 0 of memory
    assign mem_data = (!cpu_has_bus & new_data_in_buffer) ? buffer : 32'bz;
    assign mem_read_enable = (!cpu_has_bus) ? 1'b0 : 1'bz;
    assign mem_write_enable = (!cpu_has_bus) ? new_data_in_buffer : 1'bz;

    always @(posedge clk or posedge new_io_data_ready) begin
	if (new_io_data_ready) begin
		buffer = io_data;
        	new_data_in_buffer = 1;
	end else if (!cpu_has_bus & mem_write_enable)
		new_data_in_buffer = 0;  // make it zero if cpu released the bus and dma wrote into mem
    end

    always @(posedge reset) begin
	buffer = 0;
        new_data_in_buffer = 0;
    end
endmodule

