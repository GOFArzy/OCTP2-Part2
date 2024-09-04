module SevenSegmentDisplay(
    input [3:0] digit,
    output reg [6:0] segments
);
    always @(*) begin
        case(digit)
            4'b0000: segments = 7'b1000000; // 0
            4'b0001: segments = 7'b1111001; // 1
            4'b0010: segments = 7'b0100100; // 2
            4'b0011: segments = 7'b0110000; // 3
            4'b0100: segments = 7'b0011001; // 4
            4'b0101: segments = 7'b0010010; // 5
            4'b0110: segments = 7'b0000010; // 6
            4'b0111: segments = 7'b1111000; // 7
            4'b1000: segments = 7'b0000000; // 8
            4'b1001: segments = 7'b0010000; // 9
            default: segments = 7'b1111111; // Default off
        endcase
    end
endmodule

module FPGA_Interface(
    input CLOCK_50,
    input [1:0] KEY,
    output [6:0] HEX0
);
    wire [31:0] currentPC, nextPC;
    wire clk, reset;
    
    assign clk = ~KEY[0];   // Botão KEY0 como clock
    assign reset = ~KEY[1]; // Botão KEY1 como reset
    
    ProgramCounter pc(
        .clk(clk),
        .reset(reset),
        .nextPC(nextPC),
        .currentPC(currentPC)
    );

    SevenSegmentDisplay display(
        .digit(currentPC[3:0]), // Apenas os 4 bits menos significativos (0-9)
        .segments(HEX0)
    );

    assign nextPC = currentPC + 4;
endmodule