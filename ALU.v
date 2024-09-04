module ALU(
    input [31:0] srcA,
    input [31:0] srcB,
    input [3:0] aluControl,
    output reg [31:0] aluResult,
    output zero
);
    assign zero = (aluResult == 0);

    always @(*) begin
        case(aluControl)
            4'b0000: aluResult = srcA + srcB; // ADD
            4'b0001: aluResult = srcA - srcB; // SUB
            4'b0010: aluResult = srcA & srcB; // AND
            4'b0011: aluResult = srcA | srcB; // OR
            4'b0101: aluResult = srcA << srcB[4:0]; // SLL
            default: aluResult = 32'b0;
        endcase
    end
endmodule