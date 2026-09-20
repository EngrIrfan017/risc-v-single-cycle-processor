`timescale 1ns / 1ps

module alu_control
(
    input  logic [1:0]  alu_op,
    input  logic [31:0] inst,
    output logic [3:0]  alu_ctrl
);

    logic [2:0] funct3;
    logic       funct7;

    assign funct3 = inst[14:12];
    assign funct7 = inst[30];

    always_comb begin
        case (alu_op)

            // LW, SW, ADDI
            2'b00: begin
                alu_ctrl = 4'b0010;    // ADD
            end

            // BEQ
            2'b01: begin
                alu_ctrl = 4'b0110;    // SUB
            end

            // R-type and SLLI
            2'b10: begin
                case (funct3)

                    // ADD / SUB
                    3'b000: begin
                        if (funct7)
                            alu_ctrl = 4'b0110;   // SUB
                        else
                            alu_ctrl = 4'b0010;   // ADD
                    end

                    // SLLI
                    3'b001: alu_ctrl = 4'b0011;

                    // SLT
                    3'b010: alu_ctrl = 4'b0111;

                    // SGT (only if your ALU implements it)
                    3'b011: alu_ctrl = 4'b1000;

                    // XOR
                    3'b100: alu_ctrl = 4'b0101;

                    // OR
                    3'b110: alu_ctrl = 4'b0001;

                    // AND
                    3'b111: alu_ctrl = 4'b0000;

                    default: alu_ctrl = 4'b0010;

                endcase
            end

            default: begin
                alu_ctrl = 4'b0010;
            end

        endcase
    end

endmodule