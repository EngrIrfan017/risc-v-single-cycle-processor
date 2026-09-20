`timescale 1ns / 1ps

module andGate
(
    input  logic a,
    input  logic b,
    output logic c
);

    assign c = a & b;

endmodule
