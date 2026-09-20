`timescale 1ns / 1ps
module instructionMemory
(
    input  logic [31:0] pc_out,
    output logic [31:0] inst
);

    logic [31:0] mem [0:31];

    initial begin
        // addi t0, x0, 0
        mem[0]  = 32'h00000293;
        // addi t1, x0, 25
        mem[1]  = 32'h01900313;
        // sw t1, 0(t0)
        mem[2]  = 32'h0062A023;
        // addi t1, x0, 12
        mem[3]  = 32'h00C00313;
        // sw t1, 4(t0)
        mem[4]  = 32'h0062A223;
        // addi t1, x0, 48
        mem[5]  = 32'h03000313;
        // sw t1, 8(t0)
        mem[6]  = 32'h0062A423;
        // addi t1, x0, 7
        mem[7]  = 32'h00700313;
        // sw t1, 12(t0)
        mem[8]  = 32'h0062A623;
        // addi t1, x0, 31
        mem[9]  = 32'h01F00313;
        // sw t1, 16(t0)
        mem[10] = 32'h0062A823;
        // addi t2, x0, 0
        mem[11] = 32'h00000393;
        // addi t3, x0, 0
        mem[12] = 32'h00000E13;
        // addi t4, x0, 5
        mem[13] = 32'h00500E93;
        // beq t3, t4, done
        mem[14] = 32'h01DE0E63;// mem[14] = 32'h01DE0E63;
        // slli t5, t3, 2
        mem[15] = 32'h002E1F13;
        // add t6, t0, t5
        mem[16] = 32'h01E28FB3;
        // lw t1, 0(t6)
        mem[17] = 32'h000FB303;
        // add t2, t2, t1
        mem[18] = 32'h006383B3;
        // addi t3, t3, 1
        mem[19] = 32'h001E0E13;
        // beq x0, x0, loop
        mem[20] = 32'hFE0004E3;
        // beq x0, x0, done
        mem[21] = 32'h00000063;
        // fill remaining with NOP
        mem[22] = 32'h00000013;
        mem[23] = 32'h00000013;
        mem[24] = 32'h00000013;
        mem[25] = 32'h00000013;
        mem[26] = 32'h00000013;
        mem[27] = 32'h00000013;
        mem[28] = 32'h00000013;
        mem[29] = 32'h00000013;
        mem[30] = 32'h00000013;
        mem[31] = 32'h00000013;
    end

    assign inst = mem[pc_out[6:2]];

endmodule
