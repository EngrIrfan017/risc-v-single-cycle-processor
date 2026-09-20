`timescale 1ns / 1ps
module pc #(
            parameter int WIDTH = 32
)(          
            input logic clk,
            input logic rst,
            input logic [WIDTH - 1 : 0] mux_out,
            output logic [WIDTH - 1 : 0] pc_out
    );
    
    always_ff@(posedge clk) begin
        if(rst)
            pc_out <= {WIDTH{1'b0}};
        else
            pc_out <= mux_out;
    end
endmodule
