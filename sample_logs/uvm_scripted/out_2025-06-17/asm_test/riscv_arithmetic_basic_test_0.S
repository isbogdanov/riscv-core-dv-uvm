.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x31, h0_start
jalr x0, x31, 0
h0_start:
                  li x27, 0x40000100
                  csrw 0x301, x27
kernel_sp:        
                  la x30, kernel_stack_end

trap_vec_init:    
                  la x27, mtvec_handler
                  ori x27, x27, 0
                  csrw 0x305, x27 # MTVEC

mepc_setup:       
                  la x27, init
                  csrw 0x341, x27

init_machine_mode:
                  li x27, 0x1e00
                  csrw 0x300, x27 # MSTATUS
                  li x27, 0x0
                  csrw 0x304, x27 # MIE
                  mret
init:             
                  li x0, 0xe
                  li x1, 0x217d7172
                  li x2, 0x80000000
                  li x3, 0x4b092a80
                  li x4, 0xf
                  li x5, 0xfe474771
                  li x6, 0xf378a654
                  li x7, 0x7e339585
                  li x8, 0xffa70576
                  li x9, 0x68757fa1
                  li x10, 0x0
                  li x11, 0x4
                  li x12, 0x0
                  li x13, 0x0
                  li x14, 0x4270b421
                  li x15, 0x0
                  li x16, 0x80000000
                  li x17, 0x80000000
                  li x18, 0xf2fa66b1
                  li x19, 0xfb05e176
                  li x20, 0x80000000
                  li x21, 0xc
                  li x22, 0xd
                  li x23, 0x0
                  li x24, 0x0
                  li x25, 0x80000000
                  li x27, 0xe5fefbcb
                  li x28, 0xd
                  li x29, 0x1
                  li x31, 0xf9591f97
                  la x26, user_stack_end
