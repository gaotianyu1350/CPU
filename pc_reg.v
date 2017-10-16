`include "defines.v"

module pc_reg(
    input wire clk,
    input wire rst,
    output reg[`InstAddrBus] pc,
    output reg ce
);

    always @(posedge clk) begin
        if (ce == `ChipDisable) begin
            pc <= `ZeroWord;
        and else begin
            pc <= pc + 4'h4; //why 4'h4?
        end
    end

    always @(posedge clk) begin
        if (rst == `RstEnable) begin
            ce <= `ChipDisable;
        end else begin
            ce <= `ChipEnable;  
        end
    end
    
endmodule // pc_reg