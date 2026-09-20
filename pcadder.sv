`timescale 1ns / 1ps

module pcadder
(
    input  logic [31:0] pc_out,
    output logic [31:0] adder_out
);

    assign adder_out = pc_out + 32'd4;

endmodule
