`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module control(
    input wire [5:0] opcode,
    output reg [3:0] EX,
    output reg [2:0] M,
    output reg [1:0] WB
    );
    
    parameter RTYPE = 6'b000000;
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter BEQ = 6'b000100;
    parameter NOP = 6'b100000;
    
    initial begin
    EX = 0;
    M = 0;
    WB = 0;
    end
    
always @* begin
    case(opcode)
    RTYPE: begin
        EX = 4'b1100;
        M = 3'b000;
        WB = 2'b10;
    end
    LW: begin
        EX = 4'b0001;
        M = 3'b010;
        WB = 2'b11;
    end
    SW: begin
        EX = 4'b0001;
        M = 3'b001;
        WB = 2'b00;
    end
    BEQ: begin
        EX = 4'b0010;
        M = 3'b100;
        WB = 2'b00;
    end  
    LW: begin
        EX = 4'b0000;
        M = 3'b000;
        WB = 2'b00;
    end
    endcase
end
endmodule

module register(
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] writedata,
    input regwrite,
    output reg [31:0] A,
    output reg [31:0] B,
    input clk,
    input rst
);

    reg [31:0] registers [0:31];
    integer i;
    
    always @* begin
        A = registers[rs];
        B = registers[rd];
    end
    
    always @ (posedge clk or rst) begin
        if (rst) begin
            for (i=0; i<32; i= i+1)
                registers[i] <= 0;
        end
    
        if (rd !=0 && regwrite)
            registers [rd] <= writedata;
        end
    end
endmodule

module signextend(
    input [15:0] nextend,
    output reg [31:0] extend
    );
    assign extend = {{16{nextend[15]}}, nextend};
endmodule
