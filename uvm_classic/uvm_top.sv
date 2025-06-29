`timescale 1ns/1ps;
`include "uvm_macros.svh"

module uvm_top;
    import uvm_pkg::*;
    import riscv_uvm_pkg::*;

    logic clock;
    logic rst;
    
    cpu_interface cpu_if_inst(clock, rst);

    data_memory data_mem (
        .mem_read(cpu_if_inst.mem_read),
        .mem_write(cpu_if_inst.mem_write),
        .address(cpu_if_inst.address),
        .write_data(cpu_if_inst.mem_write_data),
        .read_data(cpu_if_inst.mem_read_data),
        .clk(clock),
        .rst(rst)
    );

    initial begin
        $display("[UVM_TOP] UVM instruction driver is ACTIVE - hardware memory DISABLED");
    end

    cpu_top dut (
        .clock(clock),
        .rst(rst),
        .instruction(cpu_if_inst.instruction),
        .current_PC(cpu_if_inst.current_PC),
        .mem_read(cpu_if_inst.mem_read),
        .mem_write(cpu_if_inst.mem_write),
        .address(cpu_if_inst.address),
        .mem_write_data(cpu_if_inst.mem_write_data),
        .mem_read_data(cpu_if_inst.mem_read_data),
        .reg_write_o(cpu_if_inst.reg_write_o),
        .rd_o(cpu_if_inst.rd_o),
        .rf_rd_value_o(cpu_if_inst.rf_rd_value_o)
    );

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    initial begin
        uvm_config_db#(virtual cpu_interface.monitor_mp)::set(null, "uvm_test_top.*", "monitor_vif", cpu_if_inst.monitor_mp);
        uvm_config_db#(virtual cpu_interface.driver_mp)::set(null, "uvm_test_top.*", "driver_vif", cpu_if_inst.driver_mp);
        
        run_test(); 
    end

    always @(posedge clock) begin
        if (!rst && cpu_if_inst.instruction == 32'h00000073) begin
            $display("ECALL instruction detected at PC=0x%h. Test will complete via UVM.", cpu_if_inst.current_PC);
        end
    end

endmodule 