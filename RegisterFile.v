module RegisterFile(
    input clk,
    input [4:0] rs1, rs2, rd,
    input [31:0] writeData,
    input regWrite,
    output [31:0] readData1, readData2
);
    reg [31:0] registers [0:31];
    
    // Leitura dos registradores
    assign readData1 = registers[rs1];
    assign readData2 = registers[rs2];
    
    // Escrita nos registradores
    always @(posedge clk) begin
        if (regWrite)
            registers[rd] <= writeData;
    end
endmodule