module DataMemory(
    input clk,
    input memWrite,
    input [31:0] address,
    input [31:0] writeData,
    output reg [31:0] readData
);
    reg [31:0] memory [0:255];

    always @(posedge clk) begin
        if (memWrite)
            memory[address[9:2]] <= writeData;
    end

    always @(*) begin
        readData = memory[address[9:2]];
    end
endmodule