`timescale 1ns / 1ps
module immediateGenerator
(
    input  logic [31:0] inst,
    output logic [31:0] immout
);

    logic [6:0] opcode;
    assign opcode = inst[6:0];

    always_comb begin
        case(opcode)

            // I-type: LW
            7'b0000011: begin
                immout = {{20{inst[31]}}, inst[31:20]};
            end

            // I-type: ADDI, SLLI
            7'b0010011: begin
                if (inst[14:12] == 3'b001) begin
                    // SLLI (Shift Amount)
                    immout = {27'b0, inst[24:20]};
                end
                else begin
                    // ADDI
                    immout = {{20{inst[31]}}, inst[31:20]};
                end
            end

            // S-type: SW
            7'b0100011: begin
                immout = {{20{inst[31]}}, inst[31:25], inst[11:7]};
            end

            // B-type: BEQ
            7'b1100011: begin
                immout = {{19{inst[31]}},
                          inst[31],
                          inst[7],
                          inst[30:25],
                          inst[11:8],
                          1'b0};
            end

            default: begin
                immout = 32'h00000000;
            end

        endcase
    end

endmodule