main:             li         t4, 0x49cfc80e #start riscv_int_numeric_corner_stream_11
                  li         s5, 0x0
                  li         t3, 0x1
                  li         a5, 0x0
                  li         s9, 0x0
                  li         s11, 0x0
                  li         s8, 0x0
                  li         s3, 0x0
                  li         a7, 0x0
                  li         a3, 0x1
                  nop
                  add         ra, t5, ra
                  lui         t0, 956406
                  nop
                  add         t3, s9, s4
                  addi        s3, s11, 1414
                  add         s0, a4, zero
                  sub         t4, s1, zero
                  sub         t3, a2, a0
                  addi        sp, s10, 240
                  sub         t4, s9, s0
                  sub         gp, t2, t0
                  addi        gp, a4, 1058
                  lui         a1, 370211
                  nop
                  lui         a5, 220950
                  sub         ra, a6, ra
                  addi        s11, t4, 575
                  add         t2, t2, t0
                  add         s0, t2, s5
                  sub         s11, s6, t4
                  nop
                  addi        s1, a0, 1340
                  lui         a4, 163164
                  lui         a6, 60445 #end riscv_int_numeric_corner_stream_11
                  li         t4, 0x1e824c71 #start riscv_int_numeric_corner_stream_17
                  li         t3, 0x0
                  li         s1, 0x1ae53fb
                  li         s11, 0x0
                  li         s9, 0x6aa2662f
                  li         s6, 0x0
                  li         a3, 0x0
                  li         a1, 0x182e434b
                  li         s3, 0x0
                  li         s8, 0x0
                  addi        s5, t1, -1569
                  lui         zero, 614736
                  add         s1, t5, s9
                  lui         zero, 102925
                  nop
                  lui         s5, 146581
                  sub         zero, s1, a6
                  add         a2, a4, t5
                  sub         a3, s5, s0
                  lui         s4, 920057
                  addi        t2, s9, -1512
                  nop
                  add         t2, a7, s4
                  add         t4, s10, t0
                  add         zero, s1, t4 #end riscv_int_numeric_corner_stream_17
                  li         t3, 0x1 #start riscv_int_numeric_corner_stream_7
                  li         a6, 0x2eaa9bd9
                  li         s11, 0x0
                  li         t1, 0x0
                  li         ra, 0x0
                  li         s9, 0x0
                  li         s0, 0x1736762c
                  li         a7, 0x1
                  li         s8, 0x0
                  li         t4, 0x0
                  addi        t0, s6, -1385
                  sub         zero, s7, s1
                  addi        s6, a0, -192
                  sub         zero, a1, zero
                  nop
                  addi        t4, t5, -1492
                  addi        s3, t1, -1820
                  lui         a5, 465846
                  lui         zero, 841448
                  add         a6, gp, a0
                  lui         s2, 813720
                  sub         s4, s7, a0
                  add         a7, t5, a1
                  add         a5, a2, a3
                  nop
                  add         a6, a3, t4
                  sub         a0, s9, s1
                  lui         a6, 685741
                  add         a4, s3, s4 #end riscv_int_numeric_corner_stream_7
                  li         t4, 0x1 #start riscv_int_numeric_corner_stream_8
                  li         s11, 0x3adc20
                  li         gp, 0x0
                  li         a2, 0x0
                  li         a1, 0x0
                  li         t3, 0x1
                  li         s3, 0x1
                  li         s9, 0x0
                  li         s2, 0x0
                  li         s8, 0x0
                  addi        tp, s4, 1203
                  add         t4, zero, gp
                  addi        t3, a7, 1096
                  add         s6, t2, t0
                  nop
                  lui         s1, 827874
                  lui         a0, 344075
                  sub         gp, a7, a4
                  nop
                  addi        zero, s11, 334
                  addi        t2, t1, 752
                  sub         s0, s8, s0
                  lui         t0, 1008749
                  add         t1, t6, s1
                  addi        zero, t4, 145
                  lui         ra, 550692
                  add         s6, t5, s3
                  nop
                  nop
                  nop
                  nop
                  lui         s1, 238808
                  nop #end riscv_int_numeric_corner_stream_8
                  li         t4, 0x0 #start riscv_int_numeric_corner_stream_1
                  li         t3, 0x1
                  li         s11, 0x0
                  li         s9, 0x0
                  li         a5, 0x1
                  li         s3, 0x1
                  li         t2, 0x0
                  li         a1, 0x0
                  li         s8, 0x0
                  li         s0, 0x33f3c9aa
                  lui         zero, 385089
                  nop
                  lui         t0, 255318
                  addi        s8, gp, 462
                  addi        t4, t5, -1569
                  sub         a3, s7, s5
                  addi        tp, sp, 617
                  sub         zero, a1, t6
                  nop
                  sub         zero, a7, t2
                  addi        zero, t2, 699
                  add         s7, a0, a6
                  add         s5, s1, t3
                  nop
                  nop
                  lui         s3, 161873
                  nop
                  nop
                  add         zero, zero, t6
                  sub         s11, a5, zero
                  addi        zero, zero, -238
                  lui         t3, 16164
                  add         ra, s10, zero #end riscv_int_numeric_corner_stream_1
                  li         t4, 0x0 #start riscv_int_numeric_corner_stream_4
                  li         t3, 0x0
                  li         s11, 0x1
                  li         s9, 0x0
                  li         s8, 0xf48d0
                  li         t1, 0x0
                  li         s1, 0x0
                  li         a4, 0x6bbd4e97
                  li         s3, 0x1
                  li         s4, 0x0
                  lui         s4, 187403
                  lui         a2, 674970
                  sub         s1, t0, zero
                  sub         t3, s0, s0
                  lui         t2, 739558
                  sub         a7, s3, a7
                  sub         s1, zero, s5
                  add         a0, s0, ra
                  nop
                  sub         ra, t0, s7
                  lui         gp, 943553
                  nop
                  sub         a4, s4, s0
                  nop
                  add         s3, a3, a6
                  lui         a2, 760965
                  nop
                  nop #end riscv_int_numeric_corner_stream_4
                  li         s0, 0x83b92d2 #start riscv_int_numeric_corner_stream_0
                  li         t4, 0x69b2d02e
                  li         sp, 0x6a72de66
                  li         a6, 0x1
                  li         t3, 0x1
                  li         s11, 0x0
                  li         a1, 0x0
                  li         gp, 0x0
                  li         t1, 0x46b4bbca
                  li         s9, 0x0
                  add         s4, s3, s0
                  add         t3, s1, zero
                  lui         zero, 937656
                  sub         s6, s5, ra
                  lui         a1, 625220
                  lui         a1, 12658
                  nop
                  lui         zero, 419455
                  nop
                  addi        a5, gp, 1098
                  add         s5, t6, s11
                  nop
                  addi        s1, a5, -300
                  nop
                  lui         s6, 1022021
                  lui         s6, 109780
                  sub         s8, s2, s10
                  add         s0, s10, s9
                  add         ra, sp, s9
                  nop
                  sub         s7, s6, a4
                  add         a4, s9, t1
                  sub         tp, gp, a3
                  sub         t3, a5, a0
                  nop
                  add         s1, t1, s8
                  add         t2, gp, a7
                  sub         a1, gp, t3
                  add         t0, a4, t6
                  add         s0, t1, tp #end riscv_int_numeric_corner_stream_0
                  li         s0, 0x5234bed1 #start riscv_int_numeric_corner_stream_5
                  li         t4, 0x1
                  li         t3, 0x52656a8f
                  li         s8, 0x0
                  li         sp, 0x0
                  li         a3, 0x1
                  li         a2, 0x0
                  li         a0, 0x26321c32
                  li         s9, 0x0
                  li         s1, 0x5c07ced9
                  lui         s7, 921198
                  lui         s1, 778493
                  nop
                  add         zero, a2, a2
                  nop
                  sub         zero, a6, t5
                  nop
                  lui         t1, 603744
                  add         s1, t3, a1
                  add         s9, t0, s3
                  sub         s8, t5, t0
                  add         s3, s7, a5
                  addi        s11, a3, -605
                  sub         s5, a4, s5
                  nop
                  lui         s3, 754800
                  sub         a7, a2, a2
                  addi        s11, tp, -2000
                  nop
                  nop
                  add         a7, s5, a7
                  sub         s7, t0, t1
                  lui         sp, 762343
                  add         t2, t4, a2
                  lui         s1, 904271
                  lui         s7, 570816
                  lui         s3, 576800 #end riscv_int_numeric_corner_stream_5
                  li         t0, 0x0 #start riscv_int_numeric_corner_stream_13
                  li         s8, 0x10fb25fa
                  li         s0, 0x0
                  li         t4, 0x41852cca
                  li         t3, 0x0
                  li         a2, 0x1
                  li         s6, 0x0
                  li         a4, 0x0
                  li         s4, 0x0
                  li         s9, 0x0
                  add         a1, t2, s10
                  addi        t2, t1, 456
                  nop
                  nop
                  add         s2, s8, s2
                  add         s6, a5, s9
                  lui         ra, 602059
                  add         t2, s10, s4
                  add         t2, s11, s10
                  addi        a0, a7, -1743
                  add         s11, s4, a6
                  nop
                  add         a6, a5, t6
                  lui         s3, 1022766
                  nop
                  addi        a7, t0, -135
                  nop
                  sub         s1, s5, s10
                  addi        a5, s1, -220
                  nop
                  sub         s8, tp, a5
                  lui         zero, 708130 #end riscv_int_numeric_corner_stream_13
                  xori        a7, t3, -1967
                  srli        zero, a3, 21
                  sub         s0, a5, s9
                  xor         s7, a7, t2
                  srai        s7, a7, 23
                  slti        t4, a1, -482
                  xori        s7, a6, 1408
                  sll         zero, s9, s3
                  andi        a6, s11, 983
                  or          zero, s4, t5
                  xori        t2, s2, 1818
                  sra         t0, s2, s4
                  xori        s4, s1, -556
                  add         t3, zero, t3
                  sra         a0, s0, sp
                  srli        s8, tp, 19
                  or          s9, t4, a5
                  srli        a2, s3, 10
                  auipc       a5, 851862
                  slti        s9, t3, -906
                  andi        s3, s10, 1532
                  sra         zero, a1, s4
                  or          s1, t4, t2
                  sll         s2, a1, s8
                  sltiu       tp, zero, 1952
                  auipc       s7, 977458
                  sll         s1, s8, a4
                  add         a3, t4, s10
                  slt         a4, t1, s3
                  xor         s8, a5, s5
                  and         zero, gp, s10
                  sltiu       zero, gp, -1329
                  slt         t4, a4, t3
                  andi        a0, s9, -1462
                  or          s0, gp, sp
                  sltu        t2, a6, s3
                  sub         a2, t0, gp
                  slt         t4, a5, s5
                  addi        a7, gp, -558
                  auipc       gp, 433036
                  and         s9, s2, a3
                  addi        a3, t0, 929
                  addi        a5, s9, 1790
                  ori         s1, t4, 272
                  sub         s1, s9, t1
                  sub         t2, t4, s4
                  slt         s1, t1, s11
                  add         s8, s0, a7
                  slli        a5, a5, 24
                  slt         tp, s1, a5
                  add         a6, t5, zero
                  addi        s7, s10, 1400
                  slli        a3, s5, 26
                  addi        s7, a5, -1836
                  ori         zero, a5, -9
                  nop
                  auipc       s3, 160409
                  sltiu       s1, a2, -68
                  srl         zero, t1, s1
                  and         zero, t4, s11
                  addi        s6, t3, -933
                  xori        s5, s7, 844
                  slti        zero, zero, 473
                  xori        a7, s8, 778
                  sltiu       s1, t2, 629
                  sltu        a3, ra, s11
                  xor         ra, t2, gp
                  nop
                  sltiu       t3, a2, -1369
                  srai        s8, s5, 2
                  or          s1, s4, t0
                  slt         t4, gp, tp
                  srai        ra, sp, 11
                  slti        s0, zero, -974
                  and         zero, a1, t1
                  xor         a2, s2, zero
                  andi        s0, a6, 148
                  lui         t1, 581114
                  andi        zero, tp, -873
                  nop
                  srai        tp, ra, 13
                  sltu        s0, a5, t4
                  sub         s11, s8, s11
                  sltu        s2, t2, t4
                  srli        sp, gp, 7
                  sltu        zero, t0, sp
                  srli        t2, s11, 10
                  and         t2, ra, a7
                  slti        t2, a1, 979
                  sltiu       zero, ra, -1921
                  xor         a4, a3, a5
                  sll         t1, tp, t5
                  and         a0, sp, s11
                  slti        a6, s5, -152
                  xor         zero, a0, s5
                  srli        zero, gp, 2
                  sub         zero, sp, s3
                  sll         s6, s7, s7
                  add         zero, s9, s7
                  add         s1, s0, t2
                  xori        t1, t4, -394
                  sltiu       t2, ra, -930
                  or          zero, a4, sp
                  srai        s11, t1, 17
                  sub         zero, s6, a3
                  srl         ra, t5, t0
                  slti        zero, s5, -1176
                  and         zero, a1, s1
                  addi        t4, s9, 60
                  sra         a5, a6, zero
                  sub         s6, a6, a5
                  or          t2, a0, a6
                  srai        s2, t5, 29
                  slli        s1, s1, 25
                  or          a2, a7, s3
                  addi        a7, s8, 954
                  auipc       zero, 161002
                  add         s6, a3, a4
                  addi        a2, s10, -497
                  lui         zero, 214597
                  srli        a5, a0, 24
                  slt         a3, s4, t0
                  xori        t3, a5, -1640
                  or          t0, t5, a2
                  slt         a2, s6, zero
                  slti        s5, a3, -1788
                  slti        a4, t4, -595
                  and         a1, t0, s3
                  addi        zero, a2, 478
                  addi        s7, t4, 171
                  sll         sp, a5, s9
                  srl         s3, gp, a6
                  and         a4, s7, a1
                  andi        zero, a7, -446
                  sltiu       s0, s5, 494
                  sra         t1, ra, t6
                  slli        tp, a4, 22
                  sll         s2, t2, s3
                  srli        tp, s5, 26
                  srai        s7, s6, 1
                  xor         s4, a6, s10
                  add         t4, s3, tp
                  xor         a1, t5, a6
                  sltiu       a6, a3, 1072
                  srli        tp, t6, 7
                  sll         s5, s2, s6
                  sub         t2, s10, zero
                  auipc       t1, 647159
                  sub         t1, a5, t2
                  nop
                  sub         ra, s1, s6
                  slti        s3, t1, 715
                  add         zero, s10, s9
                  andi        t0, t3, -146
                  sll         a5, t5, a0
                  or          t1, s11, tp
                  sltu        gp, gp, s0
                  and         s3, s11, a1
                  lui         t2, 53192
                  slt         zero, ra, a2
                  or          a3, ra, s5
                  add         a4, t1, s8
                  add         s7, s2, s3
                  slti        a0, t1, 158
                  slti        s3, s2, -999
                  slt         zero, t5, t2
                  sll         t4, gp, tp
                  lui         a4, 732703
                  ori         t1, a4, -1153
                  lui         s1, 859582
                  slli        a7, a6, 20
                  or          a6, t3, a4
                  slt         a4, a3, s0
                  srl         a0, a7, s1
                  slli        a5, gp, 19
                  sll         a3, a0, t4
                  and         t3, t5, s7
                  andi        s0, s10, -249
                  slli        a0, t5, 30
                  auipc       s6, 9189
                  or          sp, t0, t3
                  xori        s6, t1, 474
                  auipc       a3, 200000
                  srl         s0, a6, s11
                  srl         zero, s10, t1
                  nop
                  sltu        a1, a2, s1
                  ori         s8, zero, 731
                  add         ra, t3, a5
                  slli        zero, a5, 12
                  add         a1, s11, tp
                  sll         zero, a4, a0
                  andi        t1, t0, -1085
                  lui         s9, 652256
                  addi        sp, s4, 1119
                  auipc       a4, 623644
                  sll         s0, t3, s6
                  slli        s5, t4, 5
                  srl         zero, a7, tp
                  sll         t2, a2, t4
                  slli        zero, s10, 2
                  slti        a0, t2, 536
                  sltiu       t2, a7, -375
                  and         zero, t5, tp
                  xor         s3, s1, a4
                  slti        ra, s2, 183
                  slt         gp, t3, s5
                  addi        zero, a5, -755
                  add         zero, t6, a2
                  xori        zero, gp, -658
                  sll         t0, a2, s2
                  slti        t3, t3, -1514
                  lui         a4, 437174
                  ori         a2, a1, -1834
                  and         s0, t6, s3
                  and         s3, a6, s2
                  sltiu       t0, t2, 264
                  andi        a3, a0, -1212
                  or          a6, t4, zero
                  sll         ra, gp, a2
                  sll         t0, s8, t1
                  srl         s2, a4, s8
                  auipc       a1, 248152
                  slt         s11, t6, s2
                  andi        t2, t2, -470
                  addi        t4, zero, -381
                  or          t2, s4, s8
                  xori        t0, s5, 1675
                  xor         t4, t5, sp
                  sltu        s1, a3, tp
                  xor         s7, sp, a7
                  srli        a6, s3, 17
                  slt         s1, a2, t5
                  lui         s8, 378161
                  xor         s0, zero, t4
                  sll         zero, a4, a5
                  andi        s3, s0, 1466
                  sltu        zero, s7, s1
                  xor         s3, s8, t1
                  auipc       s4, 214685
                  or          s9, a7, a1
                  or          zero, sp, s6
                  srai        s7, a2, 18
                  and         t0, a4, a2
                  sra         t3, s3, s6
                  slti        a6, a2, -1356
                  srai        a6, a2, 28
                  sll         sp, s9, t1
                  lui         a5, 861293
                  and         t3, s0, a6
                  slt         s0, s7, ra
                  srai        sp, a2, 19
                  auipc       s11, 92753
                  and         t2, s1, a1
                  sltiu       s8, a7, -1083
                  lui         s11, 451044
                  srai        a3, s6, 19
                  sll         s9, t1, t4
                  xori        zero, a7, 1902
                  auipc       t3, 897755
                  addi        ra, ra, 1820
                  slt         a7, s11, t4
                  sltiu       s8, t0, -892
                  addi        a7, s3, 1428
                  ori         a7, s0, 726
                  auipc       a4, 308846
                  sltu        t2, t1, gp
                  sll         zero, a1, s11
                  sub         a5, a3, t3
                  add         t0, a0, s1
                  xor         ra, t4, s2
                  srli        s11, ra, 5
                  addi        a7, s11, -126
                  sub         t3, t4, a3
                  srli        s4, s11, 13
                  slti        a0, a2, 1706
                  xori        zero, s10, 1244
                  sltiu       zero, s6, -388
                  auipc       a5, 594155
                  sltu        s2, a5, ra
                  lui         t4, 566333
                  slt         s3, t2, zero
                  srl         s7, t5, t5
                  sll         s2, a1, zero
                  srai        a3, t0, 25
                  ori         s0, s3, -360
                  sll         s0, s6, s6
                  xor         s4, a2, s8
                  xor         s1, t2, a1
                  andi        tp, zero, 670
                  or          gp, s9, a5
                  and         s8, tp, s8
                  srl         a2, a5, a4
                  xor         a5, s10, a3
                  andi        s4, a0, -111
                  sltu        a1, t5, s5
                  sltu        s5, s1, s5
                  sltu        a1, s0, ra
                  srai        a2, s3, 23
                  nop
                  sll         a7, sp, a4
                  sll         t4, tp, t1
                  ori         s8, s1, -998
                  xori        s11, t1, -1172
                  xori        a4, t6, 1474
                  ori         zero, a1, 1546
                  and         s8, t0, a6
                  slt         s8, t3, t0
                  ori         s7, s1, -1916
                  add         ra, a7, ra
                  slti        s1, ra, -1819
                  slti        s0, ra, -1516
                  add         s6, s0, t0
                  xori        zero, s7, -41
                  xori        s1, t4, 453
                  sltiu       ra, s10, -1299
                  sltiu       a5, zero, -736
                  sltu        s7, t0, s11
                  slli        a2, s3, 23
                  lui         zero, 761904
                  xori        s3, t4, 809
                  and         s0, s5, s3
                  srai        zero, a0, 28
                  add         s4, t3, s1
                  sltu        gp, s0, t0
                  xor         a1, t0, gp
                  and         a7, a0, tp
                  srli        a0, ra, 2
                  sra         a6, s3, t6
                  nop
                  andi        zero, a3, -1415
                  sra         a4, a4, t4
                  addi        s2, a6, -943
                  ori         a7, a5, -1792
                  sltiu       a7, gp, -1481
                  slti        t0, a6, -1682
                  add         a7, a0, tp
                  lui         s3, 982679
                  auipc       s6, 435586
                  srl         t2, s11, t4
                  sltiu       a4, t1, 853
                  sltiu       s3, a0, 1432
                  lui         zero, 217024
                  xori        gp, s3, -1280
                  nop
                  sltiu       s1, sp, -1302
                  or          tp, a4, gp
                  addi        gp, t1, 1065
                  slt         a3, ra, s2
                  add         a1, t6, a1
                  ori         s5, t5, 1904
                  sll         a7, t4, t4
                  xori        zero, s0, -1857
                  sll         s7, t2, s3
                  srli        a7, a6, 25
                  xor         ra, a3, t6
                  sub         zero, s0, a5
                  or          t2, s11, a3
                  sra         s4, a4, s11
                  sll         s5, s11, t0
                  srl         a0, t5, t0
                  or          a4, s9, s7
                  sltiu       a3, s8, -606
                  sra         a4, tp, t1
                  slti        s11, a7, 127
                  and         a4, sp, s3
                  slti        a7, s9, -1059
                  add         a3, t2, t4
                  srli        t2, t4, 15
                  lui         sp, 979914
                  lui         s7, 183850
                  srai        s3, s10, 24
                  auipc       s0, 516722
                  or          t4, tp, a1
                  sra         ra, s9, t2
                  sll         zero, a5, sp
                  lui         s6, 267474
                  addi        s9, t2, 1548
                  ori         zero, s1, 948
                  and         a2, t1, t1
                  srl         zero, a0, a1
                  li         t4, 0x0 #start riscv_int_numeric_corner_stream_16
                  li         t3, 0x0
                  li         s0, 0x0
                  li         s11, 0x0
                  li         s9, 0x1
                  li         a1, 0x0
                  li         a7, 0x0
                  li         s3, 0x0
                  li         s7, 0x1
                  li         a6, 0xc04b64
                  nop
                  lui         s4, 435102
                  sub         tp, t6, a5
                  nop
                  nop
                  sub         s1, s3, s4
                  nop
                  sub         a3, s1, a2
                  add         t1, s6, t1
                  addi        s4, zero, -1389
                  nop
                  addi        s9, a7, 155
                  add         tp, s5, a4
                  nop
                  sub         a7, gp, a2
                  addi        t2, s1, -416
                  addi        s11, a5, 895
                  sub         t1, s6, zero
                  sub         a1, a3, s10
                  sub         zero, s6, t2
                  nop
                  sub         gp, a4, s0 #end riscv_int_numeric_corner_stream_16
                  sra         a0, sp, t6
                  xori        s5, ra, 97
                  and         s3, s3, ra
                  sltu        zero, t1, s9
                  auipc       s7, 516519
                  sra         gp, t2, s11
                  addi        gp, s2, -1292
                  and         s7, t4, t0
                  nop
                  or          a6, a2, t5
                  add         t1, s0, sp
                  xori        zero, a2, 1690
                  or          a4, a3, a3
                  or          s9, s4, s11
                  auipc       s0, 843996
                  and         a6, s10, sp
                  and         s1, a6, a5
                  addi        a6, gp, 1311
                  auipc       gp, 892794
                  sra         zero, a3, a3
                  xori        s3, a5, -1058
                  add         zero, s6, a6
                  sll         t0, s6, t0
                  lui         t2, 376670
                  srli        s0, a1, 20
                  addi        zero, ra, -317
                  sltu        sp, s1, s7
                  sll         s8, t2, t3
                  add         s5, s8, a5
                  andi        a3, a1, -971
                  slli        a7, s3, 26
                  slli        t1, s11, 26
                  ori         a7, s11, -1846
                  slt         s3, s4, s3
                  nop
                  slti        gp, s0, 437
                  lui         s11, 1024425
                  ori         a7, sp, 1241
                  and         t3, s5, zero
                  auipc       s6, 523252
                  lui         s9, 981133
                  sub         s1, a3, a3
                  slti        t1, t1, -42
                  sra         s5, a3, a4
                  auipc       s9, 864672
                  slti        a7, s5, 928
                  auipc       s0, 680840
                  and         gp, s4, a4
                  slt         ra, s1, s5
                  sltiu       s8, s8, 335
                  xor         a4, s2, s0
                  addi        a5, sp, -960
                  slt         gp, a0, s3
                  xor         t0, a2, s4
                  or          ra, s11, ra
                  sra         s8, t4, zero
                  auipc       a1, 393202
                  and         s8, s9, s8
                  slli        a6, s2, 1
                  slti        s9, a7, 41
                  slt         s0, s5, t4
                  slti        t3, a6, 581
                  slti        t2, a7, -1609
                  nop
                  xor         s8, s4, s10
                  srli        t1, s6, 31
                  and         s9, s3, zero
                  xor         ra, s10, t6
                  lui         a0, 291070
                  addi        a4, a0, 1581
                  add         a6, s4, sp
                  srai        s7, a2, 27
                  slti        s3, zero, 687
                  nop
                  slli        s6, t5, 23
                  ori         zero, s11, -1799
                  andi        ra, s6, 1042
                  addi        s6, t4, -41
                  lui         tp, 40534
                  sltiu       a2, a5, 590
                  srli        a5, s2, 30
                  sub         s7, t5, s11
                  srli        sp, a2, 1
                  sltiu       s8, t5, 744
                  auipc       a3, 651965
                  and         t0, s6, t1
                  xori        t4, s7, -848
                  add         t1, s3, t1
                  andi        tp, s1, -424
                  ori         zero, zero, -1758
                  slti        zero, s3, 1988
                  sub         a6, s8, a1
                  or          zero, t4, t2
                  ori         a4, t5, -1026
                  add         a7, s10, a3
                  xor         t2, s0, a1
                  and         a0, s11, t6
                  sltiu       s11, s11, -46
                  addi        s11, s1, 1584
                  sltiu       zero, s4, -703
                  andi        s5, a1, 1378
                  slti        s3, t0, 1121
                  srli        t2, t3, 16
                  nop
                  add         t0, s8, t6
                  lui         a3, 250358
                  slli        s5, a3, 31
                  nop
                  sll         a7, s3, s4
                  sra         tp, s5, a7
                  andi        a3, gp, 1348
                  sltiu       s9, s4, -412
                  slli        s3, zero, 3
                  andi        s8, ra, 1006
                  sltiu       s8, s0, -1345
                  andi        s7, s4, 1451
                  sll         t2, s2, a3
                  add         a7, s6, a6
                  and         t1, a4, s0
                  sll         s9, a7, s0
                  or          a6, sp, s2
                  xor         t4, a2, t6
                  srli        zero, s1, 30
                  srl         tp, zero, t0
                  sltu        sp, t0, a7
                  or          s6, t5, s2
                  add         zero, a4, t2
                  slli        s8, a6, 4
                  auipc       s1, 345652
                  srli        s4, s7, 6
                  and         s1, a6, s2
                  xor         s8, zero, s9
                  ori         s5, a5, 305
                  sltiu       a0, a5, 1120
                  slti        s2, a2, 394
                  add         a5, t5, a0
                  slt         gp, t0, s9
                  slt         t0, a7, s6
                  auipc       a0, 324362
                  sltiu       zero, s7, 1643
                  or          s3, ra, gp
                  and         zero, a6, s9
                  sltu        sp, gp, a5
                  lui         t0, 170576
                  and         a5, s5, a0
                  slli        s0, t5, 16
                  add         sp, s9, a1
                  lui         a6, 48577
                  xori        zero, zero, -374
                  or          t4, sp, gp
                  nop
                  and         s8, a0, s8
                  sra         a3, t6, s9
                  and         a6, t6, t6
                  sub         s9, t5, t3
                  srl         a5, t5, a2
                  xor         s1, a6, t1
                  lui         a0, 909637
                  xor         zero, a6, s4
                  sltiu       s1, a7, -588
                  sub         tp, t2, t3
                  slt         s2, s10, s9
                  add         a1, s2, gp
                  sub         zero, s8, t5
                  or          t3, a2, s7
                  srai        tp, t2, 31
                  sll         zero, s1, s10
                  sltu        gp, s2, t1
                  srai        s5, s8, 10
                  slli        a5, t3, 5
                  auipc       s2, 1004502
                  xor         s6, s1, t1
                  slt         a0, t6, a0
                  srli        a2, tp, 4
                  slt         t0, a2, t1
                  lui         s0, 712929
                  and         a3, s8, s3
                  add         s3, gp, t3
                  auipc       s3, 306849
                  or          a4, s3, s9
                  ori         s4, tp, 408
                  sra         sp, s11, t5
                  slti        t0, gp, -806
                  srai        s7, s8, 1
                  nop
                  srli        zero, s3, 28
                  xor         t2, s3, s9
                  srl         a7, t6, t2
                  andi        a1, s11, -805
                  ori         a5, t6, 1588
                  lui         zero, 167253
                  or          gp, t6, a2
                  srai        gp, t1, 12
                  and         a7, tp, s2
                  and         s6, s3, ra
                  ori         s3, s10, -423
                  srl         s6, sp, t0
                  andi        s4, a2, 1426
                  srl         s11, s4, s0
                  add         s11, s10, s9
                  lui         s11, 320510
                  and         zero, a2, a7
                  slti        zero, s1, -398
                  sll         t0, a5, s7
                  or          s3, zero, s3
                  srli        a5, s11, 12
                  or          a5, s6, s0
                  add         zero, sp, s5
                  xori        a2, s7, 471
                  sub         s5, s8, s6
                  ori         tp, t1, -1558
                  sltiu       t1, tp, -1194
                  sll         a0, a5, s2
                  and         a1, a6, a6
                  addi        t1, t1, 44
                  or          zero, s5, t0
                  srai        t2, zero, 19
                  sub         a2, a7, s11
                  add         a6, t4, ra
                  slli        s4, t2, 3
                  sltiu       a6, a0, -355
                  slli        t2, t0, 27
                  add         s0, gp, a7
                  srl         t1, gp, s1
                  srl         zero, s6, s1
                  nop
                  sltiu       s3, s11, -1554
                  or          zero, t6, s5
                  sltiu       a4, a7, 584
                  srli        a5, t0, 8
                  xori        s9, t1, 676
                  srai        t2, t0, 6
                  xor         a7, a0, gp
                  sltiu       s11, t1, -971
                  andi        ra, tp, 1048
                  addi        a0, s5, -1761
                  slti        zero, s9, -1945
                  lui         a0, 663980
                  addi        s0, ra, 802
                  sub         s9, s6, s7
                  sltiu       a4, s2, 1180
                  sltiu       s1, s3, 1820
                  slt         a3, sp, a1
                  addi        s3, t3, -952
                  xori        s6, t3, -1279
                  sltu        zero, tp, a0
                  or          zero, a5, gp
                  slli        s8, t0, 27
                  slli        s9, t4, 8
                  sll         zero, ra, a5
                  sra         s8, s5, zero
                  sll         gp, s11, tp
                  sll         t2, a1, tp
                  lui         s2, 518321
                  xor         s11, s4, s8
                  add         zero, t3, zero
                  and         t2, s8, s2
                  lui         gp, 893514
                  addi        zero, s7, 1951
                  nop
                  slt         s7, t4, s9
                  slt         zero, s5, s0
                  srli        zero, s1, 21
                  nop
                  addi        sp, s7, 434
                  sltiu       zero, s11, -983
                  srl         a0, s1, a4
                  srl         zero, zero, a5
                  addi        s0, ra, -452
                  srai        s4, a4, 9
                  xori        s6, s7, 1648
                  sltu        s0, a2, s2
                  sltu        tp, s3, s11
                  auipc       s11, 258695
                  auipc       a7, 349443
                  and         a5, a3, a1
                  slti        a1, s5, -542
                  sltiu       a6, s2, 17
                  sltiu       zero, t3, -598
                  add         a6, s4, t1
                  auipc       zero, 550830
                  andi        t2, s6, -809
                  addi        gp, t6, -488
                  nop
                  srai        a1, s0, 21
                  lui         a0, 304047
                  sub         t0, s0, gp
                  slli        a3, t4, 9
                  add         t2, t1, a2
                  slti        t4, s8, 674
                  add         s8, a2, s2
                  slt         s1, zero, t6
                  sltiu       s11, tp, 604
                  add         s6, t0, a0
                  and         t1, s7, s4
                  sltiu       a5, s8, 1407
                  slli        tp, s4, 7
                  srl         t1, a6, t1
                  sltiu       t0, s7, 746
                  xor         zero, s2, s11
                  slli        gp, t6, 17
                  srl         a4, s4, a6
                  add         a1, ra, s8
                  slli        a3, t4, 4
                  add         a2, ra, a0
                  and         a3, t2, t4
                  andi        s7, s11, 419
                  andi        s7, gp, 412
                  auipc       s11, 868621
                  sltu        tp, s7, s3
                  sltu        s4, s0, gp
                  srai        ra, t4, 4
                  or          t4, zero, s1
                  ori         t1, a4, -619
                  addi        s9, a1, 350
                  auipc       s9, 59272
                  sltiu       a1, gp, 1664
                  srli        s1, t5, 11
                  xor         zero, s9, s11
                  srl         a1, s10, t4
                  lui         t2, 886123
                  andi        s5, s3, -2031
                  nop
                  sll         t1, s2, zero
                  auipc       a1, 988919
                  and         s6, t1, t4
                  sltu        t4, a5, s0
                  add         s11, s9, s10
                  srli        a6, t3, 2
                  sltu        s3, a3, a3
                  sltiu       a4, s7, 1492
                  nop
                  slti        t3, a7, 1090
                  lui         zero, 141610
                  lui         t4, 771742
                  sltu        gp, a3, s8
                  srli        s7, t6, 9
                  srli        t3, s8, 15
                  sll         s7, t1, t0
                  add         gp, sp, t5
                  sub         s6, s2, a1
                  sub         zero, s3, a3
                  slli        zero, s11, 9
                  lui         s6, 1026755
                  sub         a3, a1, s3
                  xor         s0, s8, a6
                  xor         s7, s11, s6
                  auipc       ra, 777615
                  srai        zero, s1, 2
                  srli        s3, t4, 12
                  addi        t2, s2, 1916
                  slti        t4, a2, -173
                  ori         s4, t3, 631
                  slti        gp, s4, 460
                  or          s3, tp, t5
                  srai        s1, s4, 30
                  slli        a6, a2, 3
                  sra         t4, t2, a2
                  sltiu       zero, s11, -815
                  nop
                  sltu        s3, a0, ra
                  lui         tp, 617215
                  sll         a4, a5, tp
                  sra         a5, s0, t6
                  addi        zero, a1, -1689
                  xor         s2, tp, s0
                  srli        a4, s2, 18
                  add         s6, a0, a0
                  andi        a0, t1, -432
                  sub         s1, s9, s1
                  lui         t0, 319105
                  slt         a3, a1, a3
                  andi        a0, a4, -1272
                  xori        a5, t6, 1433
                  srai        t2, a4, 4
                  sll         s5, s1, s11
                  xori        s7, s7, 1127
                  add         zero, s4, a4
                  sltiu       s2, t6, -133
                  and         s1, s1, zero
                  and         tp, a2, s3
                  nop
                  sltiu       t1, a7, 1249
                  srli        s11, s3, 0
                  sltiu       s5, a0, 1516
                  andi        ra, s7, 674
                  or          a2, s5, a5
                  ori         s7, s4, -819
                  sll         zero, s10, t0
                  xor         ra, s5, gp
                  srli        s11, s5, 8
                  add         a0, s6, a3
                  xori        a4, a2, -1272
                  addi        a2, s5, -685
                  nop
                  slti        t1, t2, 1735
                  sub         sp, t4, t2
                  or          s6, a0, a0
                  srai        tp, gp, 12
                  xor         a1, s10, s1
                  xor         s11, a5, a6
                  slti        s3, s1, 1369
                  slli        zero, a5, 6
                  srai        s9, s6, 22
                  srli        s2, s5, 9
                  sltu        a3, ra, t3
                  xori        a1, sp, -434
                  srl         t4, zero, t1
                  and         a6, gp, s2
                  lui         a6, 530530
                  slti        s1, t6, -1590
                  add         a2, a3, s9
                  and         a7, ra, s2
                  xor         zero, t3, tp
                  and         s4, a5, s0
                  xor         ra, s1, s3
                  add         s11, s6, a1
                  sltiu       s1, t1, -429
                  addi        t1, s3, -1887
                  ori         zero, a2, 696
                  slti        a2, t6, -1567
                  ori         a5, a3, 178
                  sra         s2, s11, s9
                  add         t0, s10, t3
                  add         s2, t6, s4
                  auipc       zero, 402730
                  nop
                  sll         s8, s9, a0
                  slt         t0, t5, s3
                  addi        a6, a6, 1715
                  sub         t2, s7, s1
                  addi        a3, s4, 369
                  srai        zero, t0, 23
                  srl         sp, s1, a5
                  srai        a0, gp, 10
                  sra         s0, s9, zero
                  addi        s0, s8, 632
                  slli        t2, s9, 30
                  srli        zero, a3, 21
                  xori        zero, s10, 2034
                  sltu        s4, s2, ra
                  or          s6, a5, s9
                  sub         s3, ra, a5
                  sra         sp, t3, s10
                  sub         s7, s6, s10
                  xori        zero, ra, 175
                  add         a7, a3, s10
                  slt         s3, t1, s6
                  andi        zero, t0, 1062
                  srl         s3, s4, a5
                  lui         s7, 195455
                  sub         s0, s3, a2
                  sub         t2, s5, a5
                  sltiu       t1, zero, -1258
                  xor         gp, gp, t2
                  andi        t1, a5, 1659
                  or          zero, s6, sp
                  slli        zero, t1, 29
                  and         zero, s1, t1
                  ori         a6, s4, 1390
                  add         a1, sp, s4
                  srai        a1, a7, 8
                  add         a1, s5, s4
                  or          s3, sp, zero
                  and         a7, t4, a2
                  nop
                  sltu        s7, a0, gp
                  nop
                  andi        s9, t2, -485
                  xori        s4, s1, 860
                  xori        a0, t3, -1503
                  srai        a0, t4, 13
                  slli        s11, s1, 19
                  auipc       t3, 73081
                  srl         a3, s4, s6
                  addi        t3, a6, -1919
                  srai        s2, zero, 27
                  or          a5, a7, s1
                  lui         a4, 778549
                  or          t4, sp, s5
                  xori        t3, s7, -1859
                  and         s7, s1, a5
                  srl         zero, ra, a4
                  add         t0, a0, zero
                  srl         t3, t4, s5
                  addi        a7, s6, -1536
                  xor         a2, s4, s1
                  xor         zero, t4, a4
                  srli        a2, t2, 14
                  xor         s5, a4, s7
                  ori         gp, a4, 1403
                  add         a7, a2, t5
                  addi        s1, s3, -1484
                  or          gp, t3, sp
                  sltiu       s2, a7, -998
                  srl         a6, a4, a4
                  ori         a3, a1, 1857
                  srl         a2, t0, s3
                  srai        s7, s3, 5
                  lui         gp, 405774
                  and         zero, t3, a3
                  xori        a7, t5, 1461
                  sll         a7, s3, s4
                  lui         s1, 646541
                  xori        s5, t4, 1359
                  sltu        a3, t4, a5
                  sll         s4, s3, a0
                  sltu        a7, tp, gp
                  lui         s5, 1027736
                  and         s8, a6, s9
                  slt         a5, s9, t6
                  slli        a4, t2, 25
                  nop
                  slli        s4, a2, 17
                  slt         s3, t1, t0
                  srai        s4, sp, 19
                  or          s7, a5, s2
                  nop
                  add         sp, tp, a0
                  ori         t0, a6, 303
                  srai        t3, t4, 0
                  ori         a5, s5, 2018
                  slti        s6, s5, 396
                  ori         s1, s11, 1671
                  auipc       t1, 399604
                  addi        zero, a2, 223
                  sltiu       zero, s1, -1743
                  sltiu       s2, sp, 22
                  add         t4, tp, zero
                  lui         a0, 357420
                  andi        s4, a3, 478
                  addi        a3, a5, -1080
                  slli        t3, a6, 29
                  andi        zero, ra, 819
                  srl         zero, a0, a6
                  slti        zero, t1, -777
                  srli        zero, a5, 10
                  xor         zero, t5, s2
                  add         a3, a2, t0
                  sll         gp, tp, tp
                  lui         sp, 91367
                  srl         a1, s2, t0
                  srl         s1, a3, a1
                  addi        s8, ra, -250
                  and         sp, ra, a6
                  auipc       s7, 498875
                  srai        ra, s1, 10
                  andi        a2, a2, -535
                  ori         s0, ra, 1825
                  andi        gp, t3, 184
                  sltiu       t1, t4, -1544
                  slt         s11, zero, a6
                  andi        s7, s11, 772
                  srai        s8, gp, 30
                  andi        a3, t5, 1163
                  auipc       s11, 313311
                  auipc       tp, 900453
                  slli        s8, s0, 3
                  and         s8, t5, s11
                  ori         zero, t5, -53
                  sub         gp, s8, t4
                  sra         a1, t6, a5
                  or          t3, t0, a2
                  slti        a1, s11, 1971
                  sll         a1, a6, s7
                  nop
                  slt         a1, s6, a1
                  sra         t3, s0, s10
                  xor         zero, s5, t5
                  srl         s9, s0, zero
                  slli        s8, zero, 29
                  xori        a5, t3, -325
                  andi        s1, gp, -532
                  xor         t2, a5, zero
                  sltu        zero, s0, a7
                  and         a4, s1, s5
                  andi        s9, a0, 967
                  srai        s1, a1, 28
                  or          gp, a2, t1
                  and         zero, a7, t2
                  ori         a4, a0, 1831
                  srli        zero, t3, 30
                  add         a0, s6, s0
                  add         s3, t4, s1
                  or          t1, t3, a2
                  sltu        s9, s6, a0
                  or          zero, gp, a2
                  sltu        t2, tp, s9
                  sll         t3, s4, a1
                  srl         zero, t2, s5
                  srai        s8, s6, 3
                  sra         t0, s0, s2
                  sub         s2, a4, s8
                  sra         s2, s6, a0
                  and         zero, t6, t2
                  srai        a5, s3, 8
                  xori        t4, t5, 141
                  slti        t1, a6, 1516
                  add         a5, s2, s5
                  auipc       sp, 647577
                  sub         a7, gp, t2
                  srai        t1, gp, 7
                  sltu        a5, a1, a6
                  or          zero, t3, a1
                  add         a7, a4, s0
                  andi        s8, s4, 231
                  srli        sp, a0, 24
                  slt         t0, a1, s5
                  sub         a6, a1, s7
                  xor         zero, t5, a6
                  srai        s9, s7, 6
                  srai        a4, s8, 18
                  xori        a6, s2, 661
                  ori         s7, s0, -512
                  srai        sp, s9, 24
                  addi        zero, a4, -411
                  lui         s9, 860005
                  add         zero, s3, t3
                  sll         s7, s4, ra
                  xori        t3, s9, 1500
                  addi        s2, a2, 938
                  srli        s9, zero, 28
                  slt         ra, s1, ra
                  sll         a4, s3, s7
                  andi        t4, zero, 1085
                  sltiu       t1, ra, -1517
                  sra         t3, a1, a5
                  ori         t1, t2, 578
                  xor         t2, a4, s6
                  ori         t3, s8, 1352
                  nop
                  sub         s7, s0, tp
                  srl         a2, s1, t0
                  addi        zero, s9, 1132
                  xor         a7, ra, s9
                  nop
                  nop
                  sltu        zero, t6, a4
                  srli        s11, t4, 11
                  sll         a7, a7, a1
                  and         sp, s2, gp
                  lui         a4, 412576
                  sub         s2, s8, s9
                  lui         gp, 413669
                  sltu        s6, s6, t0
                  add         t2, s10, a6
                  slt         tp, s4, t3
                  add         t3, s3, a2
                  slli        t0, s5, 4
                  addi        s1, gp, -1709
                  addi        s3, a0, 905
                  slt         a0, ra, s6
                  sra         s4, a7, t3
                  auipc       zero, 965651
                  slti        s3, a0, -1530
                  srai        a2, a0, 7
                  sra         a2, s7, t3
                  xori        s4, s9, 383
                  slt         s2, a5, s5
                  slli        a4, t0, 12
                  or          s2, t5, gp
                  or          a2, a6, s5
                  xor         zero, s0, s11
                  slt         t1, s11, s4
                  slti        zero, s7, 393
                  srai        s5, t4, 30
                  sll         s1, t1, s2
                  add         a6, s0, ra
                  xori        s2, zero, 2042
                  sub         t4, s4, t0
                  andi        s11, s5, -1478
                  addi        a3, t2, 2024
                  sltu        tp, s6, t3
                  slli        zero, a6, 19
                  xori        zero, s6, 771
                  xor         s8, s7, a5
                  ori         s6, s0, -845
                  sll         s3, s4, s4
                  sll         a4, t1, tp
                  slli        s4, s0, 26
                  lui         a6, 993492
                  sltiu       s4, sp, -1245
                  lui         zero, 326358
                  or          s1, a3, a5
                  sub         zero, s11, t5
                  add         a6, s6, t4
                  srai        s1, t5, 19
                  srli        a4, a0, 2
                  and         s1, a4, s11
                  srl         gp, a2, a3
                  srl         a4, s10, a7
                  slt         s1, a1, s11
                  sra         s11, a6, a4
                  andi        t4, a4, 1995
                  xor         a3, ra, a3
                  and         a0, s11, s3
                  or          zero, s7, s4
                  sll         a6, zero, ra
                  slti        a2, s4, -1197
                  srai        sp, sp, 15
                  xori        a3, a4, 238
                  andi        a6, a1, -1799
                  srli        a1, s8, 17
                  slt         a5, s0, ra
                  ori         s0, s6, -1045
                  srli        s2, a1, 23
                  sub         s1, t4, a0
                  srli        s11, a0, 6
                  auipc       a4, 605076
                  lui         a0, 565674
                  sltu        ra, zero, s7
                  srli        t3, s7, 1
                  sub         a0, s1, ra
                  andi        t1, s5, 896
                  srai        a5, s10, 2
                  addi        a3, s0, 1117
                  slt         sp, t6, a4
                  sltiu       a0, a6, -619
                  andi        zero, s7, 229
                  andi        zero, s5, -228
                  sra         s11, s5, ra
                  sltiu       a1, s0, 859
                  sll         t0, s7, s0
                  slli        t1, a7, 11
                  lui         s7, 538301
                  slli        t0, sp, 29
                  andi        s8, s11, -915
                  xor         zero, s7, gp
                  sub         s7, t6, s11
                  slti        zero, a4, 2024
                  lui         a1, 291002
                  srl         a5, t6, s9
                  add         a3, s3, t0
                  sra         zero, a6, s1
                  auipc       s2, 86640
                  sltiu       tp, s1, -1141
                  srli        a4, s7, 31
                  or          zero, t4, s10
                  slti        a0, a1, 1524
                  sltu        t3, t1, s5
                  xori        s6, tp, 253
                  nop
                  slli        s1, a5, 26
                  sll         s11, s5, s1
                  or          t3, t2, s8
                  and         s9, s6, s7
                  sub         s1, s5, s11
                  sll         a6, a3, a1
                  sltu        a6, a4, s2
                  add         s5, a7, sp
                  xori        a4, s8, 105
                  slt         s0, a5, s4
                  auipc       t4, 453747
                  slti        zero, t5, 1692
                  add         a4, t1, a4
                  andi        s4, t6, 1811
                  slt         t2, gp, s2
                  sltiu       s3, a5, -463
                  add         a5, ra, s6
                  or          zero, s8, a2
                  nop
                  sltiu       t1, s1, 1616
                  sltu        zero, s11, s11
                  add         a0, a2, t0
                  slti        a5, tp, -518
                  ori         t1, a4, 1684
                  xori        t2, a5, -485
                  sub         s5, s1, s7
                  sltiu       s2, s3, -656
                  sra         gp, s10, s5
                  xor         a7, ra, s2
                  sltiu       zero, gp, 513
                  srai        s0, a3, 3
                  lui         a4, 429935
                  slt         ra, t1, a0
                  xori        t4, sp, 1575
                  sub         a2, a6, s10
                  slt         s9, a1, a4
                  srl         zero, s1, a4
                  and         a6, a0, s0
                  srli        s5, a3, 31
                  srai        a2, zero, 19
                  srai        a6, s2, 9
                  andi        t4, s0, -1482
                  sra         a1, s3, a1
                  slti        s5, a3, -1918
                  sltu        s3, s8, t2
                  sltu        a3, s5, a0
                  sub         gp, a5, a7
                  slti        s9, s1, 813
                  srl         a3, t2, s11
                  sltiu       s11, t2, -318
                  addi        a5, a2, 692
                  add         zero, t5, a2
                  slti        a4, sp, 1533
                  srai        s1, gp, 29
                  sll         a4, s6, a3
                  auipc       s8, 668847
                  xori        s5, s10, 1409
                  sra         a0, s0, t4
                  sltu        s7, t2, a4
                  and         s4, s11, t1
                  andi        gp, s4, -86
                  slti        zero, a6, 206
                  slli        a4, gp, 8
                  li         t4, 0x72e99940 #start riscv_int_numeric_corner_stream_6
                  li         t3, 0x46fc9063
                  li         s8, 0x0
                  li         a7, 0x1e0fb5db
                  li         s9, 0x0
                  li         ra, 0x1
                  li         a2, 0x1
                  li         s0, 0x1855ea56
                  li         a6, 0x1
                  li         s11, 0x0
                  nop
                  lui         ra, 93497
                  add         a7, gp, s7
                  add         sp, a1, s1
                  sub         a3, a3, t0
                  nop
                  nop
                  addi        s2, ra, -1102
                  sub         zero, s7, sp
                  lui         a6, 792135
                  lui         zero, 687899
                  sub         t3, a3, t2
                  sub         a0, s9, s7
                  add         t1, s2, s5
                  addi        t3, t4, -1129
                  nop
                  add         zero, t1, s8
                  addi        s3, s9, -1859
                  lui         sp, 980280
                  sub         t3, a3, a1
                  nop
                  sub         gp, t3, a2
                  add         tp, a0, t6
                  add         zero, zero, a0
                  add         gp, t4, s9 #end riscv_int_numeric_corner_stream_6
                  ori         a6, s4, -652
                  nop
                  srai        sp, s4, 29
                  lui         s3, 347307
                  slli        s6, t5, 15
                  andi        a4, t1, 180
                  sltiu       a2, t3, -1827
                  sltu        a4, gp, s4
                  sltu        zero, a0, s7
                  or          s9, t2, t4
                  srai        a2, a3, 27
                  slt         s3, s9, t5
                  xor         a3, sp, sp
                  sltiu       a3, a0, -992
                  ori         s3, a3, 517
                  or          s8, a2, s7
                  ori         a6, sp, 2037
                  nop
                  slti        a6, a5, -309
                  sra         a6, a2, s11
                  srl         a7, a1, t6
                  slt         s3, t1, s9
                  xor         s6, s7, s11
                  sra         s6, a0, a2
                  slli        zero, s4, 2
                  srl         s11, tp, s3
                  addi        s2, s11, 857
                  sll         zero, t1, tp
                  sra         s6, s10, t2
                  lui         s11, 913958
                  lui         s5, 526884
                  sra         s9, t3, ra
                  sra         a2, a6, s8
                  sub         sp, t0, s8
                  xori        s0, s11, -20
                  sll         a0, s3, gp
                  srli        s1, s9, 21
                  xori        a0, s1, 1096
                  lui         a4, 35952
                  nop
                  slt         zero, t0, t4
                  ori         a5, t2, -574
                  slli        t2, s5, 18
                  slli        zero, sp, 0
                  sub         s2, s2, s8
                  slt         s1, s9, t5
                  xor         s7, a6, t2
                  sra         a3, t6, a1
                  xori        gp, sp, -96
                  or          tp, t3, a4
                  sll         s3, tp, t6
                  sll         a1, a3, t6
                  lui         gp, 975737
                  addi        a4, a7, 1478
                  xori        a0, a4, -106
                  xor         s0, s10, s10
                  sra         s9, a7, t0
                  sub         zero, t3, s7
                  srai        a4, s6, 28
                  nop
                  sltiu       zero, t4, 1987
                  srl         zero, a5, sp
                  addi        s9, s0, -116
                  srai        a5, sp, 26
                  addi        s8, t1, 1940
                  sll         a3, a6, s10
                  ori         zero, s7, 1403
                  or          s7, s6, s3
                  sltu        gp, a6, a4
                  slli        t1, s4, 15
                  sra         t0, t5, s4
                  srai        s0, t3, 4
                  sltu        s8, zero, s1
                  xor         zero, s6, a4
                  sra         zero, a5, s3
                  or          t2, a5, s1
                  or          s3, zero, t6
                  add         zero, s7, s4
                  nop
                  sra         s11, s5, s3
                  xori        zero, t1, 139
                  nop
                  slt         a2, s6, a5
                  sll         t3, s1, s9
                  sll         t2, s3, s7
                  auipc       s6, 511200
                  slti        a2, t4, -1984
                  nop
                  slli        zero, tp, 23
                  srli        sp, s7, 10
                  sltu        a0, zero, s8
                  ori         s7, t0, -109
                  ori         s9, a2, 303
                  and         s11, s0, t0
                  xor         t2, s9, zero
                  sra         s6, a4, s4
                  auipc       sp, 751237
                  or          t3, s3, a0
                  sltu        s7, a7, a4
                  addi        tp, a0, 1757
                  nop
                  ori         s8, ra, -1109
                  srli        t4, a5, 17
                  sltu        gp, s11, s5
                  srli        t2, t6, 12
                  sub         zero, a1, a0
                  sll         t3, s5, s9
                  sltu        sp, s2, t5
                  sub         s6, gp, s0
                  lui         s8, 881743
                  add         s8, t4, s7
                  and         s2, sp, s6
                  ori         a6, s4, 1011
                  add         t2, t5, ra
                  andi        a5, gp, 1492
                  addi        s2, tp, 514
                  slli        ra, a2, 0
                  nop
                  srl         zero, s1, s5
                  slli        t3, sp, 19
                  xor         s1, zero, a4
                  srai        a3, tp, 19
                  or          s1, tp, s8
                  or          a2, s2, a6
                  and         zero, a2, s2
                  nop
                  srl         sp, a0, zero
                  slli        t0, s2, 8
                  xori        gp, gp, 1439
                  srli        zero, a7, 21
                  xori        t0, s0, 431
                  addi        a1, t0, -763
                  andi        a2, sp, -1246
                  add         a3, s7, t4
                  sra         sp, a3, t2
                  srai        s7, s2, 8
                  or          zero, t4, s9
                  xori        gp, t1, -210
                  xori        t1, s3, -2034
                  andi        gp, s4, -1034
                  xori        a2, zero, 1180
                  addi        zero, a6, -472
                  and         t4, t2, t5
                  li         t4, 0x227cb0bf #start riscv_int_numeric_corner_stream_12
                  li         s3, 0x0
                  li         t3, 0xff02013
                  li         s11, 0x0
                  li         a4, 0x1
                  li         s9, 0x0
                  li         a1, 0x1
                  li         ra, 0x1
                  li         s1, 0x1
                  li         s0, 0x0
                  lui         t4, 597274
                  lui         s3, 960035
                  addi        gp, a1, -1232
                  add         s7, s0, s11
                  nop
                  sub         t4, a0, a3
                  add         s2, zero, s9
                  addi        gp, s0, -460
                  add         s11, s2, a6
                  lui         a7, 546093
                  sub         zero, a1, a4
                  lui         s1, 561558
                  lui         t3, 813438
                  sub         a5, a5, t5
                  nop
                  addi        s3, t3, 1608
                  addi        t1, s5, -720
                  sub         t1, a0, s0
                  nop
                  nop
                  sub         a6, t2, a6
                  add         a1, s7, a1
                  addi        sp, a7, 798
                  nop
                  addi        zero, a4, 1886
                  sub         s9, s10, s1
                  lui         tp, 480411
                  nop
                  lui         sp, 776686
                  add         s11, tp, s5 #end riscv_int_numeric_corner_stream_12
                  slt         s4, a5, s6
                  sub         t1, ra, sp
                  xor         t1, s6, a6
                  srli        s5, t5, 10
                  or          s2, a1, s7
                  addi        s1, a3, 1261
                  srli        sp, s2, 6
                  andi        s5, s10, 629
                  srai        a5, t4, 15
                  sltu        a0, a7, tp
                  sub         t2, a7, tp
                  xori        a5, a3, -1653
                  xori        t0, s6, -1049
                  slti        a7, t2, -904
                  or          s9, s5, a1
                  or          a2, t6, a0
                  xor         zero, t4, a5
                  andi        ra, a0, -190
                  ori         s5, s9, -241
                  or          a1, a0, t3
                  or          s8, t4, t3
                  nop
                  and         s2, a5, a7
                  slt         s3, t4, s0
                  andi        s2, tp, 1628
                  sltu        a6, s2, t0
                  and         ra, a3, ra
                  srai        tp, a5, 3
                  and         a7, s4, s1
                  and         s1, sp, s1
                  slt         t0, s6, s5
                  sll         zero, a6, t2
                  addi        a2, t1, -1672
                  sub         s7, sp, t1
                  addi        a0, t5, -1317
                  nop
                  srai        zero, sp, 8
                  nop
                  lui         s4, 493515
                  nop
                  xor         s2, t3, s9
                  slt         a4, a2, a1
                  andi        a3, t2, 456
                  sltu        s1, tp, s4
                  sub         s3, s6, a5
                  xor         a6, a6, a2
                  addi        s3, a3, -1250
                  srli        s9, tp, 30
                  srl         s4, s0, s9
                  sra         sp, a2, tp
                  sra         gp, s3, t1
                  sltiu       t3, s6, -702
                  slt         s4, t6, t1
                  addi        s11, zero, -963
                  andi        a6, t6, 79
                  xori        zero, a3, -462
                  ori         s5, t4, 673
                  slli        t4, t5, 12
                  srai        s8, ra, 12
                  srl         a2, t5, t3
                  andi        gp, s6, 337
                  add         sp, sp, a1
                  add         a4, a6, s5
                  auipc       s0, 569411
                  lui         s3, 986712
                  addi        t2, t2, 1515
                  and         a7, a4, s1
                  lui         zero, 980930
                  sll         s9, s5, s5
                  sltiu       s8, gp, 1003
                  sltiu       ra, t3, 976
                  slli        s4, a7, 7
                  nop
                  nop
                  srli        s9, tp, 6
                  ori         s0, s4, -567
                  sub         s3, sp, a0
                  sub         a2, a1, t0
                  sub         s2, t6, zero
                  and         a4, s5, tp
                  sra         a4, s0, t4
                  slt         s9, s4, a3
                  sub         zero, s6, s1
                  sltiu       zero, a3, -1289
                  add         s4, t1, gp
                  sra         a6, tp, t1
                  nop
                  xor         t3, ra, ra
                  xori        t2, a7, -548
                  ori         s0, t2, 502
                  slt         zero, s7, t4
                  or          s8, tp, s2
                  auipc       s7, 161107
                  addi        a3, s9, 1550
                  sltu        s0, s2, s10
                  ori         zero, ra, 1368
                  slti        a4, a3, 1818
                  and         a4, s2, s7
                  auipc       ra, 888628
                  sra         ra, s11, ra
                  nop
                  sra         t4, s4, t2
                  sltu        zero, t4, tp
                  ori         s7, a4, 241
                  nop
                  srl         s11, a2, t1
                  sub         sp, gp, s1
                  sltiu       a2, t1, -1942
                  srai        a5, zero, 25
                  srli        a2, a2, 0
                  sll         s11, s2, t2
                  srl         a4, s7, t0
                  auipc       zero, 368242
                  sll         t1, s4, s8
                  addi        zero, t0, 2001
                  andi        a4, t6, 840
                  addi        t4, gp, 1146
                  nop
                  sra         t2, t5, t0
                  srl         a0, a1, gp
                  sub         ra, s11, a0
                  and         a3, s5, a6
                  sltiu       t1, s1, 1586
                  or          a4, a5, s0
                  srl         gp, s0, tp
                  slt         s0, tp, t2
                  lui         zero, 846550
                  srli        t0, a6, 20
                  ori         s9, s7, -1828
                  xori        zero, t1, 518
                  nop
                  srai        zero, a6, 9
                  and         t0, s5, s3
                  andi        s11, s6, 463
                  slti        sp, a0, 488
                  slt         t1, gp, s4
                  sltu        a5, t4, s11
                  sltiu       s5, s8, 7
                  sra         zero, s10, s3
                  lui         t0, 947665
                  nop
                  ori         tp, s11, 909
                  xor         zero, a3, a3
                  sra         tp, t5, a4
                  slli        t0, s10, 3
                  addi        s5, s9, 1830
                  addi        s3, s6, 1993
                  sub         t4, s2, s1
                  addi        s3, s5, 524
                  nop
                  and         zero, a3, sp
                  sll         s7, s1, s5
                  and         s1, t0, a1
                  and         s1, s7, s1
                  xor         t2, s10, a5
                  xor         s6, a4, t3
                  slt         s0, s7, s6
                  sra         t0, t4, t6
                  slt         a1, t1, t0
                  nop
                  srli        s4, a5, 31
                  srli        s3, s2, 24
                  addi        s1, t0, -160
                  srli        s3, s9, 14
                  addi        s1, a3, -664
                  sll         s0, a1, t1
                  and         ra, s3, s6
                  auipc       s2, 490397
                  slt         t4, t4, gp
                  auipc       a0, 579470
                  sll         gp, s0, t1
                  sll         t1, a2, t5
                  slti        t1, s10, -875
                  sltu        s8, s1, a3
                  sll         a1, s5, sp
                  ori         s1, tp, -429
                  ori         ra, zero, -1780
                  add         a0, s2, a6
                  ori         t1, a0, -134
                  lui         t3, 944151
                  andi        t1, a6, -547
                  sltiu       a5, s4, -813
                  xor         t0, s0, a2
                  sra         tp, s10, s0
                  sra         t2, tp, t4
                  srai        a0, tp, 16
                  sltu        a1, t1, a2
                  lui         s5, 315551
                  sll         zero, s5, tp
                  slt         s3, tp, a0
                  addi        s2, a3, 1093
                  lui         t3, 349151
                  sltu        s2, t6, t6
                  slli        s5, gp, 3
                  auipc       a7, 701648
                  add         t1, s2, gp
                  sub         s0, a6, zero
                  lui         t0, 556123
                  or          s8, a6, tp
                  sltu        a2, a5, t3
                  srai        s6, s1, 2
                  srl         s7, t1, a4
                  srl         t1, a1, gp
                  sltiu       zero, a3, 999
                  or          sp, s4, zero
                  sltiu       s1, a2, -946
                  srl         s8, s9, t3
                  or          s4, a2, sp
                  sra         a1, a1, s8
                  add         s11, t5, s4
                  addi        zero, a5, 688
                  srai        s7, a5, 2
                  addi        s6, s11, -1384
                  and         t0, ra, t0
                  andi        a7, sp, -66
                  srai        s5, t3, 11
                  srai        s4, s1, 6
                  and         s4, s1, a5
                  sltu        s4, ra, a4
                  sub         s11, t6, a4
                  andi        s5, t0, -809
                  or          s8, gp, a5
                  nop
                  ori         s1, s7, -297
                  slti        gp, t6, -70
                  auipc       t0, 909764
                  sll         a0, s9, s10
                  xor         a0, t4, a7
                  auipc       t3, 708214
                  auipc       a5, 527779
                  sra         zero, a2, s11
                  or          zero, s3, sp
                  srli        t3, s6, 16
                  slti        a0, s1, 1533
                  sll         s1, ra, s2
                  ori         t4, a6, 335
                  sltu        gp, a6, t0
                  srli        s6, s2, 31
                  auipc       s0, 533474
                  srli        s7, s9, 26
                  xor         s8, s9, s6
                  srli        s2, a5, 25
                  sltiu       s0, ra, 1433
                  sra         a3, s3, a2
                  sltiu       zero, tp, 1958
                  slti        zero, a3, 638
                  sltu        a3, s7, s10
                  sra         zero, a6, t1
                  sltiu       s4, s4, -1297
                  sra         s8, sp, t6
                  srli        sp, a2, 2
                  sra         a5, t4, s11
                  srai        s5, t2, 26
                  and         sp, sp, sp
                  sll         zero, s10, t2
                  slti        a7, s4, -1755
                  lui         a5, 882789
                  sub         gp, a3, a6
                  slti        zero, s0, 1374
                  auipc       t1, 877944
                  xor         a1, a6, t4
                  srl         tp, a2, s8
                  sltiu       zero, sp, 1178
                  addi        a5, a3, -1589
                  srl         s3, tp, a3
                  and         s0, tp, s6
                  and         a5, t1, ra
                  or          s2, s11, s0
                  xori        a1, s9, -1014
                  xor         s3, a1, a2
                  sltu        t3, s11, t5
                  sltu        gp, s0, t2
                  andi        a7, a3, 1871
                  sltu        ra, a1, s8
                  sra         a2, s11, s7
                  sltu        s8, a2, gp
                  addi        s9, s10, -755
                  sltu        t4, s11, sp
                  andi        a6, a7, -1661
                  addi        s6, s9, 1284
                  xori        s7, t2, -1419
                  srli        a2, t4, 25
                  lui         a3, 345748
                  sll         a0, t4, a1
                  nop
                  sub         t0, s9, s3
                  slti        a5, a4, 315
                  sltu        a4, a3, a0
                  sub         a3, t5, s10
                  slli        zero, t3, 11
                  and         t1, s9, s4
                  andi        ra, s2, -1148
                  sltiu       gp, s11, 1144
                  and         zero, t3, s5
                  srl         t3, a3, a5
                  slti        a7, s10, -405
                  srli        s7, s1, 10
                  sub         zero, a2, t6
                  srl         s5, a5, sp
                  andi        a4, a4, 1269
                  ori         t3, ra, -1605
                  xori        a7, zero, 508
                  and         zero, s10, zero
                  srli        a3, t4, 12
                  sub         s9, s5, zero
                  auipc       ra, 2057
                  lui         a0, 247251
                  slt         a2, a1, s8
                  sll         tp, zero, zero
                  sra         a5, s0, s7
                  or          t4, s9, t3
                  sra         zero, a6, tp
                  sltiu       a6, s11, -669
                  and         t4, a7, t0
                  sra         s9, s5, a1
                  slt         ra, s10, s2
                  add         t2, gp, s3
                  xori        ra, ra, -1881
                  slti        a1, tp, 1838
                  srli        s0, s6, 31
                  slti        s11, t4, 788
                  ori         t3, s2, 199
                  sra         s4, tp, s2
                  add         tp, a5, t0
                  andi        s1, s1, -1263
                  andi        a6, a3, 1316
                  xori        s2, s8, -989
                  nop
                  nop
                  sltu        a3, a6, s2
                  sll         a6, a0, s6
                  xor         a1, s7, gp
                  slli        s6, s7, 6
                  lui         t2, 341278
                  slti        s3, s3, 413
                  slti        zero, a6, -1759
                  srai        s4, a0, 6
                  andi        a4, s3, 1061
                  slti        t0, tp, -1196
                  and         a2, s2, a3
                  nop
                  sltiu       tp, t3, 1841
                  auipc       s2, 735122
                  add         t0, a0, s1
                  srai        s5, s10, 14
                  srl         tp, t0, t3
                  xori        a1, t5, -643
                  sltu        s4, a1, t3
                  slti        a4, a7, 727
                  sub         gp, ra, s2
                  xori        s1, s6, -612
                  addi        a1, s2, -22
                  add         s2, s11, a1
                  add         s11, s4, a7
                  slt         t2, s2, a5
                  add         a5, zero, s0
                  sra         a5, s8, s3
                  slti        s9, tp, 354
                  or          t2, t0, s5
                  nop
                  slti        sp, s9, -1454
                  slli        a0, s9, 8
                  ori         a5, s11, 308
                  slt         s2, a3, s11
                  xori        a0, s8, 864
                  xori        s5, s10, 467
                  slt         a3, s7, tp
                  srl         s3, gp, s11
                  srl         a3, t1, t5
                  and         t3, t1, s3
                  sra         s1, s10, t2
                  xor         s11, s10, s9
                  srai        sp, t1, 0
                  or          a1, s5, s0
                  srai        a6, a7, 17
                  srl         a3, a5, a2
                  srli        s11, a7, 3
                  add         zero, sp, t2
                  ori         zero, zero, -1690
                  xor         a2, s10, s11
                  addi        t0, a1, -897
                  sltu        sp, gp, s3
                  andi        s4, tp, 1116
                  andi        a7, s4, 1074
                  xori        t4, s2, -667
                  sll         a7, sp, s8
                  addi        s8, s1, -33
                  auipc       t3, 25483
                  add         s7, s5, tp
                  sll         s4, s6, t4
                  slt         a7, a7, zero
                  slli        zero, s11, 24
                  lui         s5, 368335
                  or          s9, zero, t4
                  or          zero, s4, t4
                  xori        s11, t0, -1885
                  slti        s7, s3, 1095
                  sll         gp, ra, a6
                  slt         s11, s0, s7
                  or          a1, s11, zero
                  addi        a2, a1, -1499
                  srai        ra, a5, 6
                  slt         gp, t3, s10
                  slli        a7, s7, 1
                  slt         a2, t5, t3
                  ori         s11, t3, -72
                  sltu        a6, t4, s0
                  xor         a2, s10, s1
                  addi        a0, s3, 1018
                  sltu        t1, s6, ra
                  srai        t1, s6, 11
                  andi        t3, a5, 1519
                  or          a2, a1, s4
                  and         s1, t3, t2
                  xori        s6, s8, 2041
                  auipc       t2, 339829
                  andi        a2, t0, -530
                  sra         s1, s5, t2
                  lui         a4, 86007
                  xori        zero, s6, 936
                  slti        a5, a5, -1207
                  and         zero, ra, s1
                  add         a4, t2, t2
                  addi        sp, s7, -890
                  andi        zero, s8, -622
                  sra         a2, s2, tp
                  slt         a1, sp, a7
                  auipc       tp, 155075
                  auipc       gp, 1027806
                  sltu        s7, s5, s5
                  nop
                  or          t3, t0, ra
                  xor         a5, t2, a7
                  sra         a4, t1, gp
                  and         a4, t5, s1
                  addi        s1, s0, -1246
                  srai        t2, s10, 0
                  srl         t3, s2, a3
                  slt         ra, gp, s6
                  slli        s8, a4, 25
                  sltiu       zero, s11, 1873
                  add         s6, s11, sp
                  andi        t0, t5, -1319
                  srl         t0, gp, tp
                  and         zero, a1, a6
                  slli        s11, s4, 9
                  and         a6, s2, ra
                  and         tp, t6, s7
                  slti        s11, a5, 1971
                  sub         s4, t2, s6
                  lui         a2, 451370
                  addi        t0, s7, 626
                  srai        zero, a4, 3
                  sltiu       a3, t0, -187
                  and         t4, a5, t6
                  nop
                  srai        s11, s4, 16
                  srai        sp, t1, 2
                  sltu        zero, s10, sp
                  nop
                  ori         t0, t4, -88
                  srl         ra, s11, s3
                  sltiu       t1, s10, -933
                  sub         sp, a4, s4
                  or          zero, zero, s7
                  xori        t0, a6, 640
                  slli        a6, t3, 20
                  srai        zero, t3, 22
                  ori         zero, s6, 1728
                  sra         s9, a0, sp
                  srli        s8, s10, 17
                  slti        s4, a0, 1400
                  srli        s6, s10, 31
                  xori        s9, a0, -499
                  sra         zero, t4, s6
                  andi        a0, t4, 766
                  srai        a3, a1, 1
                  addi        a7, t0, 11
                  nop
                  add         s4, sp, s6
                  nop
                  addi        zero, t1, -1508
                  srai        s6, t2, 9
                  addi        a7, t3, 193
                  slli        s0, t5, 30
                  xori        s1, s8, 1735
                  or          s0, a6, t4
                  add         t2, gp, a4
                  sltu        tp, tp, t4
                  andi        s3, t5, 1586
                  srli        s7, t4, 30
                  add         s2, a7, s10
                  addi        a6, s8, -23
                  lui         s0, 938009
                  nop
                  addi        s7, s0, -166
                  sll         t2, ra, gp
                  srai        gp, s0, 19
                  sub         s8, s6, s3
                  nop
                  sltiu       ra, s4, 674
                  addi        zero, a1, 1464
                  and         zero, a4, ra
                  xori        s4, t0, -901
                  ori         gp, a1, 781
                  andi        a1, t6, -1602
                  sltu        a0, s10, t2
                  auipc       t4, 631960
                  addi        a7, s10, 1830
                  srli        sp, s1, 25
                  sll         a2, s4, s8
                  srli        sp, s8, 22
                  and         zero, t6, s8
                  addi        a7, t4, -1511
                  auipc       gp, 526987
                  addi        s3, t3, 2042
                  andi        s5, s1, 1201
                  lui         zero, 564314
                  xori        s1, t5, -1338
                  slt         tp, s0, ra
                  lui         zero, 1043603
                  srai        s4, sp, 27
                  nop
                  sltu        zero, t3, s6
                  add         a7, a5, s7
                  sltu        ra, a5, t3
                  xori        a6, zero, 1904
                  sra         s11, s6, t0
                  and         s7, s3, a5
                  sll         a1, tp, sp
                  xori        s3, s3, -732
                  slli        s9, s7, 26
                  andi        t2, s3, -1737
                  lui         s7, 984422
                  sll         a2, t6, a5
                  add         t3, a1, a5
                  xori        s9, s3, -1016
                  ori         s5, t0, 1438
                  xori        a2, s10, -2000
                  and         s0, s6, s3
                  xor         s0, s10, t3
                  ori         ra, t1, -1404
                  andi        a1, s6, 322
                  sltiu       gp, tp, -921
                  nop
                  or          s4, s4, a7
                  sra         s1, gp, s2
                  nop
                  sub         a2, a3, gp
                  srli        zero, s1, 2
                  srli        t0, a5, 0
                  sra         zero, t4, t3
                  nop
                  and         s11, s6, t0
                  add         zero, a7, t5
                  sra         zero, a4, s10
                  sll         s9, a2, s10
                  nop
                  add         s1, s0, s10
                  sltiu       t3, s6, -42
                  sra         tp, s10, s1
                  srli        t2, a7, 17
                  ori         ra, s7, 651
                  ori         ra, tp, 569
                  nop
                  sra         t2, a6, t5
                  srl         s3, s5, s0
                  sltiu       s1, s7, -1364
                  slti        zero, tp, -383
                  addi        t3, a3, -467
                  srai        s1, s3, 13
                  sltiu       t2, t6, -444
                  sub         t1, t0, s4
                  sltu        a6, t6, a1
                  sll         s5, t6, s10
                  srl         a4, s6, sp
                  andi        s4, t2, -276
                  slt         zero, t2, a2
                  auipc       a6, 122669
                  or          tp, a4, s11
                  ori         s4, a0, 1791
                  sll         s9, a7, ra
                  sub         a4, s4, sp
                  lui         a6, 369827
                  sltiu       s11, sp, -791
                  srl         zero, s8, s4
                  nop
                  andi        s4, s7, 1342
                  ori         a2, ra, 81
                  sra         ra, s8, s6
                  xor         tp, a3, s7
                  ori         a1, t2, 1782
                  slt         a1, s1, t2
                  add         zero, a2, s1
                  srai        s1, a1, 2
                  sltiu       s6, s2, 1547
                  sltiu       s2, a5, 1504
                  addi        zero, s5, -846
                  nop
                  xori        s3, s3, 88
                  slli        zero, zero, 23
                  add         t3, s1, a0
                  xori        gp, a4, -1929
                  sra         s11, s3, a1
                  sra         s9, s9, s7
                  and         a3, s0, s3
                  and         s5, s6, sp
                  slli        zero, a3, 22
                  lui         a6, 665398
                  slli        a0, t5, 4
                  nop
                  andi        sp, s5, -1090
                  slli        gp, gp, 4
                  nop
                  addi        s9, a0, -830
                  and         s2, t1, t1
                  srai        t4, s11, 2
                  xor         s1, t5, zero
                  slti        ra, s3, -1663
                  slli        s4, s11, 31
                  slli        t2, s11, 25
                  addi        t0, s4, -278
                  slti        t4, a4, -1704
                  ori         s5, s2, -479
                  andi        s9, a6, 847
                  sll         a0, s11, s4
                  srli        zero, ra, 4
                  andi        zero, s3, 320
                  sltiu       s6, s6, 1517
                  sltu        s7, s4, a2
                  ori         tp, t5, 1789
                  lui         gp, 166842
                  andi        s0, s1, -935
                  andi        zero, t2, 417
                  slti        s1, a0, 1998
                  slt         s0, t6, a1
                  addi        s3, s11, -1494
                  and         s7, s5, s7
                  andi        t4, t1, 529
                  ori         zero, t0, -860
                  auipc       s4, 368020
                  addi        s8, s11, -327
                  or          s7, s7, a5
                  slt         zero, s0, a0
                  lui         zero, 702336
                  and         a5, s8, s5
                  xori        tp, s5, -35
                  sll         s1, t3, s4
                  sub         a2, s8, s0
                  sltiu       t1, a7, -1702
                  slt         zero, a4, tp
                  slli        zero, zero, 23
                  sltu        a1, a7, t0
                  srl         a5, t4, t5
                  add         a6, a7, s7
                  add         s0, t4, t3
                  ori         t2, s4, 1498
                  slt         s1, a4, ra
                  slt         zero, s1, t5
                  ori         s4, t5, -1710
                  add         s5, a6, s5
                  nop
                  sub         zero, s1, t6
                  ori         s5, t5, -1459
                  srl         s4, s7, s9
                  sra         sp, a3, t1
                  slt         sp, a2, a5
                  sltu        s2, ra, a0
                  srli        zero, a7, 14
                  auipc       s0, 668141
                  slli        s2, t2, 20
                  slli        a4, a3, 1
                  srl         t1, a3, gp
                  lui         zero, 378028
                  nop
                  or          a5, t5, a1
                  addi        a2, s3, 334
                  sra         s8, s8, a5
                  slt         sp, t0, t3
                  srli        a4, s0, 11
                  auipc       zero, 358105
                  sltu        s9, tp, s8
                  xori        s1, s3, -189
                  or          a6, t6, t6
                  slt         s8, s7, s9
                  or          a5, s4, s5
                  xor         a5, a3, s4
                  slti        s3, t0, -1148
                  xori        a5, t4, -1726
                  xori        a6, s3, -209
                  xor         s5, ra, a1
                  nop
                  sll         a7, a5, s3
                  add         zero, a7, a5
                  or          s1, s8, t0
                  slt         a7, a7, s10
                  ori         a7, a5, 1121
                  sltu        a2, s1, sp
                  auipc       a5, 810444
                  andi        zero, s10, 1015
                  sll         gp, tp, s8
                  add         s0, t5, a7
                  sll         s9, a1, t0
                  sra         s6, s10, t0
                  sltu        a1, t6, s0
                  lui         a1, 657297
                  add         s0, s0, s4
                  sll         s7, s10, a1
                  auipc       s4, 498663
                  sltiu       t3, s9, 1128
                  add         s9, ra, s3
                  sra         zero, s9, s8
                  or          gp, s2, sp
                  slti        a6, a0, 1841
                  addi        t1, a3, 1380
                  sra         ra, s8, s9
                  sltu        a4, s9, s1
                  srli        a1, tp, 17
                  and         sp, s4, s11
                  andi        a7, s3, -574
                  xor         s2, a5, t0
                  slti        s11, s4, -1192
                  srli        s3, s2, 19
                  srai        a4, s8, 0
                  srai        s6, gp, 13
                  sll         t4, s8, a2
                  sltu        s8, a6, a3
                  slli        a3, s3, 31
                  or          zero, s2, a5
                  srai        s2, t0, 2
                  srli        a1, t0, 0
                  sra         tp, zero, a1
                  add         s0, s7, s2
                  slt         a5, a2, s2
                  or          a3, tp, t5
                  sltu        a2, tp, s7
                  xori        ra, ra, 1059
                  or          tp, a3, a5
                  and         s1, a4, t2
                  sltiu       sp, s3, -1952
                  and         a3, a3, s7
                  addi        zero, t5, -759
                  srli        a6, s11, 7
                  nop
                  sra         s11, s8, a0
                  srl         a6, sp, t6
                  add         s8, t5, sp
                  srl         a7, t6, s8
                  sub         s11, gp, t2
                  xor         s3, t6, s7
                  nop
                  add         zero, t2, s9
                  sltu        a3, a6, a6
                  sltiu       t4, a7, 1346
                  sra         sp, s8, t5
                  addi        s5, a5, -205
                  and         a1, t0, tp
                  srli        zero, s8, 12
                  srl         s9, s10, s8
                  slti        zero, t6, 301
                  slti        s1, t3, 1281
                  sra         sp, a0, ra
                  nop
                  sltiu       t4, t3, 1848
                  sub         s3, s8, s0
                  sltiu       a4, t2, 1361
                  slli        s8, a2, 1
                  add         t4, s1, zero
                  xori        s3, ra, 93
                  addi        s2, a0, -1820
                  sll         zero, zero, s5
                  xor         tp, zero, a7
                  slt         s4, a1, s8
                  srl         ra, gp, s4
                  srai        a0, a5, 5
                  sub         a3, tp, tp
                  addi        s11, a6, 1336
                  add         a7, t0, a1
                  slli        t0, a6, 8
                  add         a2, ra, t0
                  sub         a0, ra, a4
                  srl         tp, t1, a7
                  lui         tp, 628242
                  srli        s3, t0, 21
                  or          a1, a3, a6
                  ori         s6, a4, 1300
                  slli        s11, gp, 11
                  srli        s2, a7, 28
                  or          a4, s6, t2
                  slli        t0, s8, 14
                  and         a6, a3, a1
                  add         a0, a4, s9
                  xor         s11, t2, t6
                  addi        t0, t4, 1242
                  srli        gp, a5, 25
                  and         s5, s6, t5
                  xori        ra, s11, -569
                  addi        s0, ra, 1354
                  and         t3, s0, ra
                  sltu        s4, s6, s10
                  xori        t3, t4, -414
                  slli        s7, a6, 30
                  sltiu       s8, s3, -1379
                  xor         tp, s0, s6
                  slti        t0, t3, -1655
                  srli        s1, s8, 15
                  andi        a0, s9, -716
                  xor         s4, a5, a5
                  lui         a7, 480426
                  sra         a0, s8, a2
                  lui         s9, 785362
                  lui         t4, 926846
                  sra         a6, zero, s6
                  sll         t4, sp, a3
                  slli        a0, a4, 24
                  slt         zero, s8, t0
                  add         tp, s9, t4
                  lui         t0, 195905
                  xori        s4, a3, -122
                  and         s9, a2, a7
                  ori         a0, s1, 907
                  sra         s9, ra, s0
                  lui         t1, 937497
                  addi        s7, s5, -615
                  ori         s3, a2, 1952
                  auipc       s11, 48155
                  and         tp, s4, s1
                  or          s6, gp, s11
                  auipc       a7, 935964
                  slti        a7, a3, 1444
                  slli        a4, s5, 12
                  auipc       sp, 134502
                  nop
                  sll         t2, a1, s10
                  ori         a2, a7, 33
                  sltiu       s2, a2, -118
                  srli        s3, a2, 27
                  sltu        t0, s5, t2
                  sub         s6, sp, t6
                  sra         zero, gp, sp
                  ori         s4, sp, 848
                  sra         tp, a7, t2
                  xori        s0, a1, -667
                  sltiu       t3, sp, -1206
                  auipc       tp, 588858
                  srai        s0, t2, 8
                  sub         gp, s6, t3
                  xori        s0, a5, 1650
                  xori        t3, t1, -1747
                  nop
                  slt         s3, a0, s11
                  addi        gp, t3, 316
                  lui         s1, 416339
                  slt         s0, t0, s11
                  xor         a7, s7, s0
                  sra         tp, t2, t5
                  slti        zero, a7, 540
                  nop
                  sll         s5, t1, s8
                  or          t4, a6, t3
                  addi        zero, a0, 129
                  srai        gp, a7, 24
                  addi        s6, a3, -1610
                  sll         t1, ra, s10
                  or          s7, s0, t0
                  slli        t2, a7, 10
                  addi        s7, s9, 1854
                  srli        s8, t2, 13
                  and         a5, s1, tp
                  slli        sp, t2, 16
                  xori        a1, s7, 642
                  nop
                  andi        a6, ra, 1518
                  lui         s2, 390782
                  sltu        t2, s10, a4
                  andi        t0, s2, -896
                  xor         s9, a3, a7
                  nop
                  srli        a2, t5, 19
                  sltiu       a2, s7, -1122
                  auipc       s0, 928896
                  addi        s2, s6, 340
                  lui         s4, 211142
                  lui         s6, 243337
                  andi        sp, s0, 67
                  auipc       zero, 614289
                  or          t2, s10, s4
                  sltiu       s3, s4, 1806
                  xor         zero, t1, tp
                  or          s6, sp, s6
                  srli        s6, t1, 2
                  and         a0, t2, a4
                  slt         s8, s9, s3
                  li         gp, 0x0 #start riscv_int_numeric_corner_stream_2
                  li         sp, 0x0
                  li         t4, 0x1
                  li         t3, 0x0
                  li         s0, 0x1
                  li         s5, 0x71784f6b
                  li         t0, 0x1
                  li         s1, 0x0
                  li         a4, 0x0
                  li         a1, 0x1
                  add         s11, s1, a5
                  addi        s8, a1, -283
                  nop
                  add         a7, s9, s9
                  lui         ra, 876697
                  sub         s6, t1, a2
                  lui         a0, 81978
                  sub         t4, s0, zero
                  addi        t2, s5, 1674
                  sub         s5, gp, t0
                  nop
                  sub         s4, gp, t1
                  lui         s2, 655056
                  add         s11, t2, s0
                  lui         t4, 756201
                  addi        a6, gp, -1602
                  add         s7, t0, zero
                  nop
                  nop
                  nop
                  add         a5, t6, zero
                  addi        s1, s1, -1974
                  sub         s4, s1, s2
                  sub         s6, gp, s5
                  add         s7, s9, a3
                  nop
                  sub         a1, t5, s4
                  lui         s4, 399007
                  add         s5, a2, sp
                  sub         s11, t3, t3 #end riscv_int_numeric_corner_stream_2
                  sra         ra, t0, tp
                  slt         s6, s1, s10
                  sra         zero, s11, a0
                  srl         s3, gp, s3
                  add         s11, a3, s7
                  srai        s0, s10, 19
                  auipc       s7, 286213
                  sll         t2, s6, t4
                  sll         a0, s2, s5
                  or          zero, a0, a7
                  sra         s6, t1, a0
                  sub         s2, t3, s4
                  xori        s7, s1, -1524
                  srai        a2, t2, 11
                  andi        a3, s4, -1081
                  srli        t1, a0, 29
                  srai        s0, s6, 5
                  nop
                  srl         zero, s8, t4
                  andi        a5, s10, -1785
                  auipc       a0, 649398
                  and         t1, a7, t2
                  ori         t1, t6, 1984
                  or          s2, zero, zero
                  add         zero, t1, a5
                  slt         t2, gp, t4
                  sra         s4, ra, a6
                  or          a6, a7, s1
                  auipc       zero, 670334
                  slli        s2, s10, 31
                  xor         s0, s8, t2
                  xor         s9, s4, s4
                  slti        s1, sp, 413
                  xori        tp, s7, 1524
                  auipc       s8, 376153
                  sltu        a6, s11, t2
                  slli        a6, a3, 20
                  slti        s3, s4, 1725
                  slli        a0, t1, 16
                  slt         t4, tp, gp
                  and         s0, s9, s7
                  or          t2, t2, s3
                  and         zero, s7, t2
                  nop
                  sltiu       s8, t4, -148
                  slti        a5, s6, 822
                  nop
                  add         s11, a5, a7
                  slli        t1, t5, 5
                  slli        a0, s3, 14
                  slt         zero, a3, t3
                  or          tp, s2, a1
                  auipc       s6, 348073
                  or          a5, t3, s10
                  srl         t3, t3, t1
                  srai        t4, s7, 21
                  slli        s0, sp, 19
                  slti        a0, s10, -1873
                  srli        s0, t5, 10
                  sll         s4, a7, a3
                  lui         s9, 419757
                  or          s7, s9, a0
                  xor         t0, s0, a3
                  sltu        s4, gp, s8
                  lui         a2, 495227
                  sub         s7, s5, a5
                  sltiu       a7, a3, 1493
                  or          s3, s10, a2
                  andi        ra, s7, -167
                  add         s0, gp, a7
                  sub         s11, zero, s10
                  lui         sp, 468543
                  and         t4, s7, t0
                  ori         a3, t0, 915
                  sub         s11, a5, a7
                  slli        ra, t2, 10
                  andi        t2, a0, -1551
                  slti        zero, a2, -511
                  srai        a6, a0, 4
                  auipc       t3, 575483
                  andi        t0, a5, 827
                  slt         ra, s9, t0
                  andi        s6, a2, 1177
                  xori        t4, a6, 148
                  lui         s5, 953312
                  xor         s3, s10, t4
                  or          zero, s9, a4
                  slt         a0, s3, t1
                  and         s7, s10, gp
                  xor         t3, a0, a6
                  addi        s11, s7, -231
                  srai        zero, s3, 17
                  srai        s0, a4, 18
                  sub         s2, a4, zero
                  sltu        a3, s6, zero
                  auipc       s9, 676270
                  or          s6, s2, a7
                  sra         a2, a5, zero
                  sll         a2, zero, t0
                  addi        s0, a5, 295
                  and         s5, t4, sp
                  sltiu       s2, s4, 541
                  sll         s8, a0, a6
                  andi        s0, t0, -874
                  or          s9, s11, tp
                  or          zero, a4, sp
                  and         a1, a4, s3
                  sltu        s8, zero, zero
                  or          s4, s10, sp
                  ori         t4, sp, -1607
                  srl         s4, s5, a6
                  sra         t4, s2, zero
                  add         s8, s8, s0
                  sub         a6, s7, s7
                  lui         t3, 600618
                  add         a5, a2, a0
                  xori        a4, t4, -864
                  slt         ra, s5, t4
                  xor         zero, a0, a6
                  addi        s9, s6, -993
                  srli        s0, a2, 27
                  sub         t0, s10, s5
                  srl         a0, a3, s4
                  sll         a6, s4, tp
                  nop
                  slt         t0, a6, sp
                  slli        s3, t3, 14
                  sll         a4, s11, t0
                  lui         t3, 893050
                  srl         s8, s9, s4
                  or          zero, t1, t1
                  xori        a6, gp, 1852
                  nop
                  sub         s8, t3, sp
                  lui         t4, 61007
                  sra         a6, s5, s5
                  slli        a7, t4, 18
                  andi        zero, t3, 770
                  srl         s9, a0, s5
                  srl         a6, s4, s8
                  addi        s8, s8, 550
                  sltu        t3, t1, t5
                  or          a4, s2, a1
                  and         s0, s6, a1
                  addi        s5, t4, 1645
                  and         sp, s0, s3
                  xor         s1, s2, s2
                  sra         t0, t6, tp
                  auipc       a4, 718605
                  xori        s6, t6, 745
                  sll         s11, t2, s9
                  srai        s4, t0, 20
                  srl         gp, a5, s1
                  or          a7, tp, gp
                  xori        s0, a1, 1614
                  srai        zero, a5, 22
                  sltu        s0, a6, gp
                  slli        s4, a0, 3
                  slti        zero, t4, -398
                  slli        s11, s6, 12
                  sub         zero, a3, t2
                  srai        s2, t3, 31
                  srli        t3, a0, 15
                  addi        zero, t6, -1484
                  andi        a2, t3, 220
                  sll         a1, t2, t0
                  xor         t3, s0, s6
                  or          t1, a1, s0
                  or          s1, gp, s5
                  add         tp, t3, a7
                  sltu        t0, a5, s10
                  xor         zero, s2, a0
                  andi        s9, t4, 669
                  sra         zero, a5, t1
                  and         s5, tp, a3
                  sub         s7, t6, a4
                  nop
                  auipc       s8, 224468
                  srai        s9, a3, 16
                  srl         zero, a6, s4
                  srli        a0, tp, 23
                  ori         t4, s10, 634
                  or          s1, s1, a2
                  addi        s8, s4, 829
                  andi        a7, s0, 1551
                  srli        a6, t5, 28
                  nop
                  srl         sp, a0, s11
                  slt         zero, s1, s8
                  and         zero, a1, s2
                  slli        tp, a2, 27
                  xori        a4, a1, 1306
                  nop
                  sltiu       t3, a7, -569
                  sra         s1, s9, s4
                  lui         ra, 1032522
                  auipc       a4, 502285
                  lui         s6, 869398
                  auipc       a4, 891522
                  or          a4, gp, s6
                  andi        a3, a3, -241
                  nop
                  sltiu       s1, s0, -1552
                  auipc       ra, 63667
                  sra         a5, sp, s6
                  slt         a3, a6, gp
                  srli        s0, ra, 20
                  slli        a1, t2, 5
                  and         t0, t5, t6
                  srl         t2, tp, a0
                  sll         a3, zero, t2
                  sltu        s1, a3, a6
                  addi        zero, a0, 1857
                  sub         zero, s10, s10
                  or          t4, sp, tp
                  or          s11, tp, t4
                  srai        t0, t3, 2
                  ori         a3, t3, 1402
                  srli        s7, gp, 25
                  sra         s2, s2, s1
                  auipc       zero, 70340
                  ori         zero, t5, -657
                  or          s2, s4, s6
                  sub         a2, s3, s6
                  auipc       gp, 1036814
                  slti        s8, s11, 278
                  xori        s7, s5, 1771
                  sltiu       t1, a7, 763
                  addi        a6, s10, 810
                  and         s1, a7, a0
                  slt         zero, t3, ra
                  auipc       t3, 270376
                  ori         s4, a4, 128
                  slli        a4, tp, 12
                  nop
                  auipc       zero, 894812
                  or          s7, t6, zero
                  srli        tp, zero, 20
                  nop
                  add         a6, s4, s6
                  srli        t2, gp, 4
                  slt         s4, s5, a6
                  sltu        t2, a6, gp
                  slt         zero, t4, s3
                  xori        s4, s5, -684
                  slti        t3, s6, -2035
                  ori         s7, ra, 1309
                  nop
                  nop
                  ori         s5, s6, -1743
                  and         a3, a0, s2
                  sra         t1, s9, t0
                  xori        s1, s1, 68
                  srli        s8, s8, 26
                  slli        t3, zero, 0
                  srli        s8, sp, 3
                  auipc       s0, 409494
                  srl         s6, s3, s0
                  sub         s5, t6, tp
                  slt         s6, s5, t6
                  addi        a0, tp, 1567
                  ori         zero, t6, 798
                  sltiu       s5, a6, 1502
                  and         t1, s5, a4
                  srai        t0, tp, 16
                  lui         zero, 1010475
                  sll         t1, tp, t2
                  ori         t3, s2, -1989
                  ori         a7, t6, -1604
                  xor         zero, t1, s5
                  srl         a2, tp, s8
                  sltiu       s0, a4, -1147
                  addi        s4, s4, -1928
                  sltu        s7, s5, a6
                  andi        t3, t2, -1483
                  add         s4, a0, t1
                  lui         a2, 145285
                  and         a6, zero, s5
                  or          s3, a1, a1
                  add         s4, s9, s10
                  sltu        a6, s9, s11
                  srai        s4, a0, 4
                  nop
                  lui         s2, 350675
                  sltiu       a2, s3, -1739
                  slti        zero, a1, 1740
                  andi        t0, s3, -1421
                  sltiu       t1, gp, 1209
                  xor         a1, s4, t2
                  and         t4, s11, s0
                  andi        s1, s11, -1309
                  slli        s8, sp, 26
                  sll         t4, s0, a4
                  lui         a2, 446783
                  sra         s5, t0, t6
                  srai        a1, s11, 22
                  sltiu       a5, s7, 921
                  nop
                  addi        s6, s5, 420
                  auipc       s5, 1007446
                  srai        t1, s6, 18
                  or          a1, t5, t2
                  srai        t4, s4, 17
                  srli        s1, s2, 10
                  auipc       a0, 108396
                  slti        zero, a5, -484
                  add         t3, a2, s5
                  lui         zero, 920362
                  srl         s11, t4, gp
                  xor         s9, s7, zero
                  sll         t2, t2, ra
                  ori         a5, a0, 857
                  sra         s9, a4, s9
                  sltu        t0, sp, zero
                  sra         s6, s9, t0
                  sltu        gp, a2, a0
                  ori         zero, a2, -716
                  sltiu       s6, s11, 1978
                  slti        s7, t6, -1098
                  slt         a0, s5, s4
                  lui         zero, 51489
                  add         s1, t0, zero
                  xor         s6, a1, tp
                  srli        a4, s5, 23
                  sll         t2, gp, t1
                  slli        s11, t0, 10
                  srai        s6, a0, 9
                  lui         s6, 106963
                  srl         s3, a2, s8
                  xori        t1, s8, -464
                  srli        a2, a3, 6
                  or          s5, s7, a1
                  srl         s2, tp, s11
                  add         zero, s11, s7
                  sub         zero, t6, s11
                  sll         zero, s3, s8
                  xor         tp, t1, t3
                  or          a7, s6, a7
                  or          t4, tp, s6
                  sra         s9, a2, t1
                  andi        zero, a1, 533
                  ori         s4, s2, -816
                  sltu        tp, a5, s10
                  sltiu       t4, a3, 1966
                  sltu        t2, a7, s0
                  srai        t4, ra, 31
                  srai        s7, a4, 5
                  srli        t4, tp, 21
                  srl         t1, s0, a3
                  addi        s11, a1, 1021
                  xori        a6, a7, -1921
                  sll         s2, t4, s4
                  xori        a4, s4, -316
                  or          s11, t5, s3
                  slli        s3, t4, 27
                  srai        s1, tp, 29
                  srai        a7, s9, 5
                  nop
                  xor         gp, a0, s4
                  auipc       s9, 25362
                  srli        zero, sp, 12
                  slti        a1, s4, -725
                  ori         t0, t1, 207
                  sra         a3, t3, sp
                  addi        a3, sp, -1341
                  nop
                  auipc       s0, 510089
                  srai        s8, s3, 4
                  sll         s4, a5, t5
                  srli        a7, t0, 13
                  slli        s11, a4, 1
                  slli        t0, s10, 25
                  srl         gp, s5, s4
                  slti        a5, t2, 1146
                  srli        s4, gp, 6
                  srli        s1, a5, 28
                  slt         t3, t1, a6
                  nop
                  or          t3, ra, s10
                  slli        ra, t6, 26
                  xori        s0, zero, 1253
                  sltu        s9, s4, a1
                  andi        sp, sp, -2007
                  sltiu       a6, s2, 1205
                  auipc       zero, 921609
                  slli        s0, s1, 3
                  slt         a0, s11, a3
                  slt         tp, s5, a6
                  srl         t4, sp, t0
                  auipc       gp, 517129
                  nop
                  sll         s1, t2, s4
                  slt         s3, s5, s11
                  sltiu       tp, a2, -55
                  slli        gp, gp, 13
                  srai        s6, a6, 25
                  srl         s2, gp, a6
                  auipc       s9, 488623
                  addi        s0, ra, -1515
                  or          a6, a0, t2
                  sll         t4, s8, sp
                  lui         s3, 499993
                  sltiu       tp, s9, -1108
                  srl         t4, t0, s0
                  add         ra, zero, a4
                  add         s6, s2, a7
                  lui         a1, 355561
                  andi        a2, s6, 1493
                  sra         s3, s7, zero
                  srl         t4, tp, t0
                  nop
                  sra         a2, s10, s3
                  auipc       zero, 159211
                  srai        t1, s7, 20
                  slt         a5, t1, s8
                  srai        a6, tp, 8
                  srli        t3, s11, 20
                  srl         a1, s0, t3
                  slli        zero, s8, 7
                  xor         a5, a2, t1
                  slt         s4, t1, a6
                  sll         a7, t4, t4
                  sll         sp, s9, t6
                  and         s0, a2, t2
                  add         s9, t5, t0
                  xori        s9, tp, 432
                  slli        zero, s10, 15
                  andi        a4, s1, -869
                  lui         tp, 451326
                  sra         s2, a1, a1
                  srli        s9, ra, 11
                  slti        a1, t3, 780
                  and         zero, t0, t1
                  slt         s3, s6, s5
                  srai        gp, s11, 25
                  and         s6, tp, t2
                  ori         a5, s0, 58
                  andi        a7, a0, -438
                  sll         a7, s11, t2
                  sltiu       ra, t2, -1052
                  nop
                  sra         s9, a3, a2
                  sll         zero, s11, a5
                  slt         a2, s8, a6
                  xori        a3, t6, 1474
                  sltu        t1, s0, s11
                  lui         s1, 604333
                  addi        a3, s8, 959
                  srl         t2, s5, s9
                  auipc       s4, 994115
                  nop
                  sra         t1, s7, a4
                  andi        zero, zero, -407
                  sub         zero, s4, s5
                  ori         s7, s3, -805
                  slti        t0, gp, -1913
                  sra         a3, t3, s9
                  add         s1, t2, a0
                  lui         s4, 137896
                  sub         s7, s4, s3
                  or          zero, t0, gp
                  auipc       s11, 458139
                  slti        zero, s9, -647
                  and         t3, s8, a4
                  addi        a1, a2, 142
                  sub         a4, a0, gp
                  slt         a3, a7, gp
                  sub         s0, s5, t0
                  xori        zero, a4, -471
                  or          s1, t5, a0
                  or          a1, t2, s10
                  add         s7, t0, s10
                  auipc       sp, 282507
                  addi        s9, tp, -125
                  slli        a7, s6, 11
                  sltu        t0, s6, s0
                  sll         s0, ra, a1
                  slt         gp, s4, t4
                  slli        sp, s3, 11
                  slti        s6, s5, -1313
                  sltiu       s8, tp, -1276
                  srai        s2, a1, 28
                  addi        sp, a0, -1010
                  andi        a1, s10, 782
                  sub         s6, a0, t2
                  sra         s1, a5, t4
                  srli        t3, tp, 1
                  sltiu       zero, ra, 986
                  slti        tp, t4, 81
                  sltiu       a0, s3, 1854
                  andi        t4, t6, 1699
                  and         a5, s6, t3
                  xor         s9, s10, a2
                  or          s2, s2, s11
                  addi        s8, s8, 1892
                  xor         zero, t6, a1
                  xor         zero, s8, t2
                  add         s5, t4, ra
                  srl         a3, a3, s1
                  andi        zero, gp, 115
                  and         zero, s6, t1
                  nop
                  add         s6, s1, zero
                  slli        a5, a1, 29
                  add         a0, a0, gp
                  srai        s9, tp, 27
                  xori        a0, a7, 114
                  srai        s1, s7, 22
                  slt         t0, s1, s9
                  srl         tp, t5, s9
                  andi        t4, s3, 1854
                  sra         a1, t2, s10
                  sltiu       s5, s2, -1015
                  sra         s4, s10, s3
                  addi        s9, t0, -723
                  xor         a4, s0, a2
                  srli        s5, s10, 21
                  addi        zero, s8, 931
                  xor         zero, sp, a1
                  or          ra, s10, s1
                  andi        t1, s4, -985
                  xor         t0, a1, a3
                  srli        s1, s0, 23
                  or          s3, s11, a5
                  or          s4, s9, sp
                  slt         s4, a1, t2
                  srl         s6, s0, sp
                  add         t4, t0, t4
                  or          t2, a2, t1
                  sltu        s2, s10, a1
                  addi        zero, a3, -1132
                  auipc       a2, 509841
                  slt         s4, s1, a2
                  slti        gp, s9, 1636
                  and         s9, t6, s0
                  sltiu       a6, zero, 803
                  slt         zero, sp, zero
                  andi        s5, s9, -1393
                  sltu        s0, s2, gp
                  add         zero, tp, t6
                  andi        t1, t1, 1978
                  sra         s6, t6, a4
                  slti        zero, gp, 1769
                  andi        s4, s1, -71
                  sltu        s1, s8, s9
                  srl         t0, a5, s5
                  xor         zero, a3, s8
                  andi        t1, s7, 105
                  sub         t3, t3, t6
                  srl         gp, a0, s10
                  add         a4, zero, a7
                  sll         s6, zero, a0
                  xor         zero, t1, t2
                  or          a4, s3, a7
                  xori        zero, t1, 945
                  sll         t1, s4, s4
                  lui         a5, 360459
                  add         a0, t3, gp
                  srai        a2, s3, 20
                  ori         s9, s6, -745
                  sra         s1, a0, t4
                  nop
                  or          s5, s3, s9
                  sltu        t1, t3, s2
                  sltu        a3, t0, gp
                  sub         s6, t5, s3
                  sltu        sp, s5, a6
                  sltiu       s4, a7, 477
                  slt         s1, s8, a7
                  slti        s4, a4, 1129
                  xori        zero, zero, 2021
                  addi        s0, s8, -904
                  auipc       a1, 372184
                  slt         zero, s3, zero
                  srl         t2, a2, tp
                  andi        a1, t4, 1005
                  nop
                  sltu        s6, s11, s1
                  sll         a3, tp, s6
                  addi        s2, s4, -1894
                  auipc       s4, 683758
                  or          a4, s4, a5
                  sltu        s2, a7, s2
                  add         zero, t6, s4
                  slti        t3, s10, -464
                  srai        a1, t1, 6
                  addi        s8, s3, -61
                  sra         t0, a4, s2
                  slti        s7, s0, -1806
                  and         a4, a1, t5
                  slli        s4, gp, 13
                  xor         s5, s11, a6
                  srl         s8, s5, a5
                  xori        a2, a4, -738
                  sltiu       a3, s10, -360
                  sra         tp, a2, s10
                  andi        a2, a6, -76
                  srai        s3, a5, 27
                  xori        a5, a2, 234
                  slt         t0, sp, s5
                  andi        s8, a2, -1985
                  sub         t3, a7, t4
                  srl         a0, a7, sp
                  auipc       s7, 794125
                  add         s11, t0, s1
                  xor         a4, s11, t2
                  andi        tp, s3, 1186
                  or          a2, a7, s7
                  sub         t1, gp, a3
                  xor         t2, t4, s9
                  addi        ra, s7, -2026
                  srai        s4, ra, 28
                  srli        a0, s11, 9
                  lui         gp, 135477
                  sub         s2, t6, a6
                  sltu        s4, a3, gp
                  lui         a5, 153422
                  add         zero, s10, t1
                  sll         s11, a7, zero
                  xor         zero, t5, s11
                  srli        s4, gp, 15
                  sra         a3, t0, t5
                  slli        sp, sp, 31
                  slti        s1, a1, -1107
                  ori         s9, s0, -1489
                  sra         ra, s5, a7
                  sltu        zero, a3, s8
                  slt         s0, a4, s9
                  ori         t4, s4, 880
                  sra         t2, s7, s1
                  sltu        ra, t3, a4
                  slt         s5, s7, t0
                  slli        a2, a7, 30
                  xori        tp, a2, 328
                  add         s5, t6, s0
                  add         sp, s11, s1
                  ori         zero, s11, -1866
                  sltiu       t2, s3, -82
                  slli        t1, s11, 7
                  srl         t4, s9, s6
                  ori         s0, s11, 1053
                  ori         sp, t4, -43
                  andi        s9, tp, 956
                  sltiu       t0, t5, 107
                  xori        s5, a1, 1284
                  srli        s4, zero, 4
                  slli        a4, t4, 15
                  lui         s1, 992417
                  ori         a5, a4, 1930
                  slti        s7, a7, -411
                  sll         a3, s3, t6
                  srli        s3, a7, 21
                  lui         t1, 165009
                  andi        s5, ra, -1774
                  srl         t3, s5, t0
                  slti        zero, s11, 1556
                  srl         t0, s6, t2
                  and         gp, a2, a3
                  slli        a1, s1, 8
                  nop
                  add         s8, t0, a6
                  srli        a2, t5, 2
                  and         gp, s10, t6
                  sltiu       a4, t1, -1075
                  xori        zero, a4, 681
                  and         t3, s11, s2
                  ori         sp, a3, -1333
                  auipc       a2, 260625
                  auipc       s7, 470267
                  sub         s4, t3, t5
                  sltiu       t4, s6, 1622
                  addi        s8, s11, -600
                  slt         tp, s9, s3
                  sltiu       s3, s7, 741
                  sub         s3, tp, s7
                  srli        s2, a7, 11
                  xor         a6, s9, t6
                  srl         t3, a2, s7
                  ori         s1, t4, 115
                  nop
                  sltiu       gp, t0, -1734
                  sub         s2, s6, s8
                  xor         s1, s6, t6
                  sltiu       s2, a6, 328
                  slt         tp, t2, gp
                  xori        s11, s6, 1436
                  slti        s11, sp, 717
                  add         s8, gp, a3
                  and         s8, a4, s3
                  nop
                  srli        a4, t4, 3
                  slti        t0, t1, -1011
                  xori        ra, s8, -891
                  sra         gp, ra, t1
                  srai        s8, s11, 16
                  andi        a1, t3, -415
                  addi        s1, zero, 1447
                  ori         a6, t4, 287
                  li         t4, 0x1 #start riscv_int_numeric_corner_stream_3
                  li         s4, 0x2d632cff
                  li         s2, 0x24d52951
                  li         a2, 0x0
                  li         t3, 0x0
                  li         a3, 0x0
                  li         a0, 0x0
                  li         s9, 0x0
                  li         s0, 0x0
                  li         s8, 0x0
                  lui         a4, 471109
                  sub         s1, a7, sp
                  addi        t4, t1, 1692
                  sub         gp, t1, s6
                  add         a7, t4, s4
                  sub         s11, t5, t5
                  lui         t4, 158266
                  sub         t4, zero, s9
                  lui         s11, 886994
                  add         tp, a7, a4
                  sub         s0, a1, s8
                  addi        a3, a7, 1881
                  add         s0, zero, s2
                  add         s7, gp, sp
                  addi        s9, s11, -826
                  sub         tp, t5, t4
                  addi        tp, s6, -1764
                  nop
                  lui         s7, 920199
                  add         t0, ra, t6
                  add         a7, s3, a4
                  sub         a0, zero, zero
                  sub         t2, s5, s7
                  nop #end riscv_int_numeric_corner_stream_3
                  sll         s8, a2, a5
                  xori        a4, a5, 1791
                  sll         gp, s2, a7
                  xori        s9, t6, -706
                  sll         s11, a5, a2
                  and         s11, s1, s4
                  slti        a3, a2, -1696
                  add         t3, s8, t1
                  andi        sp, s2, 1733
                  auipc       gp, 202506
                  sub         zero, t6, sp
                  ori         s7, s2, -1191
                  sub         t3, t4, a0
                  srl         t1, s11, a4
                  or          a4, s3, s6
                  sra         a5, ra, zero
                  lui         s11, 128810
                  sub         a6, t6, tp
                  xori        a4, s3, 332
                  nop
                  slt         a4, ra, a2
                  xori        s3, s8, -133
                  sll         zero, t3, a6
                  auipc       zero, 340960
                  nop
                  lui         s3, 508438
                  sltu        s0, s10, s3
                  xori        a3, a6, 741
                  addi        t3, s5, -221
                  xor         a1, t4, s3
                  xori        s6, s10, 646
                  addi        a0, s5, -118
                  lui         s6, 666555
                  slti        t3, a3, 1550
                  ori         s8, sp, 1758
                  and         zero, t1, a5
                  srai        zero, t5, 14
                  nop
                  ori         a5, sp, -2011
                  srai        t3, s4, 23
                  add         a6, t0, s10
                  lui         t2, 602647
                  add         a4, s0, a7
                  slt         a3, t5, a6
                  slti        s8, a4, -290
                  andi        t2, t4, 1527
                  slli        s4, t3, 5
                  slti        s2, a2, 261
                  sll         t2, a2, s1
                  srl         t4, gp, s3
                  srl         t0, t0, tp
                  or          s6, s8, t6
                  slt         a1, s8, gp
                  andi        a1, t5, -1344
                  srai        s3, s0, 17
                  sltiu       a3, s11, 651
                  sub         a6, s10, t0
                  slli        a6, s9, 16
                  or          s3, s5, s4
                  srli        s8, s0, 12
                  ori         s2, s0, 1444
                  xori        a7, t0, -416
                  sltiu       s1, s2, 985
                  andi        t1, a1, -880
                  srli        t3, t2, 22
                  xori        s11, s10, 1836
                  srai        a0, s4, 23
                  sra         s11, s5, s4
                  or          a6, t1, zero
                  lui         t2, 4083
                  xor         s5, ra, a1
                  xori        tp, s3, -189
                  srl         sp, tp, gp
                  addi        zero, s3, 1807
                  lui         a4, 572137
                  srai        t2, s11, 21
                  slt         s8, gp, tp
                  nop
                  sra         gp, s6, t3
                  auipc       a0, 110820
                  lui         zero, 557805
                  or          a4, t2, s7
                  or          s6, s4, sp
                  or          a1, a2, a6
                  addi        s8, t6, 1123
                  srai        zero, t5, 16
                  or          t0, s7, zero
                  sltiu       a3, zero, -292
                  sub         t3, zero, t2
                  slti        s0, t2, 886
                  sltiu       a2, s3, 1761
                  srli        t2, t4, 7
                  srl         ra, s5, a6
                  or          zero, s11, s5
                  andi        zero, t5, 697
                  slli        s8, s5, 15
                  xori        t1, gp, 63
                  xor         a7, s8, s1
                  sub         a4, s9, t5
                  or          s11, s3, tp
                  sub         a1, s0, a5
                  addi        s1, a5, -886
                  sub         s4, tp, s3
                  srl         t0, s10, s0
                  slt         s0, s1, s3
                  xor         gp, gp, s3
                  lui         tp, 327
                  ori         t3, s3, -1713
                  andi        gp, ra, -1700
                  ori         sp, s5, -754
                  and         zero, t1, zero
                  slli        s2, t5, 17
                  sltiu       t4, a4, 1684
                  slti        s6, a0, 596
                  slli        zero, s1, 2
                  and         s11, s11, s3
                  lui         s9, 670746
                  sra         s0, t0, s9
                  xor         a4, a7, a4
                  lui         ra, 209462
                  add         ra, s10, t1
                  andi        zero, s10, -851
                  nop
                  addi        zero, gp, 427
                  sll         s9, a2, t1
                  slti        gp, s5, -94
                  srli        t3, a1, 24
                  xor         gp, s0, a7
                  nop
                  srl         gp, t0, t6
                  add         s0, a1, a3
                  auipc       zero, 865098
                  lui         s7, 723000
                  lui         s0, 812905
                  addi        ra, s10, 1576
                  andi        tp, t1, -1668
                  xori        a5, t6, -1988
                  sll         t1, s2, s9
                  lui         t3, 819141
                  slli        gp, s4, 30
                  srai        zero, t5, 31
                  xor         zero, s7, a1
                  slli        s5, tp, 27
                  add         s0, t1, s10
                  auipc       t4, 128231
                  auipc       s4, 475896
                  slli        t0, t6, 5
                  sll         a7, s10, a0
                  sra         zero, tp, s2
                  xori        zero, a5, 209
                  auipc       a5, 608005
                  srai        sp, s10, 21
                  sll         a7, a1, a0
                  sll         t1, s7, s9
                  slli        s8, s10, 7
                  andi        s8, a7, 28
                  sll         t0, s9, zero
                  sub         tp, s3, zero
                  and         a6, a6, t3
                  sltiu       s4, t6, -1529
                  or          zero, t2, s2
                  or          a4, s0, a2
                  slt         t4, a7, t6
                  srl         a6, t6, a3
                  sltu        gp, gp, s3
                  addi        zero, t4, 1252
                  srl         zero, s1, a6
                  or          s7, s5, s9
                  addi        t4, s8, 776
                  add         a1, a6, s3
                  sra         a5, a3, s7
                  sltiu       t3, zero, 2040
                  slti        s7, a6, -1425
                  sltu        s4, t5, a7
                  xori        a2, s2, -654
                  slti        zero, s4, 1618
                  sub         zero, t3, t3
                  srli        zero, s7, 28
                  sra         s9, t1, zero
                  or          a5, tp, s0
                  ori         t2, s6, 119
                  sra         s6, s11, zero
                  andi        sp, a6, -538
                  srli        t0, s0, 11
                  slli        s4, s8, 16
                  sltu        gp, a4, t2
                  xori        s11, t3, 1775
                  slti        ra, s0, 404
                  sll         s0, s11, s11
                  andi        t1, t6, 389
                  and         a5, a7, s6
                  addi        s0, s2, -217
                  slti        t0, s4, -304
                  slli        t4, ra, 27
                  add         s8, zero, ra
                  sra         zero, a0, s11
                  andi        s4, gp, 1938
                  sltu        a0, s3, s4
                  nop
                  ori         s9, s5, -890
                  srli        a0, s1, 15
                  or          s2, t5, a0
                  lui         a6, 881972
                  srai        t4, a0, 31
                  srli        a2, s8, 8
                  xori        s7, tp, -1907
                  xor         a6, a0, gp
                  srai        t4, s5, 20
                  lui         ra, 868556
                  nop
                  lui         s7, 11350
                  add         s4, s1, a4
                  nop
                  or          tp, s2, s8
                  ori         s11, gp, 1676
                  and         a5, ra, t1
                  addi        t0, s9, -256
                  addi        s7, ra, 1066
                  xori        zero, s4, -938
                  andi        t3, zero, 946
                  and         a5, a3, zero
                  sll         a7, s1, a7
                  add         s9, s10, t4
                  xor         a7, s10, t3
                  lui         tp, 908963
                  srai        sp, s9, 29
                  slti        s7, t4, 303
                  auipc       ra, 879158
                  and         t2, sp, a1
                  srli        s4, s2, 10
                  sra         s9, s2, ra
                  sll         t2, s1, a2
                  srli        s0, t3, 20
                  xori        s2, a5, -1537
                  ori         a7, s5, 863
                  add         a2, t5, t0
                  srl         a0, sp, s0
                  srai        ra, s10, 22
                  or          s5, a7, a1
                  srli        s5, s3, 19
                  sra         a4, s0, a5
                  slti        s5, s0, 1418
                  sll         t0, s6, s5
                  nop
                  slti        a6, t6, 1956
                  srl         t2, t4, s4
                  addi        s11, s6, -1664
                  sll         s7, s7, a4
                  slli        zero, ra, 4
                  ori         s6, s8, 1657
                  xori        gp, a1, 1866
                  sltiu       t4, a0, -1406
                  ori         zero, s0, -1378
                  lui         s1, 646452
                  slt         s8, a5, s7
                  slti        t1, a6, 1955
                  slli        a4, s6, 8
                  add         zero, tp, gp
                  auipc       s7, 678252
                  or          s11, a3, t0
                  add         gp, s1, t2
                  add         s9, t0, t5
                  slti        zero, s0, -476
                  andi        s8, gp, 2008
                  sltu        t1, a0, t4
                  add         a0, sp, s10
                  sltu        a3, t6, a6
                  srai        a4, a1, 19
                  addi        s6, s5, -82
                  sll         zero, a1, t5
                  slti        zero, s8, -9
                  srl         t1, s9, zero
                  sra         a3, s3, t2
                  slti        gp, zero, -1183
                  add         zero, t1, t1
                  sll         s9, a0, a6
                  sra         a0, s11, gp
                  sll         t0, a2, s8
                  sra         s6, t5, s7
                  srl         t1, t4, t4
                  sub         a1, a5, t1
                  ori         t0, s9, 279
                  srai        zero, s6, 11
                  andi        a1, a4, 602
                  xor         s2, t2, ra
                  or          s8, a5, sp
                  and         a1, t0, tp
                  slti        s9, gp, -241
                  srl         zero, tp, t1
                  or          s7, gp, a6
                  srl         s4, a6, t4
                  sll         ra, s0, a6
                  auipc       ra, 364497
                  nop
                  srli        s7, sp, 9
                  slt         s9, sp, t6
                  slti        ra, s3, -217
                  slti        s0, a6, 531
                  sll         s8, s2, t6
                  and         gp, a1, t6
                  slti        a3, s5, 1366
                  xor         zero, a4, a2
                  addi        s11, a5, -1431
                  srai        s5, t4, 23
                  andi        s9, s6, -1841
                  auipc       sp, 79254
                  srl         s3, s3, s5
                  nop
                  or          a2, zero, a2
                  slli        zero, t5, 19
                  srli        a2, s1, 6
                  lui         s1, 159624
                  andi        a5, a7, 990
                  nop
                  and         t1, t6, t1
                  lui         a5, 753240
                  addi        t1, gp, -1282
                  xor         s3, t4, s11
                  sltiu       s8, s3, 422
                  ori         s3, s5, -1795
                  lui         t4, 221620
                  sltiu       zero, a1, -853
                  sub         a3, s3, s9
                  and         zero, t3, a4
                  slti        a5, t2, 758
                  slli        a4, tp, 28
                  add         s3, s9, a1
                  srli        sp, a0, 20
                  srli        s0, t3, 28
                  nop
                  add         a4, s5, s6
                  srli        gp, s7, 5
                  andi        zero, s3, 128
                  xor         a5, t4, t3
                  andi        t1, t2, -1899
                  sub         s5, a5, a2
                  slti        a0, t4, 1494
                  sll         t3, gp, a6
                  ori         s2, s5, -1057
                  srl         s11, a1, s7
                  srl         s8, zero, ra
                  slt         s3, a2, ra
                  srai        a0, s7, 8
                  add         s7, s8, s8
                  sll         a2, s8, t1
                  sltu        s11, a1, a3
                  add         zero, t3, s1
                  addi        t4, a4, 1563
                  add         s7, s8, tp
                  andi        s1, s9, 1218
                  xor         tp, s3, gp
                  sltu        t0, s9, t4
                  sltu        a3, a1, gp
                  andi        s9, gp, -665
                  auipc       tp, 263585
                  ori         a2, a6, 1186
                  slli        t2, t0, 25
                  slli        zero, zero, 18
                  addi        s3, t3, -1677
                  srli        a2, sp, 22
                  srai        a0, s8, 24
                  sltu        a0, tp, ra
                  sra         t2, zero, t2
                  slt         t3, tp, s2
                  addi        a1, a0, 1427
                  addi        gp, a0, 1190
                  add         zero, s10, t4
                  xor         s5, s10, t3
                  sltu        tp, tp, a7
                  andi        t0, t2, -149
                  srl         t2, s2, a7
                  auipc       s2, 511714
                  xori        t4, a7, 405
                  slt         t2, s5, s7
                  xor         s5, sp, a2
                  andi        s11, t4, 707
                  nop
                  add         a7, t4, s7
                  auipc       sp, 227229
                  andi        s0, t6, -175
                  andi        zero, tp, -502
                  andi        a3, sp, -2041
                  srl         s2, s7, s2
                  nop
                  addi        s4, tp, 731
                  srl         a7, s5, s11
                  lui         t4, 698429
                  addi        s0, s0, -773
                  slli        s2, t4, 5
                  ori         a2, t3, -1266
                  srl         zero, s10, s8
                  li         t4, 0x1 #start riscv_int_numeric_corner_stream_15
                  li         sp, 0x2e65233f
                  li         t3, 0x0
                  li         s0, 0x0
                  li         t2, 0x6c674639
                  li         a1, 0x5357414f
                  li         s11, 0x3fe6d912
                  li         s8, 0x0
                  li         a7, 0x0
                  li         s9, 0x1
                  add         t3, s3, t0
                  addi        a0, s1, -917
                  sub         s8, gp, sp
                  sub         t0, s2, s6
                  lui         a6, 1025481
                  sub         s6, s1, a4
                  add         s11, s2, a4
                  addi        t1, s7, -898
                  addi        a1, s4, 1178
                  sub         t3, tp, s7
                  sub         tp, t4, a5
                  addi        t3, a3, -963
                  add         s8, t5, s5
                  nop
                  lui         s11, 406545
                  add         a4, a1, t0
                  lui         a0, 15936
                  lui         t2, 735980
                  sub         t4, a0, t2
                  lui         a3, 933588
                  addi        t3, s11, -1595
                  add         zero, a5, a6
                  nop #end riscv_int_numeric_corner_stream_15
                  ori         tp, t1, 908
                  lui         sp, 687373
                  xor         ra, tp, s5
                  add         zero, zero, s9
                  sub         s2, s4, t2
                  sll         a3, t4, s3
                  addi        a4, s8, 365
                  add         a4, zero, s5
                  srli        a4, s7, 9
                  or          zero, a1, a5
                  sll         a7, s8, a5
                  sltiu       t0, s9, 618
                  add         sp, s4, s11
                  srli        s9, s1, 29
                  andi        zero, a0, 560
                  lui         a0, 308638
                  sra         t4, t1, s8
                  xor         s8, a1, t4
                  sub         t3, s2, s1
                  srli        t1, s1, 10
                  srai        zero, s3, 6
                  lui         zero, 821334
                  srl         s11, s4, a1
                  xori        s0, a5, 1389
                  srl         s6, a4, s5
                  lui         t4, 380917
                  sub         t2, a2, t5
                  ori         a5, s3, 1460
                  sub         gp, s8, s11
                  srl         s11, a6, a5
                  sltiu       zero, a6, 738
                  sra         t0, s4, t4
                  slli        s7, t1, 1
                  add         s11, a1, tp
                  xori        s2, a7, -196
                  add         s0, s5, gp
                  xori        a7, a0, -510
                  xori        a2, s6, -950
                  sltu        a0, a2, t1
                  slt         a6, a0, a3
                  srl         zero, a0, a6
                  sra         s5, a7, s11
                  add         a2, zero, s0
                  sltu        s0, t4, t2
                  addi        zero, s2, 100
                  andi        zero, s8, -273
                  slt         s11, t2, s7
                  or          t3, s1, t4
                  slti        s2, a7, 499
                  or          gp, s3, s5
                  xor         ra, tp, s10
                  srli        a5, s4, 14
                  srl         s9, gp, s9
                  srl         a4, tp, s10
                  add         t1, gp, t4
                  auipc       t2, 788561
                  nop
                  sra         zero, s9, s2
                  srl         zero, t3, s4
                  auipc       tp, 328918
                  xori        s8, a7, -1237
                  or          a3, s8, s9
                  slt         a2, a0, s2
                  sra         t0, s2, a3
                  srli        s4, sp, 16
                  xori        t0, s9, 1545
                  addi        a3, tp, -1807
                  and         zero, s5, zero
                  sltiu       s9, s7, -534
                  addi        zero, a0, 855
                  add         ra, s7, s4
                  srli        a7, t4, 8
                  slt         s4, t5, s11
                  lui         zero, 610085
                  ori         gp, sp, 1367
                  ori         s4, s2, 576
                  xori        a0, t3, 1503
                  add         s5, t5, a4
                  slti        s3, a3, 1713
                  srl         t2, t0, sp
                  srl         s11, s6, s0
                  sub         s4, a2, ra
                  xori        a7, t0, 1204
                  sltu        a0, t1, t1
                  sltiu       s1, sp, 991
                  lui         a6, 457069
                  srl         a0, s7, t3
                  sltiu       s11, a2, 239
                  srli        gp, t3, 14
                  and         t0, t0, zero
                  slti        s6, s9, 1875
                  sub         a6, t6, t5
                  sra         zero, s8, s8
                  slti        s3, a2, -1350
                  sltu        a1, t3, s5
                  nop
                  sra         a1, s1, s1
                  srai        a5, a4, 13
                  and         zero, a0, ra
                  nop
                  add         s6, a0, s5
                  nop
                  sltu        tp, t4, t3
                  add         a2, gp, a6
                  or          zero, s10, t0
                  nop
                  sltiu       s4, s8, -1203
                  andi        s0, s7, -833
                  sltu        s6, t3, s8
                  sltiu       a5, t5, -1234
                  sltiu       a3, sp, -659
                  add         s3, a4, s9
                  slti        zero, s3, 128
                  and         a7, t1, a3
                  lui         zero, 617966
                  sltu        a6, s2, s3
                  sll         sp, s9, s9
                  andi        t0, gp, 667
                  lui         s4, 550192
                  andi        a1, t0, 258
                  srl         a3, gp, a6
                  srli        s2, s8, 31
                  andi        s2, t6, 522
                  auipc       s1, 686868
                  nop
                  or          s3, a4, t3
                  nop
                  nop
                  sltiu       s5, s1, -1902
                  sub         s2, s1, t4
                  or          a0, t1, s0
                  xor         t3, t4, tp
                  and         zero, a6, zero
                  xor         a4, a0, s3
                  andi        s0, a5, -1611
                  addi        a7, t6, -1423
                  srli        t2, s9, 0
                  xor         s9, t0, t6
                  sltiu       a6, a1, -527
                  xori        zero, t2, -1556
                  sll         a0, t0, t4
                  xori        a0, t2, 1743
                  lui         a3, 867807
                  or          a5, s2, a1
                  add         ra, ra, t6
                  add         s6, sp, t3
                  nop
                  srli        ra, s2, 15
                  srli        s5, t2, 17
                  ori         t1, t6, 670
                  sra         s9, s11, t4
                  ori         zero, a0, 1343
                  nop
                  add         a1, s10, a7
                  xori        t2, gp, -1695
                  srai        s11, sp, 8
                  srl         a6, a0, s8
                  sltiu       s6, zero, -437
                  addi        t1, s2, -574
                  srli        a3, s10, 3
                  sra         gp, a4, s1
                  and         a5, t4, s11
                  slt         s2, t1, ra
                  slti        a4, a4, -1639
                  auipc       s0, 291455
                  slt         gp, s0, s11
                  lui         a3, 490204
                  sltu        s11, s1, s11
                  sltiu       s0, tp, -162
                  or          gp, a3, a1
                  slli        s1, a6, 4
                  srli        s6, zero, 2
                  srli        a1, sp, 14
                  srai        s11, zero, 28
                  srai        gp, t4, 20
                  xor         s11, t5, s0
                  andi        a5, s10, 266
                  srli        t2, a1, 24
                  xor         s1, a2, t5
                  or          t2, a0, s4
                  xor         a6, a4, s0
                  srl         zero, s5, s10
                  lui         a3, 815993
                  sub         a4, a4, sp
                  slti        zero, s4, 1619
                  add         s4, a2, t6
                  slti        gp, a1, 1784
                  xor         t2, ra, s1
                  sltu        tp, a3, sp
                  srai        t3, s5, 26
                  or          a6, s10, a2
                  sra         t1, s0, a2
                  andi        s3, t2, 480
                  add         t0, s7, a0
                  slt         t1, s2, s4
                  slti        gp, s1, 1778
                  sub         s2, t4, t4
                  addi        s3, s3, 915
                  xor         sp, s7, a6
                  xor         s1, s7, s6
                  srai        a7, s11, 14
                  addi        s4, a7, 1012
                  sub         s8, ra, a0
                  ori         a4, s5, 1529
                  sub         a4, a5, a4
                  sra         s3, a7, tp
                  andi        s2, s6, -105
                  and         a6, a5, a1
                  sll         t0, t0, s7
                  addi        a3, s5, -248
                  srl         s8, a1, t2
                  andi        s7, t6, -500
                  slt         a3, s1, a5
                  sltu        t1, zero, ra
                  sltiu       t3, tp, -683
                  sll         t4, t4, t5
                  sltu        sp, s1, sp
                  sub         s7, s3, s11
                  srl         s0, a4, a0
                  slti        ra, s3, -1269
                  or          s6, tp, s3
                  sltu        t3, gp, s6
                  ori         gp, a5, -1142
                  add         s6, a3, s3
                  srli        t0, s5, 20
                  nop
                  addi        s3, s0, -2042
                  sltu        s6, t0, a1
                  sll         t4, tp, ra
                  sltiu       t0, zero, -1402
                  srli        a3, zero, 7
                  nop
                  slt         zero, s2, gp
                  xori        s3, s0, 2009
                  xor         s6, a6, t2
                  xori        s0, sp, -488
                  slti        zero, ra, 207
                  sll         a2, a0, ra
                  addi        s2, t1, -943
                  sll         zero, sp, tp
                  add         ra, s7, a1
                  sra         t0, a0, zero
                  slt         s9, s10, a5
                  add         gp, s3, t6
                  sltiu       a6, s10, 1655
                  sltiu       sp, t0, -1107
                  ori         s3, a1, -1258
                  or          t3, t0, a6
                  nop
                  slt         s8, a3, a4
                  ori         t4, a0, -1929
                  sra         s9, t2, t2
                  srl         s9, s5, s2
                  sltiu       t3, s6, 1042
                  slt         a5, a0, t6
                  sltiu       t3, s9, -167
                  slti        zero, gp, -1513
                  sltu        tp, t1, a4
                  sltiu       t3, t0, -1113
                  srai        s4, zero, 29
                  sltu        zero, s8, gp
                  andi        zero, s5, 301
                  ori         t4, s8, -659
                  andi        ra, zero, -1256
                  sra         t4, s2, a3
                  sll         t3, s3, s6
                  and         s9, s8, a5
                  or          s4, t2, s10
                  xor         zero, zero, s1
                  xori        zero, s8, 313
                  xor         sp, ra, s10
                  nop
                  srai        s4, tp, 9
                  slti        a6, s4, 1753
                  sltiu       s2, a3, 1499
                  addi        s3, t2, 345
                  srai        s7, s10, 2
                  slli        a4, a0, 8
                  add         gp, t2, gp
                  auipc       zero, 34039
                  and         sp, s11, t3
                  sra         s7, t1, t0
                  sll         t0, s11, gp
                  sll         zero, s1, s0
                  nop
                  xori        a4, s5, -391
                  andi        a5, a6, 1531
                  srli        zero, s8, 27
                  srl         zero, t3, s11
                  and         tp, sp, t0
                  srai        tp, ra, 14
                  addi        a0, t4, -728
                  xor         t0, s1, s6
                  xor         zero, sp, a5
                  auipc       s11, 1029523
                  andi        zero, tp, 1594
                  sltu        gp, a7, a2
                  srl         s9, s7, a2
                  sltu        s8, sp, s4
                  add         sp, ra, s8
                  srai        s8, sp, 19
                  addi        a0, t3, 1546
                  lui         a7, 36308
                  sltu        sp, a7, t1
                  xori        s1, t1, -1954
                  sltiu       s11, a2, -2024
                  xor         zero, t1, s5
                  lui         s4, 747543
                  nop
                  sll         a7, s11, t4
                  sltiu       s7, s10, 1449
                  sll         s3, s7, s0
                  sltu        s0, s1, a3
                  sra         gp, a5, t3
                  srl         a6, s9, a1
                  sltiu       s11, a0, 1021
                  slli        t2, s2, 16
                  or          zero, sp, s8
                  or          t2, a7, zero
                  nop
                  slli        ra, s3, 11
                  sltiu       tp, s3, 177
                  auipc       a1, 803507
                  srai        a6, s4, 6
                  sub         tp, s4, s0
                  xori        s9, zero, -554
                  addi        sp, s5, 1839
                  sltiu       t2, sp, -838
                  addi        s9, a3, -1336
                  sub         s4, t4, a1
                  auipc       t3, 562082
                  slli        s9, ra, 9
                  ori         t0, s8, -492
                  srli        s8, s9, 6
                  and         s6, a1, s8
                  xor         gp, s1, s3
                  slti        s6, s5, 409
                  add         a1, s7, a6
                  lui         a2, 559739
                  ori         s11, t5, 1437
                  addi        a1, t6, 1438
                  add         zero, a5, t2
                  slti        t0, s3, -485
                  sltu        s7, s7, a5
                  slt         s9, s5, s1
                  sub         a2, a0, s2
                  add         t0, a3, a3
                  srai        s6, s4, 18
                  sra         s5, s8, tp
                  ori         s6, s8, -46
                  nop
                  sra         s0, t4, t4
                  srl         zero, a2, t5
                  slti        s9, a1, -1011
                  sltu        s4, s6, gp
                  xori        s8, tp, 1862
                  sub         s7, a5, s5
                  srli        a7, a1, 15
                  or          zero, t1, t3
                  sll         s3, a6, zero
                  and         gp, s2, a4
                  auipc       s5, 987259
                  sra         s8, a1, t5
                  sltiu       t0, a5, 1342
                  sub         s8, s2, a2
                  sltiu       t3, s1, 140
                  srl         s3, a2, a7
                  srl         a0, s5, zero
                  sltu        s6, t1, s3
                  slti        zero, a4, -1770
                  xori        t0, s11, 1053
                  sub         a7, s0, s5
                  andi        a2, a4, -1310
                  sltiu       sp, s2, -472
                  slti        t4, gp, 1554
                  or          zero, t6, t4
                  slli        tp, t5, 16
                  lui         s5, 67518
                  xori        s7, a0, 706
                  sub         s5, s5, s3
                  srl         a0, s0, t2
                  sltu        sp, t3, tp
                  lui         s5, 1027249
                  or          s0, s3, a4
                  slli        a5, a0, 7
                  andi        zero, gp, 1494
                  lui         s11, 244324
                  ori         t0, a4, -150
                  lui         ra, 465317
                  slli        s3, ra, 7
                  slti        tp, s8, -942
                  xor         s5, a3, s3
                  sll         s2, sp, s10
                  sra         s6, a1, s10
                  sltiu       s0, t5, -85
                  slli        s4, s11, 4
                  addi        s9, s2, 1329
                  srli        a3, t4, 31
                  and         tp, a3, s11
                  addi        ra, ra, 109
                  sub         zero, s7, t4
                  or          s0, t5, a1
                  ori         zero, s7, 1790
                  sub         t4, a3, s11
                  slti        s1, a3, 751
                  or          zero, s6, s2
                  add         a0, sp, s11
                  slti        a7, tp, -265
                  xor         ra, a6, ra
                  sub         zero, a7, a5
                  andi        a6, a3, 1501
                  xori        a6, s3, -178
                  sltiu       t2, s9, -783
                  ori         s7, a6, 673
                  lui         tp, 829950
                  lui         s0, 629098
                  andi        s0, s4, -1946
                  xor         zero, t1, ra
                  slt         s6, t0, a5
                  nop
                  sra         s9, s11, s1
                  or          tp, gp, s9
                  sll         s6, a3, tp
                  xori        zero, t5, -1536
                  xori        zero, a3, -1342
                  slti        a1, s0, 1165
                  slt         a5, tp, a3
                  slt         s5, s0, s11
                  xori        zero, a4, -1212
                  nop
                  andi        t4, t3, 1968
                  sub         a3, t4, gp
                  add         gp, a5, s8
                  srli        ra, a3, 24
                  srli        t3, a3, 23
                  xori        s8, a7, 870
                  sra         s2, t0, a3
                  add         t0, s11, a6
                  srl         a6, t6, s4
                  sltu        t4, a1, s0
                  sltu        s7, a6, a1
                  li         t4, 0x1 #start riscv_int_numeric_corner_stream_14
                  li         t3, 0x41bd8778
                  li         s11, 0x0
                  li         s3, 0x0
                  li         t0, 0x0
                  li         a1, 0x0
                  li         a5, 0x45c36a0b
                  li         s2, 0x0
                  li         s0, 0x0
                  li         s9, 0x1
                  sub         s8, a4, a6
                  add         s11, s0, gp
                  nop
                  add         gp, t3, a4
                  lui         s3, 316574
                  addi        a3, a6, 401
                  add         a6, t0, tp
                  sub         a5, s3, s1
                  addi        s11, s10, 579
                  nop
                  add         zero, t2, s0
                  sub         zero, a6, s2
                  addi        a3, ra, -459
                  sub         t0, s10, t2
                  lui         a7, 631714
                  nop
                  addi        sp, s2, 66
                  addi        zero, zero, -78
                  lui         zero, 966875
                  sub         t4, s3, ra
                  add         s2, t5, s2
                  sub         t0, s4, s11
                  lui         t1, 423446
                  add         ra, a2, ra
                  lui         a5, 995562
                  lui         s0, 279600
                  addi        t3, a4, 305
                  nop
                  lui         s8, 447115
                  add         s1, s10, s9 #end riscv_int_numeric_corner_stream_14
                  lui         a2, 429200
                  andi        s6, s8, -1711
                  slt         a2, s11, s1
                  xori        ra, t2, 1719
                  sub         s6, t5, a3
                  sltiu       t3, ra, 1690
                  or          sp, t0, s5
                  sll         s1, s9, s9
                  addi        s2, s7, 715
                  ori         s4, s0, -1778
                  sll         zero, s10, s11
                  srl         t2, s2, a4
                  sll         t4, s7, s0
                  or          s1, t5, tp
                  slti        s2, s10, 1212
                  srl         s0, t3, zero
                  sltiu       tp, a7, 1555
                  andi        ra, s8, -1971
                  nop
                  andi        sp, a2, -847
                  sra         t1, a0, s6
                  and         a5, a6, a0
                  nop
                  nop
                  andi        a7, tp, 636
                  addi        s4, s10, 38
                  add         s4, gp, s2
                  srai        a4, s9, 15
                  sltu        s4, s0, t3
                  sra         s4, a2, a0
                  ori         s0, s0, 2030
                  and         ra, t1, t4
                  sll         gp, s0, s3
                  xori        a6, t5, 260
                  slt         zero, s3, s7
                  sll         s1, gp, gp
                  slti        s4, s5, 1845
                  srai        t2, t6, 21
                  andi        tp, s6, 85
                  add         sp, t1, tp
                  sltu        a2, s2, s6
                  addi        t0, t6, -1911
                  slli        a5, zero, 12
                  sub         tp, t0, s3
                  sll         s0, t2, sp
                  sltiu       t2, gp, 1740
                  srl         zero, t0, a7
                  ori         a1, s6, -151
                  add         a2, s7, ra
                  or          s2, a2, a3
                  srli        s11, a1, 7
                  slli        a1, sp, 8
                  xori        tp, s2, 674
                  sltu        gp, s1, a2
                  nop
                  xori        s1, ra, -1991
                  sll         tp, s9, t5
                  or          a6, s11, tp
                  srli        zero, s11, 24
                  nop
                  sltiu       s3, a0, -338
                  ori         s5, s1, 501
                  auipc       a2, 377275
                  sltiu       zero, t3, -1736
                  andi        t4, a6, 1238
                  xori        s6, s5, 677
                  lui         ra, 793429
                  xori        s3, a5, -1855
                  sra         zero, t2, ra
                  xori        sp, s2, 439
                  srli        ra, s1, 30
                  xor         zero, a1, s5
                  xori        t1, t3, 977
                  srli        a0, t1, 9
                  ori         t3, s1, -1628
                  sltiu       t3, t1, -131
                  sltiu       a1, a3, -614
                  nop
                  srl         gp, ra, zero
                  ori         a3, a5, -1101
                  slt         s8, a1, s5
                  xori        s2, a6, 1063
                  ori         a6, a2, -262
                  srai        zero, t5, 2
                  sra         gp, s2, a5
                  slti        zero, t1, -804
                  srai        a4, t5, 23
                  add         t3, a5, a3
                  xor         a0, t2, zero
                  slti        s7, s5, -1764
                  sltu        s5, t2, s5
                  xor         t2, s3, s6
                  or          t4, t6, zero
                  auipc       t4, 225303
                  sltu        sp, a2, s1
                  srl         a3, s10, ra
                  nop
                  lui         sp, 17192
                  sra         s2, t5, t2
                  auipc       s8, 1028868
                  slli        s9, tp, 2
                  slti        s11, ra, 1751
                  lui         s8, 279985
                  xori        s3, a6, 1535
                  srai        t0, a2, 1
                  ori         sp, a6, 538
                  addi        s8, s0, -433
                  srli        a2, a6, 30
                  ori         s5, ra, -1069
                  xori        a2, s1, -2006
                  or          a6, s5, t3
                  lui         s1, 691694
                  sra         t2, sp, s9
                  nop
                  or          s8, s0, t5
                  sub         zero, a1, s9
                  andi        s0, t2, -1048
                  ori         t4, s0, -653
                  lui         sp, 135620
                  srl         s1, a2, t4
                  xori        a1, s9, 772
                  slli        s11, s10, 4
                  srl         zero, ra, s11
                  sub         zero, a6, t2
                  sll         s8, s0, t4
                  sltu        s2, a3, tp
                  addi        s5, s10, 1572
                  slti        a2, s1, 572
                  and         a5, s7, s4
                  srai        s5, a0, 28
                  auipc       a7, 707612
                  slti        s6, a1, -725
                  auipc       a7, 154192
                  xor         gp, t0, s8
                  lui         s11, 677728
                  srl         sp, s7, gp
                  and         a2, t1, t3
                  srl         a4, t2, s11
                  nop
                  srai        s0, s7, 4
                  srli        s6, a3, 8
                  xori        zero, s3, -1698
                  srl         s0, t5, t5
                  srai        s11, t0, 12
                  nop
                  xori        zero, sp, 240
                  lui         a4, 137799
                  sll         s8, s5, s6
                  addi        t4, t0, -1926
                  nop
                  auipc       s9, 858253
                  nop
                  sltu        s4, s6, s7
                  sub         t1, s3, t4
                  sltiu       t0, s9, -1762
                  slt         zero, s2, s9
                  and         s11, a2, zero
                  lui         ra, 53651
                  addi        t2, s11, -1833
                  nop
                  slt         t4, sp, a1
                  srai        tp, t5, 25
                  sll         s0, s7, s6
                  srli        s0, s6, 20
                  xor         s8, s0, a2
                  srl         t3, t4, t2
                  or          a4, s6, s3
                  sltiu       t3, a2, 307
                  nop
                  ori         a4, s8, 312
                  auipc       s4, 36770
                  slt         a5, s7, s6
                  nop
                  srai        t2, a1, 21
                  and         zero, s8, s9
                  srl         s3, ra, s5
                  xori        tp, t0, 1563
                  sra         s0, t6, a0
                  or          a1, s9, t1
                  xori        s7, a0, 800
                  sltiu       s4, sp, -1940
                  slli        s1, a4, 29
                  sra         a7, a0, a0
                  sltiu       t0, t4, -582
                  sltu        zero, s5, t2
                  ori         a6, zero, -1560
                  add         s6, zero, t0
                  sub         s2, t0, s5
                  and         ra, s1, zero
                  sub         s2, t6, s0
                  sub         s0, s1, a2
                  slt         a3, t5, s10
                  sub         s7, s1, t0
                  lui         tp, 295367
                  srai        a7, t0, 19
                  auipc       a6, 118439
                  slti        a5, a7, -1392
                  addi        a1, t3, -939
                  and         gp, s11, s5
                  slli        t1, s8, 9
                  srli        a5, s11, 22
                  srai        gp, sp, 24
                  nop
                  srli        t3, s4, 21
                  ori         t0, s5, -558
                  xori        s11, s8, -1410
                  andi        a7, s10, -187
                  srai        s11, s9, 18
                  slti        t4, t3, -2027
                  add         zero, a1, a3
                  srai        tp, a7, 3
                  auipc       t4, 564698
                  addi        a6, t0, -1316
                  srai        s9, s4, 19
                  nop
                  lui         gp, 354971
                  slti        ra, ra, -1206
                  andi        t2, s4, -440
                  sll         a2, sp, t5
                  ori         zero, ra, -1378
                  nop
                  lui         a3, 565653
                  srai        s6, t3, 14
                  and         zero, t3, s9
                  addi        gp, zero, 823
                  ori         s3, tp, 1025
                  sltu        a3, t6, zero
                  addi        s5, s2, 1890
                  sra         zero, a0, ra
                  sra         s0, s3, a4
                  sll         a5, s5, s5
                  sltu        sp, s4, t4
                  sub         a5, ra, t4
                  and         s11, t2, s0
                  sltiu       s6, t1, -1414
                  addi        zero, gp, 1454
                  sltu        s7, s4, ra
                  sra         zero, a4, t2
                  srli        s4, zero, 11
                  and         a5, s1, t5
                  xor         sp, s11, a3
                  slt         zero, s11, a2
                  addi        s7, a2, 711
                  sll         t1, s0, s0
                  xori        zero, s6, 503
                  ori         a5, t2, -1970
                  sltiu       gp, s9, 1693
                  slti        ra, ra, -678
                  addi        zero, t0, 850
                  sltu        a0, s11, a5
                  sra         s0, s4, s3
                  sltiu       a6, a4, 1326
                  srl         s11, a1, a0
                  srai        a0, a5, 13
                  add         sp, sp, a5
                  xori        zero, t1, -1161
                  srai        t3, t0, 23
                  sltiu       a5, a7, 83
                  nop
                  sll         t4, s0, gp
                  ori         sp, gp, -2006
                  sltu        a7, s5, s7
                  sltu        a6, t6, a1
                  xori        s5, gp, 2021
                  slti        s9, sp, -374
                  addi        s5, s10, -609
                  sub         zero, t0, a2
                  srli        s9, s6, 7
                  addi        s8, a7, 1983
                  sltiu       a0, s10, -819
                  andi        sp, t4, -721
                  nop
                  xor         tp, s2, a2
                  lui         s8, 414437
                  srl         s11, gp, a4
                  auipc       tp, 350093
                  slt         s0, ra, a5
                  or          a1, t0, t4
                  ori         a7, s0, 1400
                  slti        sp, s2, 935
                  sll         s2, t4, s2
                  sltu        zero, t3, s2
                  sub         a4, t6, s11
                  slt         a6, t5, t2
                  sra         s5, sp, t0
                  xor         a0, s10, t3
                  xori        s3, s2, -1241
                  sltu        s5, s3, s6
                  xori        t4, s10, 2030
                  add         s11, t6, t0
                  xori        a2, t5, 1904
                  slli        s2, zero, 14
                  sltiu       s1, t2, -192
                  sra         gp, a1, zero
                  srl         t0, s7, a0
                  or          t1, s5, s11
                  sub         sp, a4, s9
                  xori        a3, t1, -735
                  nop
                  srai        t1, gp, 14
                  lui         sp, 48398
                  slt         a5, t2, gp
                  nop
                  slt         s3, s1, a7
                  sll         s2, s8, s5
                  sltu        s1, t5, gp
                  sltiu       s5, a3, 2001
                  sll         t2, a7, s2
                  srl         t3, s4, t5
                  slli        sp, s2, 17
                  xor         sp, s11, a4
                  sltu        sp, t5, s6
                  sltiu       zero, s6, 942
                  add         ra, sp, s0
                  sltu        t3, a5, t4
                  srl         s5, s6, gp
                  slti        s0, t2, 1496
                  slli        a7, s8, 5
                  slt         a2, t2, a1
                  or          a0, s11, s10
                  and         s8, ra, a3
                  sub         s9, t1, sp
                  add         t4, s0, a5
                  sra         t3, t4, a0
                  sltiu       s5, s0, -254
                  slt         t4, a3, a6
                  and         a1, ra, sp
                  nop
                  xori        gp, s1, 1696
                  sub         a3, s5, t0
                  srl         s7, s7, zero
                  srl         t4, t1, t3
                  xori        t4, s2, 432
                  srl         s5, s2, t2
                  slli        s7, s9, 29
                  sub         s11, tp, s5
                  and         a4, a5, s2
                  ori         t4, s8, 355
                  nop
                  ori         t2, s7, -1743
                  sub         s5, s0, tp
                  sra         a1, s5, zero
                  sltiu       s0, a3, 886
                  add         zero, s8, s7
                  srli        a6, zero, 3
                  and         s4, a6, a1
                  sll         gp, s9, s11
                  auipc       a4, 861991
                  srai        a3, s4, 5
                  xori        s9, s0, -91
                  sll         sp, a4, a3
                  sltu        s9, t3, a0
                  xori        t4, t0, -1448
                  srli        a6, tp, 10
                  slti        s8, a3, 882
                  sltiu       zero, sp, 1596
                  slli        t2, t6, 13
                  sll         a1, a1, s7
                  sltiu       s11, a5, -380
                  nop
                  xor         a7, s4, zero
                  sltiu       zero, a4, -653
                  xori        ra, a1, -1584
                  ori         a1, t3, -102
                  ori         zero, t5, -302
                  srai        s8, s11, 6
                  srai        s9, s9, 6
                  lui         zero, 683722
                  srl         a7, a3, s11
                  sltiu       a6, tp, -1190
                  sltiu       sp, a5, 1079
                  srl         t2, a6, s2
                  addi        tp, s4, -1685
                  sra         zero, s0, t6
                  xori        zero, s8, -1277
                  srli        ra, s5, 20
                  srai        s1, s8, 19
                  sra         s0, t2, s1
                  andi        s3, ra, 928
                  xori        t3, t5, 310
                  sll         s8, s11, t1
                  sub         a5, t2, zero
                  nop
                  auipc       s8, 332985
                  auipc       s8, 250955
                  sltiu       zero, s9, 1784
                  or          s4, s8, s0
                  sra         t2, a0, sp
                  andi        a5, a3, 1345
                  and         zero, s9, t4
                  srai        s11, tp, 5
                  add         t2, s3, s5
                  slti        a7, a4, 1431
                  andi        a6, s5, -1656
                  sll         a7, a2, t2
                  and         s0, a4, gp
                  xor         t1, s3, s1
                  sub         gp, s9, s7
                  xor         s11, a1, a2
                  add         s2, s1, t4
                  xor         zero, a0, s5
                  srli        zero, t6, 29
                  sltiu       a3, s11, 1699
                  sra         t3, s8, t2
                  addi        s4, a6, -280
                  add         zero, t0, a3
                  sll         a4, gp, sp
                  and         a3, a4, t4
                  ori         s7, t0, 916
                  xor         a4, a0, a7
                  ori         a3, s9, 1613
                  addi        a4, a3, 1697
                  srli        ra, s9, 14
                  andi        s1, a1, -711
                  ori         gp, t3, -1616
                  ori         a1, sp, 1809
                  srli        zero, a1, 17
                  srai        gp, a4, 17
                  auipc       s2, 403847
                  xori        t1, s2, -422
                  nop
                  sltu        zero, s3, a2
                  srli        ra, t3, 31
                  sltiu       s5, zero, -1562
                  auipc       s2, 607859
                  srai        t4, a5, 16
                  slt         gp, tp, s1
                  slli        s4, a3, 17
                  xori        a0, s4, -277
                  xor         zero, t5, s11
                  add         t3, s10, s4
                  slti        t4, s9, -464
                  slti        a7, gp, 715
                  andi        a2, a6, -1433
                  add         a3, s8, s8
                  lui         s6, 743947
                  slti        a6, s11, -2011
                  xori        t0, t0, 1237
                  ori         a7, s10, 1733
                  slti        s3, tp, 68
                  sltu        t0, s1, gp
                  slt         zero, a4, t5
                  sltiu       a7, s0, 1027
                  xori        s1, a5, 1853
                  sll         ra, t0, a1
                  sra         t2, s9, sp
                  or          s2, s5, zero
                  sll         s0, t2, a3
                  auipc       a0, 428162
                  slti        a3, t6, 693
                  or          s5, t2, s10
                  andi        a6, a5, 579
                  sll         s3, t2, s0
                  and         s8, s4, t1
                  sll         a4, a4, s7
                  slti        a0, s8, 1055
                  slt         s9, s4, t1
                  sra         t4, s5, a5
                  sltu        a5, s3, s9
                  srl         s4, s10, a6
                  or          a4, s5, a6
                  add         zero, zero, s3
                  srl         s9, a7, t4
                  srl         zero, sp, s1
                  xor         s9, tp, t5
                  slt         s5, t1, t1
                  sll         s1, s6, zero
                  andi        gp, a1, 283
                  slli        a5, s9, 22
                  xor         s4, t3, zero
                  nop
                  sra         zero, zero, s3
                  srl         zero, tp, s3
                  or          a1, s6, t2
                  srl         zero, t5, sp
                  addi        t1, a1, -1274
                  sltu        t0, s10, a1
                  ori         s2, a6, -181
                  sra         a4, a1, t2
                  slti        t0, s0, 1953
                  sub         s1, s3, s0
                  xori        a7, sp, 917
                  srl         tp, a6, t4
                  ori         zero, t4, -1902
                  add         s0, t5, zero
                  sltu        a3, a6, s4
                  slt         s3, t4, t2
                  addi        a4, a2, -1441
                  srai        gp, t2, 1
                  sltu        t4, s6, s11
                  srai        zero, a0, 13
                  srai        s6, s6, 1
                  srli        a5, s0, 29
                  slli        s0, sp, 10
                  nop
                  lui         zero, 176417
                  slt         t0, tp, a6
                  xor         t3, a7, s3
                  sll         t3, a3, a1
                  sltu        s8, t1, a4
                  andi        t4, tp, -879
                  srai        a7, s0, 31
                  slti        a3, s8, 1186
                  sltiu       a4, t1, 961
                  lui         zero, 413531
                  sll         s3, t5, a0
                  slti        zero, ra, -1555
                  sll         t2, t5, a2
                  and         zero, t2, a6
                  sltiu       a3, s5, 1741
                  auipc       s1, 620614
                  ori         t4, a4, -1863
                  srl         s8, s8, s0
                  slti        s0, s10, -389
                  lui         s3, 779512
                  srli        s4, a4, 11
                  auipc       a4, 278117
                  xor         s7, s4, s9
                  addi        gp, a1, -1179
                  srli        s4, t3, 16
                  srli        s5, zero, 7
                  auipc       a4, 246074
                  addi        s0, s7, 1348
                  sltu        zero, t3, t6
                  andi        sp, a4, -1391
                  addi        ra, a4, 2037
                  srai        s2, a6, 31
                  sltu        zero, s11, t2
                  xori        t2, a3, 104
                  srai        t4, gp, 16
                  nop
                  sub         a1, a0, t2
                  sltiu       a2, t2, 537
                  slt         a6, s4, ra
                  srli        s2, a7, 30
                  andi        s5, s7, 1683
                  sltiu       a5, a7, -630
                  srli        t1, t6, 19
                  sub         ra, t3, a3
                  sltu        a4, a0, s11
                  srli        s8, s0, 13
                  slt         s0, a0, s6
                  ori         sp, zero, 1722
                  slti        a5, t2, 850
                  andi        tp, s6, -536
                  sltiu       s6, t5, 1647
                  ori         zero, t3, 671
                  sltu        a2, s4, a3
                  sltu        s9, t0, t3
                  sra         s5, t6, t6
                  srli        ra, tp, 5
                  andi        a7, s4, 1107
                  slti        s1, s1, 1217
                  nop
                  srl         s5, a7, s9
                  add         a3, s0, s1
                  xor         t2, t2, a6
                  nop
                  xor         sp, a3, ra
                  sub         a3, s1, s8
                  or          s5, a2, s4
                  srli        t3, s0, 13
                  auipc       s9, 92747
                  sltu        zero, t6, tp
                  auipc       zero, 650204
                  addi        ra, ra, 835
                  srl         a3, s5, s4
                  lui         gp, 664829
                  ori         sp, s2, -59
                  sll         s6, s1, s10
                  nop
                  sltu        t0, s3, t4
                  xor         t3, s0, t3
                  sltiu       tp, s10, 928
                  andi        s4, a1, -1069
                  sltu        s11, s4, s4
                  xori        s2, gp, -1752
                  slti        t4, s7, -1606
                  srai        zero, s0, 4
                  srl         zero, a1, s3
                  slti        s3, s8, 1081
                  slli        s5, a0, 18
                  srli        s2, s4, 0
                  nop
                  sltiu       s9, a2, -650
                  sub         a5, t5, t3
                  srai        s5, s1, 13
                  xori        s4, a7, -864
                  nop
                  add         t2, t1, a2
                  li         s9, 0x31cd999 #start riscv_int_numeric_corner_stream_9
                  li         s5, 0x1
                  li         t3, 0x25148523
                  li         s11, 0x1d4e8e26
                  li         s8, 0x0
                  li         a3, 0x0
                  li         t4, 0x0
                  li         a2, 0x0
                  li         s3, 0x0
                  li         s0, 0x0
                  lui         s9, 499420
                  nop
                  lui         s3, 808066
                  sub         t4, s2, s3
                  sub         zero, t5, a0
                  addi        a1, t2, -49
                  add         a1, s8, s3
                  addi        t2, s8, 1296
                  sub         sp, t0, t3
                  nop
                  lui         a6, 396847
                  addi        s6, t0, 633
                  add         t1, a0, s3
                  lui         s1, 723755
                  sub         zero, ra, s2
                  add         s5, s6, s11
                  add         a7, t6, s4 #end riscv_int_numeric_corner_stream_9
                  sub         a3, ra, a6
                  or          t2, s8, s2
                  andi        gp, s7, -1816
                  and         sp, a7, s9
                  srl         a0, s4, s0
                  sltiu       s1, s6, -298
                  ori         s6, t4, -739
                  sub         t2, sp, a4
                  srli        tp, a1, 15
                  srl         s3, zero, a1
                  slt         zero, t1, t2
                  xori        zero, s2, 388
                  sll         tp, s3, s1
                  srli        tp, s7, 11
                  srai        a3, ra, 8
                  ori         zero, s3, -558
                  srl         s1, a7, s5
                  slli        a5, a0, 11
                  sub         s9, ra, t2
                  ori         s2, s4, -536
                  sltiu       t3, a0, 1539
                  xor         s6, gp, t5
                  add         t0, t1, s8
                  or          a0, a1, a6
                  sltu        zero, s6, t3
                  srli        s2, s8, 17
                  slt         gp, a1, t2
                  sub         a2, tp, t0
                  srl         sp, s2, a5
                  srli        s7, a6, 26
                  sll         gp, tp, a2
                  and         s9, a2, gp
                  slli        s9, tp, 29
                  sub         s8, t6, s7
                  srl         zero, a6, s6
                  addi        s5, sp, 782
                  xor         a0, a2, gp
                  lui         t3, 315577
                  srl         t2, t5, a0
                  addi        s5, s8, -1696
                  sra         a5, s9, a2
                  sra         s5, a5, t6
                  nop
                  add         s9, s7, s8
                  slli        s8, s8, 29
                  slli        s6, t6, 30
                  xori        s7, gp, 1356
                  and         s3, a6, a1
                  and         s2, tp, s2
                  sltu        a6, t2, ra
                  slti        a6, t3, 1151
                  slti        sp, a4, 1187
                  slti        s4, a4, -204
                  or          s3, t2, zero
                  srai        a4, a6, 4
                  nop
                  add         t4, s3, s6
                  sra         s7, s4, s3
                  auipc       s7, 686076
                  or          t4, gp, a7
                  lui         sp, 894159
                  addi        tp, a3, 1765
                  or          s1, t6, gp
                  sra         a0, t2, gp
                  sra         zero, a0, t1
                  srai        sp, a7, 14
                  addi        ra, t1, -704
                  andi        a6, t0, 83
                  sub         a7, s10, s10
                  srli        a1, s9, 27
                  auipc       s3, 255043
                  xori        s8, s4, 1125
                  xor         a2, s10, s4
                  srai        ra, a2, 7
                  nop
                  add         s6, s0, s1
                  lui         t2, 301887
                  or          zero, a4, s4
                  slti        a1, s10, -1424
                  xor         zero, ra, s3
                  lui         s3, 111203
                  slti        t2, s5, 1506
                  slti        a3, s5, 816
                  or          t1, a5, s10
                  slti        tp, s8, 238
                  and         zero, t4, s9
                  sltiu       ra, s10, -1625
                  andi        zero, s8, -679
                  lui         a0, 296063
                  add         a5, a2, a6
                  slli        s8, t1, 20
                  sltiu       ra, s5, -456
                  and         s4, t5, a7
                  sra         zero, s11, t6
                  srl         t3, a2, a4
                  slli        t3, a0, 7
                  xori        a1, tp, -1492
                  xor         a0, a1, t5
                  auipc       s1, 866563
                  xor         s3, s9, a3
                  sll         a2, t2, gp
                  srai        s11, tp, 8
                  add         gp, s3, s7
                  sltu        a4, tp, a6
                  lui         tp, 880090
                  sltu        s7, a2, sp
                  andi        s2, a7, 774
                  sub         sp, t5, t2
                  ori         t0, a0, -1281
                  slti        a7, a7, 31
                  srai        a7, tp, 25
                  ori         a2, ra, 819
                  and         t4, a1, s6
                  or          a1, zero, a4
                  sltiu       a0, a3, -665
                  addi        a7, t5, -701
                  xori        t1, a4, -98
                  or          zero, a6, s2
                  andi        zero, s4, 1552
                  sub         a2, t6, gp
                  auipc       tp, 460299
                  srai        s4, s6, 20
                  sra         t2, s0, s10
                  andi        s0, t0, -1445
                  auipc       t0, 289262
                  lui         t0, 728608
                  ori         zero, a5, 1679
                  sltiu       zero, t6, 1681
                  or          t3, tp, a1
                  sll         s9, t1, s2
                  sltiu       a4, t1, -1413
                  sra         t4, s0, s1
                  sll         s8, t6, s1
                  sll         a3, a7, a3
                  xori        t2, t4, 721
                  srl         s11, a3, a6
                  and         s1, s6, s5
                  sltiu       s6, s9, 1724
                  auipc       sp, 933846
                  and         a3, a6, s1
                  sll         tp, zero, zero
                  xori        s2, s9, -613
                  slti        t2, s0, -1804
                  slti        s3, s7, -1857
                  ori         t3, s3, 323
                  add         t4, s10, t0
                  xor         s1, a6, a4
                  sra         zero, s1, s8
                  xor         t1, s6, s10
                  sltu        gp, s9, s2
                  add         a5, a4, t1
                  ori         s6, sp, 574
                  slt         s1, a7, s11
                  sltiu       s9, s3, -250
                  add         s7, s7, a0
                  slti        s4, a3, -1244
                  lui         s1, 424369
                  nop
                  slti        t2, a6, 1544
                  addi        s5, s0, -938
                  addi        sp, a6, -633
                  addi        s2, a3, 1997
                  srl         zero, a7, s5
                  xor         a0, a6, a5
                  srli        s11, s6, 24
                  lui         t3, 555874
                  slt         t3, s11, a7
                  sub         t0, t0, a0
                  srai        t1, t4, 26
                  srli        s11, a1, 0
                  addi        zero, s4, 951
                  sltiu       s4, t2, 1489
                  xor         s1, a1, a3
                  auipc       t3, 605265
                  and         a3, gp, a6
                  slli        t2, ra, 31
                  slti        a7, t2, 1642
                  sll         a6, t2, t6
                  sub         a7, a4, a3
                  sra         s6, a7, zero
                  lui         s8, 424682
                  srai        s6, s1, 0
                  sub         gp, s6, a3
                  auipc       s2, 333764
                  sub         a5, a3, gp
                  add         zero, s4, a0
                  li         t4, 0x63905c8d #start riscv_int_numeric_corner_stream_10
                  li         a4, 0x1
                  li         t3, 0x538e46ab
                  li         a6, 0x1
                  li         s11, 0x0
                  li         a1, 0x67dafc64
                  li         s4, 0x0
                  li         gp, 0x1
                  li         s3, 0x1
                  li         s9, 0x1
                  sub         a2, sp, s3
                  add         a6, sp, t0
                  addi        s11, ra, -1945
                  nop
                  addi        a4, tp, 888
                  add         tp, t0, s3
                  addi        a4, s1, 1068
                  addi        t0, a6, -547
                  add         s7, a0, t5
                  nop
                  lui         zero, 331415
                  lui         s0, 880716
                  nop
                  sub         a2, s3, s6
                  lui         ra, 1010560
                  nop
                  lui         a5, 434806
                  addi        zero, s10, 998 #end riscv_int_numeric_corner_stream_10
                  xor         s4, gp, a6
                  sll         a5, t3, t1
                  andi        s4, a6, -1198
                  andi        a0, s8, -1993
                  nop
                  and         s4, a7, s2
                  slt         a5, a6, s0
                  slt         a1, a0, gp
                  xor         s4, a3, a6
                  sra         zero, t5, a5
                  srl         a1, s4, a3
                  slti        a6, a6, 1480
                  slt         zero, t4, s7
                  srai        t4, a4, 18
                  xor         t2, a0, t3
                  srli        a2, s0, 12
                  ori         sp, s3, 1952
                  addi        s9, a0, -860
                  xori        s0, s8, -2041
                  sltu        zero, t4, s0
                  slli        a0, tp, 7
                  add         s1, gp, a4
                  srl         zero, sp, s4
                  slti        t0, a7, 1652
                  slti        zero, s2, -1005
                  slt         zero, gp, a2
                  add         a3, s9, zero
                  lui         t1, 18974
                  addi        t2, s9, -1
                  slti        s2, tp, 1552
                  xori        s7, s0, 1341
                  and         a7, s4, s9
                  srli        sp, t0, 15
                  ori         sp, ra, 1839
                  and         zero, s3, s1
                  sll         s1, a3, s11
                  sll         s5, t3, t1
                  and         a4, zero, a6
                  slti        s3, gp, -785
                  ori         s5, zero, 723
                  or          s11, s6, zero
                  add         s4, s5, s7
                  sll         t3, t6, t0
                  addi        t0, a0, 26
                  sltu        s11, a4, a3
                  sltu        s0, t4, s0
                  srai        s5, s5, 10
                  nop
                  srli        t2, zero, 24
                  sll         t4, a7, a5
                  sra         s9, a3, ra
                  ori         s5, a7, 233
                  sll         s3, s6, t4
                  lui         sp, 558901
                  srai        s9, s5, 2
                  xor         a6, s10, sp
                  nop
                  nop
                  sub         s0, s6, a1
                  srai        t4, s7, 29
                  add         a3, s5, a2
                  sll         sp, s4, a4
                  addi        t0, t6, -508
                  or          a3, a4, t3
                  andi        s5, t0, 209
                  slti        s6, s3, -1736
                  nop
                  slli        s0, s11, 13
                  and         t2, gp, t2
                  auipc       s1, 207820
                  slt         a7, a7, sp
                  sltu        s5, t2, s0
                  sll         a1, s3, gp
                  sub         s4, tp, a1
                  or          s4, tp, s0
                  srl         s4, s3, a3
                  slli        a2, a1, 23
                  sltu        tp, s1, t5
                  ori         sp, t4, -732
                  andi        s11, t5, 1494
                  slli        s0, zero, 12
                  nop
                  xori        a0, s11, -1458
                  srai        zero, a2, 23
                  srli        a3, t2, 16
                  and         a3, s11, s11
                  lui         zero, 146313
                  add         s0, a2, gp
                  ori         t0, s6, -1068
                  add         t3, a5, s0
                  sra         tp, s3, zero
                  addi        a5, a0, 1136
                  slt         s7, a7, a4
                  ori         s5, t6, 1409
                  slti        t2, t3, 129
                  lui         a1, 1005134
                  andi        a3, tp, 366
                  xor         t0, a0, a3
                  or          s3, t5, a4
                  or          a6, t4, a6
                  xor         a2, s4, a5
                  sll         s11, s10, s8
                  xori        t3, a7, 2046
                  sltu        tp, s9, a7
                  slti        s8, gp, 1994
                  auipc       s5, 593045
                  auipc       s0, 126811
                  sltiu       a3, t5, 1114
                  slli        a0, a5, 25
                  lui         zero, 502235
                  srai        sp, s3, 7
                  srl         t1, a6, s11
                  slt         s9, t4, s10
                  or          sp, s1, a7
                  sub         a4, a7, sp
                  slli        t3, a4, 16
                  sll         ra, a0, t4
                  andi        s0, s3, 1714
                  sub         s0, a1, a5
                  or          a6, tp, a7
                  lui         a4, 799400
                  slti        t1, s8, -1921
                  sltiu       zero, a0, 111
                  lui         s4, 455607
                  sltu        s6, s4, ra
                  sra         zero, a1, a7
                  sltiu       s8, ra, -1889
                  add         sp, s3, zero
                  auipc       t2, 387178
                  and         t2, t4, s2
                  slti        s1, s7, -13
                  srli        sp, s8, 22
                  slti        t0, t4, 993
                  lui         t0, 349755
                  srai        t2, s11, 24
                  sltu        s8, s11, s6
                  sll         s4, ra, s9
                  srli        s5, s10, 5
                  auipc       t4, 578341
                  andi        t4, t0, -121
                  add         s1, t5, s11
                  andi        s6, t4, 807
                  sra         tp, t3, s7
                  xor         s3, s10, zero
                  xor         t4, s7, a7
                  slt         t1, a7, a0
                  nop
                  xor         a6, s8, a4
                  srl         tp, a5, zero
                  sub         s2, s3, s0
                  auipc       a4, 677791
                  addi        t3, gp, 1296
                  slt         a1, a4, a5
                  slli        s1, s10, 16
                  srli        zero, t0, 13
                  ori         a4, s0, -88
                  and         s2, a7, s0
                  and         tp, sp, s10
                  srli        t1, a6, 3
                  and         s11, gp, s2
                  srl         a5, a2, s8
                  slli        s1, a4, 25
                  slt         s3, s2, a6
                  xori        s6, s7, -233
                  nop
                  sra         s7, a4, t3
                  nop
                  slti        t0, a4, -1221
                  srl         s5, s0, t2
                  srai        s2, s5, 1
                  sltu        tp, s0, t1
                  add         a1, a7, t0
                  andi        ra, s9, 75
                  andi        a4, s7, -460
                  andi        s4, a6, -1871
                  or          sp, t1, a5
                  lui         a1, 927872
                  xori        tp, gp, 1876
                  sll         s7, s5, t2
                  sltiu       s9, a3, 942
                  srai        s4, s1, 18
                  slti        a0, s1, -1659
                  sra         s11, s4, s5
                  sub         t0, a4, s7
                  addi        a5, s7, 1421
                  xori        tp, ra, -1525
                  andi        sp, a5, -1729
                  sltu        s7, a0, sp
                  srli        a5, s2, 7
                  sltu        a6, a3, a2
                  xori        s6, a3, 507
                  sub         a5, a7, a3
                  addi        s4, s11, -1337
                  sll         zero, ra, gp
                  xori        s3, a6, 1516
                  auipc       zero, 167803
                  and         s6, a0, s7
                  lui         s2, 658411
                  srl         zero, a5, s0
                  sll         s5, a0, s5
                  sll         a1, s10, s5
                  addi        sp, t0, 789
                  xor         a3, sp, t5
                  sltu        t0, a5, s10
                  la x31, test_done
                  jalr x0, x31, 0
