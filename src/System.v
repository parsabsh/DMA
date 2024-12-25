module System(
    input clk,
    input reset,
    input [1:0] opcode, // Opcode for CPU (01 - LOAD, 10 - STORE, otherwise - NOP)
    input [7:0] input_address, // Address for LOAD/STORE
    output [31:0] cpu_register
);

    // System Bus (CPU, Memory, DMA)
    wire [7:0] mem_address;
    wire [31:0] mem_data;
    wire mem_write_enable;
    wire mem_read_enable;
    wire cpu_has_bus;

    // Peripheral Bus (I/O Module <-> DMA)
    wire [31:0] io_data;
    wire new_io_data_ready;

    CPU cpu(
        .clk(clk),
        .reset(reset),
        .get_bus(cpu_has_bus),
        .mem_address(mem_address),
        .mem_data(mem_data),
        .mem_write_enable(mem_write_enable),
        .mem_read_enable(mem_read_enable),
        .opcode(opcode),
        .input_address(input_address),
	.register(cpu_register)
    );

    Memory memory(
        .clk(clk),
        .reset(reset),
        .address(mem_address),
        .data(mem_data),
        .write_enable(mem_write_enable),
        .read_enable(mem_read_enable)
    );

    DMA dma(
        .clk(clk),
        .reset(reset),
        .io_data(io_data),
	.new_io_data_ready(new_io_data_ready),
        .mem_address(mem_address),
        .mem_data(mem_data),
        .mem_write_enable(mem_write_enable),
        .mem_read_enable(mem_read_enable),
        .cpu_has_bus(cpu_has_bus)
    );

    IO io(
        .clk(clk),
        .reset(reset),
	.new_data_ready(new_io_data_ready),
        .io_data(io_data)
    );
endmodule

