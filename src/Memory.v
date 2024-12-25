module Memory(
    input clk,
    input reset,
    input [7:0] address,
    inout [31:0] data,
    input write_enable,
    input read_enable
);
    reg [31:0] mem [0:255]; // 256-word memory (each word 32 bits)

    always @(posedge clk) begin
        if (write_enable) begin
            mem[address] = data;
        end
    end

    assign data = (read_enable) ? mem[address] : 32'bz;
endmodule

