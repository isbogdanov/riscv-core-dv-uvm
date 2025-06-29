// uvm_classic/monitors/cpu_flow_monitor.sv
//
// Copyright (c) 2025 Igor Bogdanov
// All rights reserved.

class cpu_flow_monitor extends uvm_monitor;

    `uvm_component_utils(cpu_flow_monitor)

    riscv_dut_config cfg;
    virtual cpu_interface.monitor_mp vif;

    uvm_analysis_port#(riscv_flow_transaction) item_collected_port;
    
    logic [31:0] prev_pc;

    function new(string name = "cpu_flow_monitor", uvm_component parent = null);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(riscv_dut_config)::get(this, "", "cfg", cfg))
           `uvm_fatal(get_type_name(), "Could not get configuration object");
        vif = cfg.monitor_vif;
    endfunction

    task automatic run_phase(uvm_phase phase);
        riscv_flow_transaction tx;
        
        @(vif.monitor_cb);
        prev_pc = vif.monitor_cb.current_PC;

        forever begin
            @(vif.monitor_cb);
            
            if (!vif.rst) begin
                tx = riscv_flow_transaction::type_id::create("flow_tx");
                
                tx.current_pc = prev_pc;
                tx.next_pc    = vif.monitor_cb.current_PC;
                
                if (tx.current_pc != tx.next_pc) begin
                    `uvm_info(get_type_name(), $sformatf("Program Flow Transaction: %s", tx.sprint()), UVM_HIGH)
                    item_collected_port.write(tx);
                end
                
                prev_pc = vif.monitor_cb.current_PC;
            end
        end
    endtask

endclass