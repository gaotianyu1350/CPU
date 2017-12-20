`include "defines.v"

module mem(
    input wire rst,
    // From ex
    input wire[`RegAddrBus] wd_i,
    input wire wreg_i,
    input wire[`RegBus] wdata_i,
    input wire[`RegBus] hi_i,
    input wire[`RegBus] lo_i,
    input wire whilo_i,
    // L&S
    input wire[`AluOpBus] aluop_i,
    input wire[`RegBus] mem_addr_i,
    input wire[`RegBus] reg2_i,
    input wire[`RegBus] mem_data_i,
    // To wb
    output reg[`RegAddrBus] wd_o,
    output reg wreg_o,
    output reg[`RegBus] wdata_o,
    output reg[`RegBus] hi_o,
    output reg[`RegBus] lo_o,
    output reg whilo_o,
    // L&S
    output reg[`RegBus] mem_addr_o,
    output wire mem_we_o,
    output reg[3:0] mem_sel_o,
    output reg[`RegBus] mem_data_o,
    output reg mem_ce_o,
    // TLB/MMU
    output wire[`InstAddrBus] virtual_addr,
    input wire tlb_hit,
    input wire[`InstAddrBus] physical_addr,
    // CP0
    input wire cp0_reg_we_i,
    input wire[4:0] cp0_reg_write_addr_i,
    input wire[`RegBus] cp0_reg_data_i,
    output reg cp0_reg_we_o,
    output reg[4:0] cp0_reg_write_addr_o,
    output reg[`RegBus] cp0_reg_data_o,
    // Exception
    input wire[31:0] excepttype_i,
    input wire is_in_delay_slot_i,
    input wire[`RegBus] current_inst_address_i,
    input wire[`RegBus] cp0_status_i,
    input wire[`RegBus] cp0_cause_i,
    input wire[`RegBus] cp0_epc_i,
    input wire wb_cp0_reg_we,
    input wire[4:0] wb_cp0_reg_write_addr,
    input wire[`RegBus] wb_cp0_reg_data,
    output reg[31:0] excepttype_o,
    output wire[`RegBus] cp0_epc_o,
    output wire is_in_delay_slot_o,
    output wire[`RegBus] current_inst_address_o,
    output reg[`InstAddrBus] bad_address,
    input wire[`RegBus] inst_i,
    output wire[`RegBus] inst_o
);

    wire[`RegBus] zero32;
    reg mem_we;
    // Exception
    reg[`RegBus] cp0_status;
    reg[`RegBus] cp0_cause;
    reg[`RegBus] cp0_epc;

    assign zero32 = `ZeroWord;

    assign virtual_addr = mem_addr_i;

    assign is_in_delay_slot_o = is_in_delay_slot_i;
    assign current_inst_address_o =  current_inst_address_i;
    assign inst_o = inst_i;

    always @ (*) begin
        if (rst == `RstEnable) begin
            cp0_status <= `ZeroWord;
        end else if ((wb_cp0_reg_we == `WriteEnable) && (wb_cp0_reg_write_addr == `CP0_REG_STATUS)) begin
            cp0_status <= wb_cp0_reg_data;
        end else begin
            cp0_status <= cp0_status_i;
        end            
    end

    always @ (*) begin
        if (rst == `RstEnable) begin
            cp0_epc <= `ZeroWord;
        end else if ((wb_cp0_reg_we == `WriteEnable) && (wb_cp0_reg_write_addr == `CP0_REG_EPC)) begin
            cp0_epc <= wb_cp0_reg_data;
        end else begin
            cp0_epc <= cp0_epc_i;
        end            
    end

    assign cp0_epc_o = cp0_epc;

    always @ (*) begin
        if (rst == `RstEnable) begin
            cp0_cause <= `ZeroWord;
        end else if ((wb_cp0_reg_we == `WriteEnable) && (wb_cp0_reg_write_addr == `CP0_REG_CAUSE)) begin
            cp0_cause[9:8] = wb_cp0_reg_data[9:8];
            cp0_cause[22] = wb_cp0_reg_data[22];
            cp0_cause[23] = wb_cp0_reg_data[23];
        end else begin
            cp0_cause <= cp0_cause_i;
        end
    end

    always @ (*) begin
        if (rst == `RstEnable) begin
            excepttype_o <= `ZeroWord;
            bad_address <= `ZeroWord;
        end else begin
            excepttype_o <= `ZeroWord;
            bad_address <= `ZeroWord;
            //if (current_inst_address_i != `ZeroWord) begin // ?
            if (((cp0_cause[15:8] & cp0_status[15:8]) != 8'h00) && (cp0_status[1] == 1'b0) && (cp0_status[0] == 1'b1)) begin
                // 空指令控制
                excepttype_o <= 32'h00000001;
            end else if (excepttype_i[8] == 1'b1) begin
                excepttype_o <= 32'h00000008;
            end else if (excepttype_i[9] == 1'b1) begin
                excepttype_o <= 32'h0000000a;
            end else if (excepttype_i[10] == 1'b1) begin
                excepttype_o <= 32'h0000000d;
            end else if (excepttype_i[11] == 1'b1) begin
                excepttype_o <= 32'h0000000c;
            end else if (excepttype_i[12] == 1'b1) begin
                excepttype_o <= 32'h0000000e;
            end else if (excepttype_i[13] == 1'b1) begin
                excepttype_o <= 32'h0000000f;
                bad_address <= current_inst_address_i;
            end else if (tlb_hit == 1'b0 && mem_ce_o == 1'b1 && mem_we == `WriteDisable) begin
                excepttype_o <= 32'h0000000f;
                bad_address <= mem_addr_i;
            end else if (tlb_hit == 1'b0 && mem_ce_o == 1'b1 && mem_we == `WriteEnable) begin
                excepttype_o <= 32'h0000000b;
                bad_address <= mem_addr_i;
            end 
            //end
        end
    end

    assign mem_we_o = mem_we & (~(|excepttype_o));

    always @ (*) begin
        if (rst == `RstEnable) begin
            wd_o <= `NOPRegAddr;
            wreg_o <= `WriteDisable;
            wdata_o <= `ZeroWord;
            hi_o <= `ZeroWord;
            lo_o <= `ZeroWord;
            whilo_o <= `WriteDisable;
            mem_addr_o <= `ZeroWord;
            mem_we <= `WriteDisable;
            mem_sel_o <= 4'b0000;
            mem_data_o <= `ZeroWord;
            mem_ce_o <= `ChipDisable;
            cp0_reg_we_o <= `WriteDisable;
            cp0_reg_write_addr_o <= 5'b00000;
            cp0_reg_data_o <= `ZeroWord;
        end else begin
            wd_o <= wd_i;
            wreg_o <= wreg_i;
            wdata_o <= wdata_i;
            hi_o <= hi_i;
            lo_o <= lo_i;
            whilo_o <= whilo_i;
            mem_addr_o <= `ZeroWord;
            mem_we <= `WriteDisable;
            mem_sel_o <= 4'b1111;
            mem_ce_o <= `ChipDisable;
            cp0_reg_we_o <= cp0_reg_we_i;
            cp0_reg_write_addr_o <= cp0_reg_write_addr_i;
            cp0_reg_data_o <= cp0_reg_data_i;
            case (aluop_i)
                `EXE_LB_OP: begin
                    mem_addr_o <= physical_addr;
                    mem_we <= `WriteDisable;
                    mem_ce_o <= `ChipEnable;
                    case (physical_addr[1:0])
                        2'b00: begin
                            wdata_o <= {{24{mem_data_i[7]}}, mem_data_i[7:0]};
                            mem_sel_o <= 4'b0001;
                        end
                        2'b01: begin
                            wdata_o <= {{24{mem_data_i[15]}}, mem_data_i[15:8]};
                            mem_sel_o <= 4'b0010;
                        end
                        2'b10: begin
                            wdata_o <= {{24{mem_data_i[23]}}, mem_data_i[23:16]};
                            mem_sel_o <= 4'b0100;
                        end
                        2'b11: begin
                            wdata_o <= {{24{mem_data_i[31]}}, mem_data_i[31:24]};
                            mem_sel_o <= 4'b1000;
                        end
                        default: begin
                            wdata_o <= `ZeroWord;
                        end 
                    endcase
                end
                `EXE_LBU_OP: begin
                    mem_addr_o <= physical_addr;
                    mem_we <= `WriteDisable;
                    mem_ce_o <= `ChipEnable;
                    case (physical_addr[1:0])
                        2'b00: begin
                            wdata_o <= {{24{1'b0}}, mem_data_i[7:0]};
                            mem_sel_o <= 4'b0001;
                        end
                        2'b01: begin
                            wdata_o <= {{24{1'b0}}, mem_data_i[15:8]};
                            mem_sel_o <= 4'b0010;
                        end
                        2'b10: begin
                            wdata_o <= {{24{1'b0}}, mem_data_i[23:16]};
                            mem_sel_o <= 4'b0100;
                        end
                        2'b11: begin
                            wdata_o <= {{24{1'b0}}, mem_data_i[31:24]};
                            mem_sel_o <= 4'b1000;
                        end
                        default: begin
                            wdata_o <= `ZeroWord;
                        end 
                    endcase
                end
                `EXE_LH_OP: begin
                    mem_addr_o <= physical_addr;
                    mem_we <= `WriteDisable;
                    mem_ce_o <= `ChipEnable;
                    //<TODO> Little endien
                    case (physical_addr[1:0])
                        2'b00: begin
                            wdata_o <= {{16{mem_data_i[15]}}, mem_data_i[15:0]};
                            mem_sel_o <= 4'b0011;
                        end
                        2'b10: begin
                            wdata_o <= {{16{mem_data_i[31]}}, mem_data_i[31:16]};
                            mem_sel_o <= 4'b1100;
                        end
                        default: begin
                            wdata_o <= `ZeroWord;
                        end 
                    endcase
                end 
                `EXE_LHU_OP: begin
                    mem_addr_o <= physical_addr;
                    mem_we <= `WriteDisable;
                    mem_ce_o <= `ChipEnable;
                    case (physical_addr[1:0])
                        2'b00: begin
                            wdata_o <= {{16{1'b0}}, mem_data_i[15:0]};
                            mem_sel_o <= 4'b0011;
                        end
                        2'b10: begin
                            wdata_o <= {{16{1'b0}}, mem_data_i[31:16]};
                            mem_sel_o <= 4'b1100;
                        end
                        default: begin
                            wdata_o <= `ZeroWord;
                        end 
                    endcase
                end
                `EXE_LW_OP: begin
                    mem_addr_o <= physical_addr;
                    mem_we <= `WriteDisable;
                    mem_ce_o <= `ChipEnable;
                    wdata_o <= mem_data_i;
                    mem_sel_o <= 4'b1111;
                end
                `EXE_SB_OP: begin
                    mem_addr_o <= physical_addr;
                    mem_we <= `WriteEnable;
                    mem_ce_o <= `ChipEnable;
                    mem_data_o <= {reg2_i[7:0], reg2_i[7:0], reg2_i[7:0], reg2_i[7:0]};
                    case (physical_addr[1:0])
                        2'b00: begin
                            mem_sel_o <= 4'b0001;
                        end
                        2'b01: begin
                            mem_sel_o <= 4'b0010;
                        end
                        2'b10: begin
                            mem_sel_o <= 4'b0100;
                        end
                        2'b11: begin
                            mem_sel_o <= 4'b1000;
                        end
                        default: begin
                            mem_sel_o <= 4'b0000;
                        end 
                    endcase
                end
                `EXE_SH_OP: begin
                    mem_addr_o <= physical_addr;
                    mem_we <= `WriteEnable;
                    mem_ce_o <= `ChipEnable;
                    mem_data_o <= {reg2_i[15:0], reg2_i[15:0]};
                    case (physical_addr[1:0])
                        2'b00: begin
                            mem_sel_o <= 4'b0011;
                        end
                        2'b10: begin
                            mem_sel_o <= 4'b1100;
                        end
                        default: begin
                            mem_sel_o <= 4'b0000;
                        end 
                    endcase
                end
                `EXE_SW_OP: begin
                    mem_addr_o <= physical_addr;
                    mem_we <= `WriteEnable;
                    mem_ce_o <= `ChipEnable;
                    mem_data_o <= reg2_i;
                    mem_sel_o <= 4'b1111;
                end
                default: begin
                  
                end
            endcase
        end
    end

endmodule // mem