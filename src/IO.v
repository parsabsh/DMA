module IO(
    input clk,
    input reset,
    output reg new_data_ready,
    output reg [31:0] io_data
);
    reg [34:0] counter; // bits 34:3 is data, bits 2:0 for counting 8 cycles

    always @(posedge clk or posedge reset) begin
        if (reset) begin
	    counter <= 0;
        end else begin
            counter = counter + 1;
	    new_data_ready <= 0;
	    if (counter[2:0] == 3'b1) begin // generate a new data every 8 cycles
	        io_data <= counter[34:3];
		new_data_ready <= 1;
	    end
        end
    end
endmodule
