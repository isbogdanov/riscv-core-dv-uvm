// uvm_classic/monitors/cpu_commit_monitor.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Passive monitor that observes processor commit stage signals
// and converts them to UVM transactions for checking
// Uses clocking block for consistent timing discipline with future drivers
class cpu_commit_monitor extends uvm_monitor;

    `uvm_component_utils(cpu_commit_monitor)

    // Get the entire config object
    riscv_dut_config cfg;
    // Local handle for convenience
    virtual cpu_interface.monitor_mp vif;

    uvm_analysis_port#(riscv_commit_transaction) item_collected_port;

    function new(string name = "cpu_commit_monitor", uvm_component parent = null);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Get the config object from the database
        if(!uvm_config_db#(riscv_dut_config)::get(this, "", "cfg", cfg))
           `uvm_fatal(get_type_name(), "Could not get configuration object");
        // Assign the vif from the config object
        vif = cfg.monitor_vif;
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(vif.monitor_cb);  // Use the correct clocking block name
            
            if (!vif.rst) begin
                riscv_commit_transaction tx;
                tx = riscv_commit_transaction::type_id::create("tx");
                
                // Sample signals through the clocking block for safe timing
                tx.pc = vif.monitor_cb.current_PC;
                tx.instr = vif.monitor_cb.instruction;
                
                if (vif.monitor_cb.reg_write_o) begin
                    // Instruction with GPR write
                    tx.gpr_write_enable = 1;
                    tx.rd_addr = vif.monitor_cb.rd_o;
                    tx.rd_data = vif.monitor_cb.rf_rd_value_o;
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

endclass 