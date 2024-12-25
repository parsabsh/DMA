module tb;

reg clk, reset;
reg [7:0] address;
reg [1:0] opcode;
wire [31:0] cpu_register;

System dut(
	.clk(clk),
	.reset(reset),
	.opcode(opcode),
	.input_address(address),
	.cpu_register(cpu_register)
);

always #5 clk = ~clk;

initial begin

{clk, reset, address, opcode} = 0;
#10 reset = 1;
$display("<<time 10>> RESET");

#10 // start with NOP
reset = 0;
opcode = 2'b00;
$display("<<time 20>> Instruction: NOP");

#20 // LOAD CPU register with I/O data which is stored in 0x00 address
opcode = 2'b01;
address = 8'h00;
$display("<<time 30>> Instruction: NOP");
$display("<<time 40>> Instruction: NOP");

#10 $display("<<time 50>> Instruction: NOP");

// STORE CPU register to address 0x01
opcode = 2'b10;
address = 8'h01;

#10 $display("<<time 60>> Intruction: LOAD MEM[0] \t Result: cpu_register=%b", cpu_register);

// NOP for 10 cycles
opcode = 2'b00;

#10 $display("<<time 70>> Intruction: STORE MEM[1]");

#10 $display("<<time 80>> Instruction: NOP");
#10 $display("<<time 90>> Instruction: NOP");
#10 $display("<<time 100>> Instruction: NOP");
#10 $display("<<time 110>> Instruction: NOP");
#10 $display("<<time 120>> Instruction: NOP");
#10 $display("<<time 130>> Instruction: NOP");
#10 $display("<<time 140>> Instruction: NOP");
#10 $display("<<time 150>> Instruction: NOP");
#10 $display("<<time 160>> Instruction: NOP");


// LOAD CPU register with I/O data which is stored in 0x00 address
opcode = 2'b01;
address = 8'h00;

#10 $display("<<time 170>> Instruction: NOP");

// STORE CPU register to address 0x02
opcode = 2'b10;
address = 8'h02;

#10 $display("<<time 180>> Intruction: LOAD MEM[0] \t Result: cpu_register=%b", cpu_register);


// LOAD CPU register with Mem[1]
opcode = 2'b01; 
address = 8'h01;
#10 $display("<<time 190>> Intruction: STORE MEM[2]");


// LOAD CPU register with Mem[2]
opcode = 2'b01;
address = 8'h02;
#10 $display("<<time 200>> Intruction: LOAD MEM[1] \t Result: cpu_register=%b", cpu_register);

#10 $display("<<time 210>> Intruction: LOAD MEM[2] \t Result: cpu_register=%b", cpu_register);
end

endmodule

