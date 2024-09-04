module RISCV_Simplified(
    input clk,
    input reset,
    output [31:0] pcOut,
    output [31:0] instructionOut
);
    wire [31:0] pcCurrent, pcNext, instruction;
    wire [31:0] regData1, regData2, aluResult, immOut, memData;
    wire [3:0] aluControl;
    wire regWrite, aluSrc, memWrite, branch, jump;

    // Instanciando os módulos
    ProgramCounter PC(
	.clk(clk),
	.reset(reset),
	.nextPC(pcNext),
	.currentPC(pcCurrent));

    InstructionMemory IM(
	.address(pcCurrent),
	.instruction(instruction));

    RegisterFile RF(
	.clk(clk),
	.rs1(instruction[19:15]),
	.rs2(instruction[24:20]), 
        .rd(instruction[11:7]),
	.writeData(memData),
	.regWrite(regWrite), 
        .readData1(regData1),
	.readData2(regData2));

    ImmGen IG(
	.instruction(instruction),
	.immOut(immOut));
    
    ControlUnit CU(
	.opcode(instruction[6:0]),
	.funct3(instruction[14:12]),
	.funct7(instruction[31:25]), 
        .aluControl(aluControl),
	.regWrite(regWrite),
	.aluSrc(aluSrc), 
        .memWrite(memWrite),
	.branch(branch),
	.jump(jump));

    ALU ALU(
	.srcA(regData1),
	.srcB(aluSrc ? immOut : regData2), 
        .aluControl(aluControl),
	.aluResult(aluResult));
    
    DataMemory DM(
	.clk(clk),
	.memWrite(memWrite),
	.address(aluResult), 
        .writeData(regData2),
	.readData(memData));

    // Ligação do PC com a ALU
    assign pcNext = jump ? (pcCurrent + immOut) : (branch ? (pcCurrent + immOut) : (pcCurrent + 4));
    
    assign pcOut = pcCurrent;
    assign instructionOut = instruction;

endmodule