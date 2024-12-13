`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mips_if(
    input clk,
    input reset,
    output reg [31:0] pc_out,
    output [31:0] instr_out
);
    reg [31:0] instruction_memory [0:255];

    initial begin
        instruction_memory[0] = 32'h8C010000; // LW R1, 0(R0)
        instruction_memory[1] = 32'h8C020004; // LW R2, 4(R0)
        instruction_memory[2] = 32'h00021820; // ADD R3, R1, R2
        instruction_memory[3] = 32'hAC030008; // SW R3, 8(R0)
        instruction_memory[4] = 32'h00000000; // NOP
        instruction_memory[5] = 32'h8C040008; // LW R4, 8(R0)
        instruction_memory[6] = 32'hAC05000C; // SW R5, 12(R0)
    end

    assign instr_out = instruction_memory[pc_out[31:2]]; 

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 32'b0; // Reset PC to 0
        else
            pc_out <= pc_out + 1;
    end
endmodule
