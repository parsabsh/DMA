module CPU(
    input clk,
    input reset,
    output reg get_bus,
    output [7:0] mem_address,
    inout [31:0] mem_data,
    output mem_write_enable,
    output mem_read_enable,
    input [1:0] opcode, // 2-bit opcode: 01 - LOAD, 10 - STORE, otherwise - NOP
    input [7:0] input_address, // Address for LOAD/STORE
    output reg [31:0] register // Internal register to simulate load/store operations
);
    reg [31:0] data;
    reg [7:0] address;
    reg write_enable;
    reg read_enable;

    assign mem_data = (get_bus & write_enable) ? data : 32'bz;
    assign mem_address = (get_bus) ? address : 8'bz;
    assign mem_write_enable = (get_bus) ? write_enable : 1'bz;
    assign mem_read_enable = (get_bus) ? read_enable : 1'bz;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            get_bus <= 0;
            write_enable <= 0;
            read_enable <= 0;
            address <= 8'b0;
            register <= 32'b0;
        end else begin
    	    if (read_enable) register = mem_data;
            case (opcode)
                2'b01: begin // LOAD
                    get_bus = 1;
                    read_enable = 1;
		    write_enable = 0;
                    address = input_address; 
                end
                2'b10: begin // STORE
                    get_bus = 1;
		    read_enable = 0;
                    write_enable = 1;
                    address = input_address;
                    data = register;
                end
                default: begin // NOP
                    get_bus = 0;
                    write_enable = 0;
                    read_enable = 0;
                end
            endcase
        end
    end
endmodule
