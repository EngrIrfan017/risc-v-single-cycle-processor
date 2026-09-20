`timescale 1ns / 1ps

module data_memory
(
    input  logic        clk,
    input  logic        reset,
    input  logic        mem_write,
    input  logic        mem_read,
    input  logic [31:0] alu_out,
    input  logic [31:0] data2,
    output logic [31:0] dmem_out
);

    logic [31:0] mem [0:255];

    integer i;

    // synchronous write and reset
    always_ff@(posedge clk) begin
        if(reset) begin
            for(i = 0; i < 256; i = i + 1)
                mem[i] <= 32'h00000000;
        end
        else if(mem_write)
            mem[alu_out >> 2] <= data2;
    end

    // asynchronous read
    assign dmem_out = mem_read ? mem[alu_out >> 2] : 32'h00000000;

endmodule
