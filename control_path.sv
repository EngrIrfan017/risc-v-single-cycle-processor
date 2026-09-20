`timescale 1ns / 1ps

module control_path
(
    input  logic [31:0] inst,
    output reg          branch,
    output reg          mem_rd,
    output reg          mem2reg,
    output reg          mem_write,
    output reg          alu_scr,
    output reg          reg_write,
    output reg  [1:0]   alu_op
);

    logic [6:0] opcode;
    assign opcode = inst[6:0];

    always_comb begin
        case(opcode)

            7'b0000011: begin  // LW
                branch    = 1'b0;
                mem_rd    = 1'b1;
                mem2reg   = 1'b1;
                mem_write = 1'b0;
                alu_scr   = 1'b1;
                reg_write = 1'b1;
                alu_op    = 2'b00;
            end

            7'b0010011: begin  // ADDI, SLLI
                branch    = 1'b0;
                mem_rd    = 1'b0;
                mem2reg   = 1'b0;
                mem_write = 1'b0;
                alu_scr   = 1'b1;
                reg_write = 1'b1;
           // ADDI uses alu_op=00, SLLI uses alu_op=10
                if(inst[14:12] == 3'b000)
                    alu_op = 2'b00;
                else
                    alu_op = 2'b10;
            end

            7'b0100011: begin  // SW
                branch    = 1'b0;
                mem_rd    = 1'b0;
                mem2reg   = 1'b0;
                mem_write = 1'b1;
                alu_scr   = 1'b1;
                reg_write = 1'b0;
                alu_op    = 2'b00;
            end

            7'b1100011: begin  // BEQ
                branch    = 1'b1;
                mem_rd    = 1'b0;
                mem2reg   = 1'b0;
                mem_write = 1'b0;
                alu_scr   = 1'b0;
                reg_write = 1'b0;
                alu_op    = 2'b01;
            end

            7'b0110011: begin  // R-type (ADD, SUB)
                branch    = 1'b0;
                mem_rd    = 1'b0;
                mem2reg   = 1'b0;
                mem_write = 1'b0;
                alu_scr   = 1'b0;
                reg_write = 1'b1;
                alu_op    = 2'b10;
            end

            default: begin
                branch    = 1'b0;
                mem_rd    = 1'b0;
                mem2reg   = 1'b0;
                mem_write = 1'b0;
                alu_scr   = 1'b0;
                reg_write = 1'b0;
                alu_op    = 2'b00;
            end

        endcase
    end

endmodule
