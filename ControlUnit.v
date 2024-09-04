module ControlUnit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] aluControl,
    output reg regWrite,
    output reg aluSrc,
    output reg memWrite,
    output reg branch,
    output reg jump
);
    always @(*) begin //lh sh add or andi sll bne
        // Definir valores padrão
        aluControl = 4'b0000;
        regWrite = 0;
        aluSrc = 0;
        memWrite = 0;
        branch = 0;
        jump = 0;

        case(opcode)
            7'b0110011: begin // R-type
                regWrite = 1;
                case(funct3)
                    3'b000: aluControl = (funct7 == 7'b0000000) ? 4'b0000 : 4'b0001; // ADD/SUB
                    3'b110: aluControl = 4'b0011; // OR
                    3'b001: aluControl = 4'b0101; // SLL
                endcase
            end
            7'b0010011: begin // I-type (ADDI, ANDI)
                regWrite = 1;
                aluSrc = 1;
                case(funct3)
                    3'b000: aluControl = 4'b0000; // ADDI
                    3'b111: aluControl = 4'b0010; // ANDI
                endcase
            end
            7'b0001011: begin // Load halfword (LH)
                regWrite = 1;
                aluSrc = 1;
                aluControl = 4'b0000; // ADD
            end
            7'b0100011: begin // Store word (SW)
                memWrite = 1;
                aluSrc = 1;
                aluControl = 4'b0000; // ADD
            end
            7'b0101011: begin // Store halfword (SH)
                memWrite = 1;
                aluSrc = 1;
                aluControl = 4'b0000; // ADD
            end
            7'b1100011: begin // Branch (BNE)
                branch = 1;
                case(funct3)
                    3'b001: aluControl = 4'b0001; // BNE
                endcase
            end
            7'b1101111: begin // Jump (JAL)
                jump = 1;
            end
        endcase
    end
endmodule