test_done:        
                  li gp, 1
                  ecall
write_tohost:     
                  sw gp, tohost, t5

_exit:            
                  j write_tohost

instr_end:        
                  nop

.section .data
.align 6; .global tohost; tohost: .dword 0;
.align 6; .global fromhost; fromhost: .dword 0;
.section .user_stack,"aw",@progbits;
.align 2
user_stack_start:
.rept 4999
.4byte 0x0
.endr
user_stack_end:
.4byte 0x0
.align 2
kernel_instr_start:
.text
.align 2
mtvec_handler:    
                  csrrw x26, 0x340, x26
                  add x26, x30, zero
                  1: addi x26, x26, -124
                  sw x1, 4(x26)
                  sw x2, 8(x26)
                  sw x3, 12(x26)
                  sw x4, 16(x26)
                  sw x5, 20(x26)
                  sw x6, 24(x26)
                  sw x7, 28(x26)
                  sw x8, 32(x26)
                  sw x9, 36(x26)
                  sw x10, 40(x26)
                  sw x11, 44(x26)
                  sw x12, 48(x26)
                  sw x13, 52(x26)
                  sw x14, 56(x26)
                  sw x15, 60(x26)
                  sw x16, 64(x26)
                  sw x17, 68(x26)
                  sw x18, 72(x26)
                  sw x19, 76(x26)
                  sw x20, 80(x26)
                  sw x21, 84(x26)
                  sw x22, 88(x26)
                  sw x23, 92(x26)
                  sw x24, 96(x26)
                  sw x25, 100(x26)
                  sw x26, 104(x26)
                  sw x27, 108(x26)
                  sw x28, 112(x26)
                  sw x29, 116(x26)
                  sw x30, 120(x26)
                  sw x31, 124(x26)
                  csrr x27, 0x300 # MSTATUS
                  csrr x27, 0x342 # MCAUSE
                  srli x27, x27, 31
                  bne x27, x0, mmode_intr_handler

