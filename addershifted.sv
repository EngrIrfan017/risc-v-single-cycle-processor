`timescale 1ns / 1ps

module addershifted
(
    input  logic [31:0] pc_out,
    input  logic [31:0] imm_out,
    output logic [31:0] addsh_out
);

    assign addsh_out = pc_out + imm_out;

endmodule
