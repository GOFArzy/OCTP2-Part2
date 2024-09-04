module top_module(
    input clk,
    input reset,
    output [7:0] pc_display,  // Para conectar com o display de 7 segmentos
    output [7:0] reg_display  // Para conectar com o display de 7 segmentos para o registrador
);
    wire [31:0] pcOut, instructionOut;

    // Instanciação do processador RISC-V simplificado
    RISCV_Simplified riscv(
        .clk(clk),
        .reset(reset),
        .pcOut(pcOut),
        .instructionOut(instructionOut)
    );

    // Conexão com o display de 7 segmentos (exemplo simples)
    SevenSegmentDisplay ssd_pc(
        .binary_input(pcOut[3:0]),
        .display(pc_display)
    );

    // Exemplo de conexão com o display de registradores
    SevenSegmentDisplay ssd_reg(
        .binary_input(instructionOut[11:8]),
        .display(reg_display)
    );
endmodule