mmode_exception_handler:
                  csrr x27, 0x341 # MEPC
                  csrr x27, 0x342 # MCAUSE
                  li x25, 0xb # ECALL_MMODE
                  beq x27, x25, ecall_handler
                  li x25, 0x2 # ILLEGAL_INSTRUCTION
                  beq x27, x25, illegal_instr_handler
                  csrr x25, 0x343 # MTVAL
                  1: la x31, test_done
                  jalr x1, x31, 0

ecall_handler:    
                  la x27, _start
                  sw x0, 0(x27)
                  sw x1, 4(x27)
                  sw x2, 8(x27)
                  sw x3, 12(x27)
                  sw x4, 16(x27)
                  sw x5, 20(x27)
                  sw x6, 24(x27)
                  sw x7, 28(x27)
                  sw x8, 32(x27)
                  sw x9, 36(x27)
                  sw x10, 40(x27)
                  sw x11, 44(x27)
                  sw x12, 48(x27)
                  sw x13, 52(x27)
                  sw x14, 56(x27)
                  sw x15, 60(x27)
                  sw x16, 64(x27)
                  sw x17, 68(x27)
                  sw x18, 72(x27)
                  sw x19, 76(x27)
                  sw x20, 80(x27)
                  sw x21, 84(x27)
                  sw x22, 88(x27)
                  sw x23, 92(x27)
                  sw x24, 96(x27)
                  sw x25, 100(x27)
                  sw x26, 104(x27)
                  sw x27, 108(x27)
                  sw x28, 112(x27)
                  sw x29, 116(x27)
                  sw x30, 120(x27)
                  sw x31, 124(x27)
                  la x31, write_tohost
                  jalr x0, x31, 0

