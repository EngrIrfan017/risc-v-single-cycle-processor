`timescale 1ns / 1ps
module tb_riscv_top;
    logic clk;
    logic reset;
    riscv_top uut(.clk   (clk),.reset (reset));
    always #5 clk = ~clk;
    initial begin
        clk   = 0;
        reset = 1;
        @(posedge clk); #1;
        @(posedge clk); #1;
        reset = 0;
        repeat(100) @(posedge clk);
        $finish;
    end
endmodule