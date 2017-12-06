`include "defines.v"

module ctrl(
    input wire clk,
    input wire rst,
    input wire stallreq_from_id,
    input wire stallreq_from_ex,
    input wire stallreq_from_mem,
    input wire mem_we_i,
    output reg[5:0] stall,

    // Exception
    input wire[31:0] excepttype_i,
    input wire[`RegBus] cp0_epc_i,
    output reg mem_we_o,
    output reg[`RegBus] new_pc,
    output reg flush
);

    reg pause_for_store;

    always @(posedge clk) begin
        if (rst == `RstEnable) begin
            pause_for_store <= 1'b0;
        end else begin
            if (mem_we_i == 1'b1) begin
                pause_for_store <= ~pause_for_store;
            end
        end
    end

    always @(*) begin
        if (rst == `RstEnable) begin
            stall <= 6'b000000;
            flush <= 1'b0;
            new_pc <= `ZeroWord;
            mem_we_o <= 1'b0;
        end else if (excepttype_i != `ZeroWord) begin
            flush <= 1'b1;
            stall <= 6'b000000;
            mem_we_o <= 1'b0;
            case (excepttype_i)
                32'h00000001: begin
                    new_pc <= 32'h80000380;
                end
                32'h00000008: begin
                    new_pc <= 32'h80000380;
                end
                32'h0000000a: begin
                    new_pc <= 32'h80000380;
                end
                32'h0000000d: begin
                    new_pc <= 32'h80000380;
                end
                32'h0000000c: begin
                    new_pc <= 32'h80000380;
                end
                32'h0000000e: begin
                    new_pc <= cp0_epc_i;
                end
                32'h0000000f: begin
                    new_pc <= 32'h80000380; // need to be change to uCore
                end
                default: begin
                end
            endcase // excepttype_i
        end else if (stallreq_from_ex == `Stop) begin
            stall <= 6'b001111;
            flush <= 1'b0; 
            mem_we_o <= 1'b0;
        end else if (stallreq_from_id == `Stop) begin
            stall <= 6'b000111;
            flush <= 1'b0; 
            mem_we_o <= 1'b0;
        end else if (mem_we_i == 1'b1 && pause_for_store == 1'b0) begin
            stall <= 6'b011111;
            flush <= 1'b0;
            mem_we_o <= 1'b0;
        end else if (mem_we_i == 1'b1 && pause_for_store == 1'b1) begin
            stall <= 6'b001111;
            flush <= 1'b0;
            mem_we_o <= 1'b1;
        end else if (stallreq_from_mem == `Stop) begin
            stall <= 6'b000011;
            flush <= 1'b0;
            mem_we_o <= 1'b0;
        end else begin
            stall <= 6'b000000; 
            flush <= 1'b0; 
            new_pc <= `ZeroWord;
            mem_we_o <= 1'b0;
        end
    end

endmodule // ctrl 