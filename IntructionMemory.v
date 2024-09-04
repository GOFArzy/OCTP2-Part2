module InstructionMemory(
    input [31:0] address,
    output reg [31:0] instruction
);
    reg [31:0] memory [0:255];

    initial begin
        // Carregar o programa (exemplo hardcoded)
        memory[0] = 32'b00000000000100000000000110010011; // addi x3, x0, 1
        memory[1] = 32'b00000000001000001000001000110011; // add x4, x1, x2
        memory[2] = 32'b00000000010000001010001010110011; // add x5, x1, x4
        memory[3] = 32'b00000000001100000000001100010011; // addi x6, x0, 3
        memory[4] = 32'b00000000001100001100001110110011; // sub x7, x6, x3
        memory[5] = 32'b00000000000100010000010000010011; // addi x8, x2, 1
        memory[6] = 32'b00000000001000100000010010110011; // add x9, x4, x2
        memory[7] = 32'b00000000010100010100010100110011; // sub x10, x2, x5

        // Continuar adicionando instruções conforme a necessidade do grupo 29
    end

    always @(*) begin
        instruction = memory[address[9:2]]; // Acessa a instrução na memória
    end
endmodule