illegal_instr_handler:
                  csrr  x27, 0x341
                  addi  x27, x27, 4
                  csrw  0x341, x27
                  lw x1, 4(x26)
                  lw x2, 8(x26)
                  lw x3, 12(x26)
                  lw x4, 16(x26)
                  lw x5, 20(x26)
                  lw x6, 24(x26)
                  lw x7, 28(x26)
                  lw x8, 32(x26)
                  lw x9, 36(x26)
                  lw x10, 40(x26)
                  lw x11, 44(x26)
                  lw x12, 48(x26)
                  lw x13, 52(x26)
                  lw x14, 56(x26)
                  lw x15, 60(x26)
                  lw x16, 64(x26)
                  lw x17, 68(x26)
                  lw x18, 72(x26)
                  lw x19, 76(x26)
                  lw x20, 80(x26)
                  lw x21, 84(x26)
                  lw x22, 88(x26)
                  lw x23, 92(x26)
                  lw x24, 96(x26)
                  lw x25, 100(x26)
                  lw x26, 104(x26)
                  lw x27, 108(x26)
                  lw x28, 112(x26)
                  lw x29, 116(x26)
                  lw x30, 120(x26)
                  lw x31, 124(x26)
                  addi x26, x26, 124
                  add x30, x26, zero
                  csrrw x26, 0x340, x26
                  mret

