// uvm_classic/config/riscv_dut_config.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class riscv_dut_config extends uvm_object;
    `uvm_object_utils(riscv_dut_config)

    // Virtual interface handles for different component types
    virtual cpu_interface.monitor_mp monitor_vif;
    virtual cpu_interface.driver_mp  driver_vif;
    
    // Spike reference configuration
    string spike_log_path = "";         // Path to Spike reference log
    string mem_file_path = "";          // Path to memory initialization file

    function new(string name = "riscv_dut_config");
        super.new(name);
        `uvm_info("CONFIG", $sformatf("Created riscv_dut_config object: %s", name), UVM_MEDIUM)
    endfunction

    function bit is_valid();
        if (monitor_vif == null) begin
            `uvm_error("CONFIG", "Monitor virtual interface not set in riscv_dut_config")
            return 0;
        end
        if (driver_vif == null) begin
            `uvm_error("CONFIG", "Driver virtual interface not set")
            return 0;
        end
        if (spike_log_path == "") begin
            `uvm_warning("CONFIG", "Spike log path not provided")
        end
        return 1;
    endfunction

    function void print_config();
        `uvm_info("CONFIG", $sformatf("RISC-V DUT Configuration:"), UVM_LOW)
        `uvm_info("CONFIG", $sformatf("  spike_log_path: %s", spike_log_path), UVM_LOW)
        `uvm_info("CONFIG", $sformatf("  mem_file_path: %s", mem_file_path), UVM_LOW)
    endfunction

endclass 