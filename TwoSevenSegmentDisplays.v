module TwoSevenSegmentDisplays(
    input [4:0] value, // Para exibir valores de 0 a 31
    output [6:0] HEX0,
    output [6:0] HEX1
);
    wire [3:0] digit0 = value % 10;
    wire [3:0] digit1 = value / 10;

    SevenSegmentDisplay disp0(
        .digit(digit0),
        .segments(HEX0)
    );

    SevenSegmentDisplay disp1(
        .digit(digit1),
        .segments(HEX1)
    );
endmodule

module FPGA_Interface_Extended(
    input CLOCK_50,
    input [1:0] KEY,
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [9:0] LEDR
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

    TwoSevenSegmentDisplays display(
        .value(currentPC[4:0]), // Apenas os 5 bits menos significativos (0-31)
        .HEX0(HEX0),
        .HEX1(HEX1)
    );

    assign LEDR = currentPC[9:0]; // Mostrar parte do registrador nos LEDs

    assign nextPC = currentPC + 4;
endmodule
