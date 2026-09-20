`timescale 1ns / 1ps

module alu
(
    input  logic [3:0]  alu_ctrl,
    input  logic [31:0] data1,
    input  logic [31:0] data2,
    output logic [31:0] alu_out,
    output logic        Zero
);

    always_comb begin
        case (alu_ctrl)
            4'b0000: alu_out = data1 & data2;                                     // AND
            4'b0001: alu_out = data1 | data2;                                     // OR
            4'b0010: alu_out = data1 + data2;                                     // ADD
            4'b0011: alu_out = data1 << data2[4:0];                               // SLLI
            4'b0110: alu_out = data1 - data2;                                     // SUB
            4'b0111: alu_out = ($signed(data1) < $signed(data2)) ? 32'd1 : 32'd0; // SLT
            4'b1000: alu_out = ($signed(data1) > $signed(data2)) ? 32'd1 : 32'd0; // SGT
            4'b1100: alu_out = ~(data1 | data2);                                  // NOR
            default: alu_out = 32'd0;
        endcase
    end

    assign Zero = (alu_out == 32'd0);

endmodule