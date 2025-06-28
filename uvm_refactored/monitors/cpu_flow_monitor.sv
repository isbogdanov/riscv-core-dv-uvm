// uvm_refactored/monitors/cpu_flow_monitor.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

// Passive monitor that observes the processor's program counter (PC).
// It captures PC changes and broadcasts them as riscv_flow_transaction objects.
class cpu_flow_monitor extends uvm_monitor;

    `uvm_component_utils(cpu_flow_monitor)

    virtual cpu_interface.monitor_mp vif;
    uvm_analysis_port#(riscv_flow_transaction) item_collected_port;
    
    // Internal state to track the PC from the previous cycle
    logic [31:0] prev_pc;

    function new(string name = "cpu_flow_monitor", uvm_component parent = null);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual cpu_interface.monitor_mp)::get(this, "", "vif", vif))
           `uvm_fatal(get_type_name(), "Could not get virtual monitor interface");
    endfunction

    task automatic run_phase(uvm_phase phase);
        riscv_flow_transaction tx;
        
        // Initialize prev_pc on the first cycle after reset
        @(vif.cb);
        prev_pc = vif.cb.current_PC;

        forever begin
            @(vif.cb);
            
            if (!vif.rst) begin
                tx = riscv_flow_transaction::type_id::create("flow_tx");
                
                tx.current_pc = prev_pc;
                tx.next_pc    = vif.cb.current_PC;
                
                // Only broadcast if the PC actually changed.
                if (tx.current_pc != tx.next_pc) begin
                    `uvm_info(get_type_name(), $sformatf("Program Flow Transaction: %s", tx.sprint()), UVM_HIGH)
                    item_collected_port.write(tx);
                end
                
                // Update the previous PC for the next cycle
                prev_pc = vif.cb.current_PC;
            end
        end
    endtask

endclass 