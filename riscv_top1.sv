`timescale 1ns / 1ps
module riscv_top
(
    input  logic clk,
    input  logic reset
);
    logic [31:0] pc_out;
    logic [31:0] adder_out;
    logic [31:0] addsh_out;
    logic [31:0] pc_next;

    logic [31:0] inst;

    logic        branch;
    logic        mem_rd;
    logic        mem2reg;
    logic        mem_write;
    logic        alu_scr;
    logic        reg_write;
    logic [1:0]  alu_op;

    logic [31:0] data1;
    logic [31:0] data2;
    logic [31:0] data_write;

    logic [31:0] imm_out;

    logic [3:0]  alu_ctrl;
    logic [31:0] alu_in;
    logic [31:0] alu_out;
    logic        Zero;

    logic        and_out;

    logic [31:0] dmem_out;

    pc ProgramCounter(
        .clk     (clk),
        .rst     (reset),
        .mux_out (pc_next),
        .pc_out  (pc_out)
    );

    pcadder PC_Adder(
        .pc_out    (pc_out),
        .adder_out (adder_out)
    );

    instructionMemory InstructionMemory(
        .pc_out (pc_out),
        .inst   (inst)
    );

    control_path ControlUnit(
        .inst      (inst),
        .branch    (branch),
        .mem_rd    (mem_rd),
        .mem2reg   (mem2reg),
        .mem_write (mem_write),
        .alu_scr   (alu_scr),
        .reg_write (reg_write),
        .alu_op    (alu_op)
    );

    registerData RegisterFile(
        .clk      (clk),
        .reset    (reset),
        .write_en (reg_write),
        .inst     (inst),
        .data_w   (data_write),
        .data1    (data1),
        .data2    (data2)
    );

    immediateGenerator ImmediateGenerator(
        .inst   (inst),
        .immout (imm_out)
    );

    alu_control ALUControl(
        .alu_op   (alu_op),
        .inst     (inst),
        .alu_ctrl (alu_ctrl)
    );

    mux2X1 ALU_Source_Mux(
        .a       (data2),
        .b       (imm_out),
        .sel     (alu_scr),
        .mux_out (alu_in)
    );

    alu ALU(
        .alu_ctrl (alu_ctrl),
        .data1    (data1),
        .data2    (alu_in),
        .alu_out  (alu_out),
        .Zero     (Zero)
    );

    andGate BranchAndGate(
        .a (branch),
        .b (Zero),
        .c (and_out)
    );

    addershifted BranchTargetAdder(
        .pc_out    (pc_out),
        .imm_out   (imm_out),
        .addsh_out (addsh_out)
    );

    mux2X1 PC_Select_Mux(
        .a       (adder_out),
        .b       (addsh_out),
        .sel     (and_out),
        .mux_out (pc_next)
    );

    data_memory DataMemory(
        .clk       (clk),
        .reset     (reset),
        .mem_write (mem_write),
        .mem_read  (mem_rd),
        .alu_out   (alu_out),
        .data2     (data2),
        .dmem_out  (dmem_out)
    );

    mux2X1 WriteBack_Mux(
        .a       (alu_out),
        .b       (dmem_out),
        .sel     (mem2reg),
        .mux_out (data_write)
    );

endmodule