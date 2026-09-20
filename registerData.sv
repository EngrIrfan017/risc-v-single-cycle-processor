`timescale 1ns / 1ps
module registerData
(
    input  logic        clk,
    input  logic        reset,
    input  logic        write_en,
    input  logic [31:0] inst,
    input  logic [31:0] data_w,
    output logic [31:0] data1,
    output logic [31:0] data2
);

    logic [31:0] reg_file [0:31];

    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;

    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign rd  = inst[11:7];

    // synchronous write with reset
    always_ff@(posedge clk) begin
        if(reset) begin
            reg_file[0]  <= 32'h00000000;
            reg_file[1]  <= 32'h00000000;
            reg_file[2]  <= 32'h00000000;
            reg_file[3]  <= 32'h00000000;
            reg_file[4]  <= 32'h00000000;
            reg_file[5]  <= 32'h00000000;
            reg_file[6]  <= 32'h00000000;
            reg_file[7]  <= 32'h00000000;
            reg_file[8]  <= 32'h00000000;
            reg_file[9]  <= 32'h00000000;
            reg_file[10] <= 32'h00000000;
            reg_file[11] <= 32'h00000000;
            reg_file[12] <= 32'h00000000;
            reg_file[13] <= 32'h00000000;
            reg_file[14] <= 32'h00000000;
            reg_file[15] <= 32'h00000000;
            reg_file[16] <= 32'h00000000;
            reg_file[17] <= 32'h00000000;
            reg_file[18] <= 32'h00000000;
            reg_file[19] <= 32'h00000000;
            reg_file[20] <= 32'h00000000;
            reg_file[21] <= 32'h00000000;
            reg_file[22] <= 32'h00000000;
            reg_file[23] <= 32'h00000000;
            reg_file[24] <= 32'h00000000;
            reg_file[25] <= 32'h00000000;
            reg_file[26] <= 32'h00000000;
            reg_file[27] <= 32'h00000000;
            reg_file[28] <= 32'h00000000;
            reg_file[29] <= 32'h00000000;
            reg_file[30] <= 32'h00000000;
            reg_file[31] <= 32'h00000000;
        end
        else if(write_en && rd != 5'b00000)
            reg_file[rd] <= data_w;
    end

    // asynchronous read
    assign data1 = (rs1 == 5'b00000) ? 32'h00000000 : reg_file[rs1];
    assign data2 = (rs2 == 5'b00000) ? 32'h00000000 : reg_file[rs2];

endmodule