pt_fault_handler: 

.align 2
mmode_intr_handler:
                  csrr  x27, 0x300 # MSTATUS;
                  csrr  x27, 0x304 # MIE;
                  csrr  x27, 0x344 # MIP;
                  csrrc x27, 0x344, x27 # MIP;
                  lw x1, 4(x26)
                  lw x2, 8(x26)
                  lw x3, 12(x26)
                  lw x4, 16(x26)
                  lw x5, 20(x26)
                  lw x6, 24(x26)
                  lw x7, 28(x26)
                  lw x8, 32(x26)
                  lw x9, 36(x26)
                  lw x10, 40(x26)
                  lw x11, 44(x26)
                  lw x12, 48(x26)
                  lw x13, 52(x26)
                  lw x14, 56(x26)
                  lw x15, 60(x26)
                  lw x16, 64(x26)
                  lw x17, 68(x26)
                  lw x18, 72(x26)
                  lw x19, 76(x26)
                  lw x20, 80(x26)
                  lw x21, 84(x26)
                  lw x22, 88(x26)
                  lw x23, 92(x26)
                  lw x24, 96(x26)
                  lw x25, 100(x26)
                  lw x26, 104(x26)
                  lw x27, 108(x26)
                  lw x28, 112(x26)
                  lw x29, 116(x26)
                  lw x30, 120(x26)
                  lw x31, 124(x26)
                  addi x26, x26, 124
                  add x30, x26, zero
                  csrrw x26, 0x340, x26
                  mret;

kernel_instr_end: nop
.align 2
kernel_data_start:
.section .kernel_stack,"aw",@progbits;
.align 2
kernel_stack_start:
.rept 4999
.4byte 0x0
.endr
kernel_stack_end:
.4byte 0x0
