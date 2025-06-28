// uvm_refactored/config/riscv_dut_config.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class riscv_dut_config extends uvm_object;
    `uvm_object_utils(riscv_dut_config)

    // Virtual interface handle - core requirement for UVM config
    virtual cpu_interface.monitor_mp vif;
    
    // Active/Passive configuration (default to passive for your current implementation)
    uvm_active_passive_enum is_active = UVM_PASSIVE;
    
    // RISC-V specific configuration parameters
    bit enable_commit_checking = 1;     // Enable instruction commit verification
    bit enable_flow_checking = 1;       // Enable control flow verification
    bit enable_memory_checking = 0;     // Future memory interface checking
    
    // Test execution parameters
    int max_instructions = 10000;       // Maximum instructions before timeout
    bit enable_ecall_detection = 1;     // Enable ECALL instruction detection
    
    // Coverage and debug options
    bit enable_instruction_coverage = 1;
    bit enable_waveform_dump = 0;
    bit verbose_monitoring = 0;
    
    // Spike reference configuration
    string spike_log_path = "";         // Path to Spike reference log
    string mem_file_path = "";          // Path to memory initialization file

    function new(string name = "riscv_dut_config");
        super.new(name);
        `uvm_info("CONFIG", $sformatf("Created riscv_dut_config object: %s", name), UVM_MEDIUM)
    endfunction

    // Utility function to validate configuration
    function bit is_valid();
        if (vif == null) begin
            `uvm_error("CONFIG", "Virtual interface not set in riscv_dut_config")
            return 0;
        end
        if (enable_commit_checking && spike_log_path == "") begin
            `uvm_warning("CONFIG", "Commit checking enabled but no Spike log path provided")
        end
        return 1;
    endfunction

    // Utility function to print configuration
    function void print_config();
        `uvm_info("CONFIG", $sformatf("RISC-V DUT Configuration:"), UVM_LOW)
        `uvm_info("CONFIG", $sformatf("  is_active: %s", is_active.name()), UVM_LOW)
        `uvm_info("CONFIG", $sformatf("  enable_commit_checking: %0b", enable_commit_checking), UVM_LOW)
        `uvm_info("CONFIG", $sformatf("  enable_flow_checking: %0b", enable_flow_checking), UVM_LOW)
        `uvm_info("CONFIG", $sformatf("  max_instructions: %0d", max_instructions), UVM_LOW)
        `uvm_info("CONFIG", $sformatf("  spike_log_path: %s", spike_log_path), UVM_LOW)
        `uvm_info("CONFIG", $sformatf("  mem_file_path: %s", mem_file_path), UVM_LOW)
    endfunction

endclass 