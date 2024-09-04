module ImmGen(
    input [31:0] instruction,
    output reg [31:0] immOut
);
    always @(*) begin
        case (instruction[6:0])
            7'b0010011, // I-type (ADDI, ANDI, ORI)
            7'b0000011, // Load (LW)
            7'b0001011: // Load halfword (LH)
                immOut = {{20{instruction[31]}}, instruction[31:20]};
            7'b0100011: // Store (SW)
                immOut = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            7'b0101011: // Store halfword (SH)
                immOut = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            7'b1100011: // Branch (BEQ, BNE)
                immOut = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            7'b1101111: // Jump (JAL)
                immOut = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            default: 
                immOut = 32'b0;
        endcase
    end
endmodule