`timescale 1ns / 1ps

module mux2X1
(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic        sel,
    output logic   [31:0] mux_out
);

    always_comb begin
        case(sel)
            1'b0: mux_out = a;
            1'b1: mux_out = b;
        endcase
    end

endmodule
