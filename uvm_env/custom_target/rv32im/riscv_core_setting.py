# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is the central configuration for the riscv-dv test generator.
# It defines the capabilities of the target processor.

import math
from pygen_src.riscv_instr_pkg import (
    privileged_reg_t,
    satp_mode_t,
    riscv_instr_group_t,
    mtvec_mode_t,
    privileged_mode_t,
)

# Required parameters for a basic RV32IM core
XLEN = 32
SATP_MODE = satp_mode_t.BARE
supported_privileged_mode = [privileged_mode_t.MACHINE_MODE]
supported_interrupt_mode = [mtvec_mode_t.DIRECT]
NUM_GPR = 32

# Key change: Define the ISA without the 'C' extension
supported_isa = [riscv_instr_group_t.RV32I, riscv_instr_group_t.RV32M]

# All other features are disabled for this basic target
unsupported_instr = []
max_interrupt_vector_num = 16
support_pmp = 0
support_debug_mode = 0
support_umode_trap = 0
support_sfence = 0
support_unaligned_load_store = 1
NUM_FLOAT_GPR = 0
NUM_VEC_GPR = 0
VECTOR_EXTENSION_ENABLE = 0
VLEN = 0
ELEN = 0
SELEN = 0
VELEN = 0
MAX_LMUL = 0
NUM_HARTS = 1

# List of implemented CSRs for this core
implemented_csr = [
    privileged_reg_t.MVENDORID,
    privileged_reg_t.MARCHID,
    privileged_reg_t.MIMPID,
    privileged_reg_t.MHARTID,
    privileged_reg_t.MSTATUS,
    privileged_reg_t.MISA,
    privileged_reg_t.MIE,
    privileged_reg_t.MTVEC,
    privileged_reg_t.MCOUNTEREN,
    privileged_reg_t.MSCRATCH,
    privileged_reg_t.MEPC,
    privileged_reg_t.MCAUSE,
    privileged_reg_t.MTVAL,
    privileged_reg_t.MIP,
]

custom_csr = []
