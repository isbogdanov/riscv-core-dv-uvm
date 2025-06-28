// uvm_refactored/monitors/cpu_monitor.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Passive monitor that observes processor commit stage signals
// and converts them to UVM transactions for checking
class cpu_monitor extends uvm_monitor;

    `uvm_component_utils(cpu_monitor)

    virtual cpu_interface vif;
    uvm_analysis_port#(riscv_commit_transaction) item_collected_port;

    function new(string name = "cpu_monitor", uvm_component parent = null);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual cpu_interface)::get(this, "", "vif", vif))
           `uvm_fatal(get_type_name(), "Could not get virtual interface");
    endfunction

    // A small struct to hold the pipelined data
    typedef struct {
        logic [31:0] pc;
        logic [31:0] instr;
    } pipeline_item_t;

    task run_phase(uvm_phase phase);
        forever begin
            @(vif.cb);  // Use clocking block for proper sampling timing
            
            if (!vif.rst) begin
                riscv_commit_transaction tx;
                tx = riscv_commit_transaction::type_id::create("tx");
                
                // Sample signals through the clocking block for safe timing
                tx.pc = vif.cb.current_PC;
                tx.instr = vif.cb.instruction;
                
                if (vif.cb.reg_write_o) begin
                    // Instruction with GPR write
                    tx.gpr_write_enable = 1;
                    tx.rd_addr = vif.cb.rd_o;
                    tx.rd_data = vif.cb.rf_rd_value_o;
                end else begin
                    // Instruction without GPR write
                    tx.gpr_write_enable = 0;
                    tx.rd_addr = 0;
                    tx.rd_data = 0;
                end
                
                // Handle x0 register writes (architecturally they don't happen)
                if (tx.rd_addr == 0) begin
                    tx.gpr_write_enable = 0;
                    tx.rd_data = 0;
                end

                `uvm_info(get_type_name(), $sformatf("Instruction Retired: PC=0x%h", tx.pc), UVM_HIGH)
                item_collected_port.write(tx);
            end
        end
    endtask

    // This function decodes the instruction to determine if it performs a write
    // to the general-purpose register file, mimicking the CPU controller logic.
    function bit is_gpr_write(logic [31:0] instr);
        logic [6:0] opcode = instr[6:0];
        logic is_r_type = (opcode == 7'b0110011);
        logic is_i_type = (opcode == 7'b0010011) || (opcode == 7'b0000011) || (opcode == 7'b1100111);
        logic is_u_type = (opcode == 7'b0110111) || (opcode == 7'b0010111);
        logic is_j_type = (opcode == 7'b1101111);
        logic is_csr_type = (opcode == 7'b1110011);
        return is_r_type || is_i_type || is_u_type || is_j_type || is_csr_type;
    endfunction

endclass 