.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x15, h0_start
jalr x0, x15, 0
h0_start:
                  li x13, 0x40000100
                  csrw 0x301, x13
kernel_sp:        
                  la x19, kernel_stack_end

trap_vec_init:    
                  la x13, mtvec_handler
                  ori x13, x13, 0
                  csrw 0x305, x13 # MTVEC

mepc_setup:       
                  la x13, init
                  csrw 0x341, x13

init_machine_mode:
                  li x13, 0x1800
                  csrw 0x300, x13 # MSTATUS
                  li x13, 0x0
                  csrw 0x304, x13 # MIE
                  mret
init:             
                  li x0, 0x0
                  li x1, 0x80000000
                  li x2, 0x80000000
                  li x3, 0xfd0af680
                  li x4, 0x0
                  li x5, 0xc
                  li x6, 0x80000000
                  li x7, 0x0
                  li x8, 0x80000000
                  li x9, 0x0
                  li x10, 0xe
                  li x12, 0x80000000
                  li x13, 0xd
                  li x14, 0xaf843255
                  li x15, 0xfef86612
                  li x16, 0x766a04c8
                  li x17, 0xd
                  li x18, 0xb831f3
                  li x20, 0x80000000
                  li x21, 0x8cbf26f0
                  li x22, 0x1b7f8f9c
                  li x23, 0x80000000
                  li x24, 0xfb7546d1
                  li x25, 0x0
                  li x26, 0x0
                  li x27, 0x487741db
                  li x28, 0x80000000
                  li x29, 0xadb4ebdd
                  li x30, 0x0
                  li x31, 0xf14538a6
                  la x11, user_stack_end
main:             li         t6, 0x1 #start riscv_int_numeric_corner_stream_1
                  li         t5, 0x33de63
                  li         s7, 0x6480e1f7
                  li         t4, 0x4d7f34e2
                  li         t2, 0x0
                  li         t3, 0x0
                  li         s11, 0x1
                  li         a4, 0x0
                  li         gp, 0x7aae7c54
                  li         s6, 0x2a440b59
                  nop
                  sub         s0, s9, s5
                  lui         tp, 461773
                  lui         zero, 78624
                  lui         s11, 157143
                  lui         zero, 767756
                  nop
                  lui         t3, 20647
                  sub         tp, s5, s1
                  addi        ra, a4, 554
                  sub         s7, t0, s8
                  sub         s7, sp, a0
                  sub         zero, s5, s7
                  add         s8, s6, zero
                  nop
                  addi        t6, ra, -1804 #end riscv_int_numeric_corner_stream_1
                  andi        a3, sp, -84
                  sll         t3, s10, t1
                  srai        s2, s5, 1
                  sltu        zero, a3, s11
                  srli        t5, t3, 0
                  sltiu       s4, s10, -417
                  slli        s8, a4, 8
                  and         s10, a1, zero
                  slti        tp, s10, 308
                  and         s4, a7, a1
                  slli        a3, t0, 15
                  ori         s4, gp, 1300
                  nop
                  slt         s1, s5, s0
                  sll         a6, s0, a3
                  slli        a7, ra, 16
                  add         a6, t0, t5
                  slt         s0, a6, s3
                  and         t2, t4, t3
                  sra         s7, sp, t4
                  and         s1, s5, s7
                  andi        s6, s2, -238
                  xor         zero, s11, t0
                  slti        t1, t5, -188
                  srli        s1, s9, 6
                  slt         ra, ra, s11
                  addi        s8, t6, 739
                  sub         t0, sp, s11
                  lui         sp, 729548
                  nop
                  srli        s9, s7, 28
                  andi        a7, s1, 531
                  slti        t2, a2, 61
                  addi        s7, s7, -2041
                  xori        a4, s7, 319
                  addi        t0, s5, 1341
                  slli        s8, s6, 16
                  sll         s11, s9, s11
                  auipc       a7, 446995
                  add         a3, s0, a2
                  add         a6, s1, s6
                  sll         t6, a3, a1
                  and         s4, sp, a1
                  slti        a6, s7, -1240
                  auipc       sp, 1021138
                  slt         zero, s8, ra
                  sub         a3, s2, a7
                  lui         tp, 241006
                  xor         a0, a0, s4
                  add         a2, t6, a5
                  sll         s6, s9, a7
                  add         sp, t1, ra
                  and         s4, t2, gp
                  lui         gp, 987829
                  and         t6, t3, s2
                  slt         a4, t3, t1
                  or          t3, s4, s1
                  or          t5, ra, s10
                  or          tp, tp, a7
                  slti        t5, t1, -42
                  xor         t0, a6, s6
                  slt         t3, a2, zero
                  slt         t5, a6, s6
                  auipc       t5, 832161
                  andi        zero, s8, -682
                  ori         zero, s3, 1269
                  addi        zero, ra, -1664
                  lui         zero, 681856
                  auipc       zero, 542751
                  andi        sp, s8, 1456
                  sra         a4, a1, s4
                  addi        s10, t5, 940
                  srl         s2, gp, zero
                  xor         gp, t3, s7
                  srl         sp, a2, a4
                  or          s1, s5, s4
                  slt         t4, t2, s10
                  sltu        t1, t4, ra
                  slti        s1, s7, 227
                  andi        s4, gp, 1754
                  lui         s0, 917904
                  slt         sp, zero, a2
                  slt         zero, sp, s11
                  add         t1, s8, zero
                  and         gp, tp, t5
                  slti        s8, t5, 2028
                  nop
                  sltu        a2, t3, s6
                  li         t6, 0x1 #start riscv_int_numeric_corner_stream_0
                  li         t5, 0x0
                  li         a2, 0x0
                  li         s6, 0x0
                  li         s2, 0x0
                  li         s7, 0x0
                  li         t4, 0x730ae39f
                  li         a4, 0x7fd71f13
                  li         a0, 0x0
                  li         s10, 0x6ab55418
                  addi        t6, s5, 333
                  sub         t1, t2, zero
                  sub         t1, gp, t5
                  sub         zero, a5, s9
                  lui         zero, 679546
                  addi        s9, s6, 267
                  nop
                  sub         s8, s5, a4
                  add         s0, a1, t3
                  add         ra, a1, zero
                  addi        a6, a2, 1949
                  nop
                  sub         zero, s2, sp
                  lui         t4, 299676
                  nop
                  lui         zero, 241365
                  nop
                  nop
                  sub         a0, s2, s8
                  lui         a4, 349450
                  nop #end riscv_int_numeric_corner_stream_0
                  sra         gp, s10, a0
                  auipc       s2, 784814
                  srl         ra, t6, a5
                  nop
                  nop
                  sub         s5, a5, gp
                  sll         t2, t1, t3
                  and         a0, s5, s6
                  andi        t1, a6, 1595
                  sll         s8, s8, t6
                  srai        zero, sp, 7
                  lui         s10, 991093
                  sra         zero, s5, s7
                  sltu        t2, a2, s6
                  slti        s0, t3, 1801
                  sltu        s7, a5, s11
                  sra         t1, t2, a3
                  slti        a2, t3, 115
                  and         t6, s6, s0
                  slt         s1, a3, s6
                  auipc       a4, 500343
                  ori         a2, a2, 1479
                  andi        s5, tp, -2030
                  lui         zero, 857595
                  addi        a6, a5, -325
                  xori        tp, t1, -330
                  xor         tp, sp, gp
                  sltiu       zero, zero, -1221
                  sub         t4, sp, s0
                  xori        tp, zero, -880
                  sltu        a0, a0, t6
                  sll         gp, a7, tp
                  sra         a0, t5, s7
                  or          gp, s11, t4
                  addi        ra, s7, -1156
                  and         zero, s11, a2
                  sltu        tp, s7, t3
                  sltu        a6, s0, a0
                  slti        s1, s11, 414
                  sll         zero, zero, t3
                  srai        s6, s5, 10
                  or          s7, s10, a2
                  srai        a4, a7, 28
                  xor         ra, a2, a1
                  slli        s11, t3, 19
                  sra         s1, tp, s2
                  sll         a6, zero, t1
                  addi        s0, t0, 1907
                  slli        a3, ra, 18
                  slt         ra, s2, s5
                  slti        a4, s10, 856
                  and         a7, s9, t0
                  auipc       t6, 789445
                  slt         t2, ra, t3
                  srai        s0, a1, 7
                  lui         a6, 1029515
                  add         a3, s3, zero
                  and         s2, t0, a3
                  slt         t1, a5, a2
                  sll         t5, a6, a1
                  addi        zero, zero, -185
                  andi        s2, a4, 1362
                  sra         zero, s11, zero
                  and         sp, sp, a6
                  slli        a2, a7, 0
                  srli        a4, zero, 29
                  xori        s0, gp, 1229
                  srli        ra, s7, 4
                  ori         t4, s9, -1357
                  sll         a7, t1, a4
                  slt         s10, a2, s11
                  lui         s0, 289592
                  srl         gp, a7, a1
                  and         zero, s5, t3
                  sltiu       s8, t3, 848
                  and         a4, s9, s3
                  ori         a0, zero, 1783
                  slli        t5, s7, 15
                  slli        a6, s11, 22
                  xori        zero, s1, -1868
                  slli        s8, a2, 31
                  srli        gp, s1, 4
                  sltiu       t2, t1, 258
                  add         zero, s3, s11
                  add         s1, a1, s9
                  andi        gp, gp, -668
                  srai        s1, a6, 24
                  lui         s5, 37110
                  sltiu       t2, a4, 1757
                  slli        s4, sp, 8
                  auipc       sp, 967078
                  addi        s1, zero, -1704
                  slli        s0, ra, 9
                  or          t2, a2, t0
                  srai        a4, s6, 31
                  xori        a0, s4, -387
                  srai        zero, s5, 15
                  srli        t4, t0, 10
                  xor         s2, s11, zero
                  slti        t6, sp, 441
                  srli        s1, a3, 11
                  addi        t0, t2, -1946
                  andi        t4, ra, -426
                  sltiu       t2, s1, 1973
                  ori         t1, a2, -516
                  slt         a2, a1, t1
                  ori         t5, s2, -1134
                  ori         s0, ra, -2032
                  or          a4, s3, a6
                  lui         t0, 198238
                  andi        gp, gp, -1904
                  sub         a7, a4, a0
                  srli        zero, s8, 19
                  slli        s5, t1, 10
                  xor         s2, gp, t0
                  or          t0, s10, t3
                  sll         a4, s7, a2
                  slt         t2, a2, a6
                  srai        a7, s10, 26
                  ori         s1, s5, 1139
                  sra         a4, t0, s10
                  srli        t6, a1, 29
                  nop
                  or          s7, t0, a7
                  andi        a3, s9, 254
                  srli        a6, a6, 19
                  lui         s8, 14524
                  sra         s11, a4, s2
                  srai        t1, t1, 25
                  add         s11, a3, s9
                  addi        a0, t2, 69
                  ori         s11, zero, 775
                  srl         t3, t0, gp
                  sltu        a0, tp, a1
                  lui         s9, 13669
                  ori         s7, t5, 913
                  and         s11, s10, t5
                  sltu        t4, s8, t1
                  xori        s6, s9, -1225
                  sra         s6, sp, a6
                  slt         s7, a1, tp
                  srli        a2, t6, 20
                  and         gp, t4, a3
                  add         t1, t1, a5
                  andi        s9, t0, 1064
                  srl         s0, s1, s0
                  nop
                  or          zero, s4, a3
                  sltiu       a4, a6, 1747
                  sra         s9, s0, a1
                  or          zero, t0, s9
                  auipc       s2, 450893
                  ori         a0, t4, 1027
                  lui         t3, 942280
                  addi        s9, s11, 642
                  xori        a2, s1, 675
                  xor         s7, t3, s0
                  add         s8, a0, a5
                  andi        zero, s7, -1144
                  and         s10, sp, a5
                  sltu        t0, a6, s10
                  addi        t4, gp, -1484
                  sll         t3, s1, tp
                  srai        s10, t2, 13
                  or          zero, s3, s6
                  slt         zero, s3, a0
                  sll         zero, zero, tp
                  sra         a0, t2, s0
                  and         s0, a4, t2
                  sra         s4, gp, a7
                  nop
                  sltu        s2, s8, a6
                  lui         t5, 195826
                  or          zero, s6, a2
                  xor         s11, s9, a7
                  ori         t4, s6, 426
                  sra         s8, s10, s7
                  srli        tp, t4, 28
                  sub         s1, t2, ra
                  auipc       s5, 285330
                  slti        s6, sp, 218
                  srl         t3, a1, t0
                  or          zero, a3, gp
                  slti        a3, t2, 1912
                  andi        ra, s5, -984
                  srai        zero, s1, 27
                  srli        a4, s10, 1
                  xor         s6, s8, t1
                  sra         s4, s4, s0
                  srli        t0, ra, 3
                  addi        s2, s1, -112
                  sra         s6, a0, t3
                  slli        sp, a4, 20
                  sra         a3, tp, a3
                  sltiu       tp, t3, -159
                  xor         ra, t3, t3
                  srai        a0, s8, 16
                  ori         t0, s4, 1230
                  lui         a6, 641468
                  or          s9, t5, a1
                  srai        s0, a2, 15
                  sll         s1, s11, a0
                  add         s4, a7, sp
                  add         zero, s7, t6
                  sltu        s9, ra, tp
                  and         s4, a5, sp
                  ori         s5, s3, -495
                  or          s11, t0, s3
                  ori         s0, a2, 969
                  sltiu       zero, t0, -887
                  ori         s7, s9, -266
                  sltu        a7, t6, sp
                  sub         t5, ra, s0
                  lui         gp, 673427
                  sll         s4, a2, zero
                  add         s2, s3, s0
                  andi        t3, s11, 1587
                  xori        s8, a3, -1292
                  add         s9, tp, s10
                  srli        zero, a5, 3
                  xori        s1, a4, -332
                  srl         t6, s5, s3
                  sra         a3, s4, t6
                  ori         a4, t4, 622
                  srl         s5, sp, t1
                  xori        a2, a0, 846
                  xor         ra, a2, s5
                  sra         t4, t3, s11
                  sra         s10, t2, s5
                  srl         zero, t2, ra
                  ori         s2, a6, -288
                  and         s8, gp, s9
                  xor         a3, s10, tp
                  auipc       t6, 1002091
                  sltiu       s7, t5, 649
                  sll         a3, ra, a2
                  xor         s6, s4, t4
                  xor         gp, s9, s2
                  slti        a4, s10, -1087
                  nop
                  or          a6, s5, a4
                  ori         s10, a3, -1579
                  addi        s4, s8, 1307
                  lui         a3, 100985
                  sltiu       t2, ra, 1669
                  addi        t4, sp, 1330
                  xor         a3, a0, s2
                  sra         t6, a2, s8
                  lui         t5, 443911
                  srli        zero, s9, 31
                  sra         zero, t3, s11
                  add         t2, t2, ra
                  srai        t3, s4, 9
                  slt         s8, s1, a4
                  srl         gp, sp, s0
                  slti        s6, s5, 1570
                  slt         a3, s1, s9
                  addi        s10, t3, 353
                  and         s7, a3, s6
                  add         a2, s1, a7
                  srai        s6, zero, 25
                  nop
                  srai        t3, s10, 14
                  andi        zero, t5, 1187
                  sra         t0, t2, s6
                  auipc       s2, 568016
                  lui         zero, 978918
                  or          t1, s9, a4
                  add         s7, s8, s2
                  sltu        a2, t4, s10
                  slt         ra, a0, s3
                  xor         a7, s2, a2
                  andi        s5, s9, 1404
                  xor         a4, a4, a7
                  nop
                  xor         a4, s5, gp
                  or          t3, gp, a1
                  srai        zero, s6, 15
                  auipc       s11, 1038313
                  slli        s11, s5, 0
                  ori         a6, a0, -926
                  andi        s7, s8, -289
                  sll         ra, s3, a7
                  addi        ra, s10, 1984
                  xori        a6, tp, -1573
                  addi        s1, s1, -1916
                  sll         t1, ra, a0
                  srli        s4, t1, 15
                  addi        s5, sp, 227
                  and         ra, gp, t0
                  auipc       tp, 533775
                  srli        sp, s8, 10
                  slt         zero, zero, a6
                  sub         s7, s3, zero
                  nop
                  xori        t5, t0, -1942
                  slt         t1, a1, ra
                  sltiu       s5, t0, -953
                  slti        t5, t5, 116
                  srli        t2, s1, 10
                  sub         s10, s6, t3
                  or          t5, a5, t5
                  slli        s2, s11, 19
                  sltiu       zero, s2, -241
                  andi        s7, s6, 1430
                  srai        t1, s6, 2
                  srai        s1, t1, 30
                  add         t5, t3, a5
                  xori        s1, s8, -679
                  add         s5, s4, s1
                  ori         s1, a7, 481
                  sra         t4, s0, s11
                  add         s4, t0, a5
                  or          zero, ra, s7
                  srli        t1, s1, 14
                  slti        s2, t3, 660
                  sll         s11, t3, sp
                  srli        a2, s3, 6
                  srai        s10, tp, 2
                  lui         sp, 750708
                  sltiu       t4, a5, 282
                  and         t0, t5, s3
                  sll         gp, s11, ra
                  slli        s0, a2, 29
                  srl         t5, t6, a1
                  addi        zero, a5, -1232
                  or          sp, gp, a5
                  slt         s11, a5, s7
                  srl         s8, t3, s2
                  srli        s2, s10, 29
                  srai        a6, t1, 18
                  sll         t4, ra, t5
                  xor         s2, ra, tp
                  sra         t1, a4, a2
                  slt         s4, s3, s6
                  auipc       t5, 521464
                  auipc       a2, 376098
                  sltu        ra, t3, a2
                  xori        t3, s9, 1348
                  xori        t4, zero, 1231
                  add         zero, t0, t0
                  auipc       a7, 342594
                  auipc       zero, 408155
                  sra         zero, t5, s3
                  slli        t6, sp, 31
                  andi        s6, t0, 1616
                  srli        t5, a3, 14
                  sltu        t2, s1, t0
                  andi        t3, s10, 1563
                  xori        s8, s2, 1422
                  xori        gp, t2, -818
                  addi        a0, s6, 885
                  addi        s5, t5, 729
                  andi        s6, s10, 927
                  slti        t4, t1, -539
                  slti        t1, s1, -1286
                  sub         a3, s2, a5
                  srl         t5, t0, s6
                  nop
                  slt         tp, a6, a6
                  srli        ra, a6, 14
                  sltu        s9, t6, t4
                  lui         zero, 193025
                  sra         gp, zero, t5
                  slli        s7, t1, 20
                  andi        sp, t4, -813
                  lui         t4, 70441
                  andi        t5, s10, 1029
                  srai        tp, a5, 11
                  sra         s6, a1, s1
                  add         s7, s8, a6
                  and         s4, s8, s1
                  srai        sp, s3, 25
                  slli        zero, s2, 27
                  srli        a4, t1, 16
                  ori         s11, gp, 654
                  andi        s1, t0, 945
                  sub         t3, s9, s0
                  slli        s5, a6, 5
                  xor         s8, tp, t0
                  nop
                  add         t6, s0, a3
                  slti        t1, s4, 16
                  sltu        a6, t6, s8
                  sltu        s4, s1, s2
                  or          a4, s10, gp
                  sll         s5, s8, gp
                  and         t5, a2, tp
                  slt         s0, s0, t4
                  or          s2, a6, a0
                  or          s10, s11, s7
                  auipc       a3, 804806
                  auipc       tp, 166127
                  sll         tp, s3, tp
                  lui         a4, 803148
                  ori         a0, s7, 1698
                  sub         t5, s8, t5
                  slt         s4, t5, a4
                  sll         t5, s3, a1
                  nop
                  slt         sp, s11, tp
                  ori         s1, s9, -1963
                  sltu        zero, s1, s6
                  xor         s1, s11, s1
                  addi        t6, s4, 890
                  xor         a2, a2, s7
                  auipc       a6, 850153
                  sll         zero, s10, gp
                  srli        s1, sp, 6
                  xor         gp, a3, a6
                  slt         a0, s5, s5
                  slti        s8, a7, -1718
                  and         a2, s7, t0
                  and         s1, s8, t4
                  srai        gp, s1, 14
                  add         s1, ra, s6
                  srli        s5, ra, 20
                  addi        s4, a0, -782
                  la x15, test_done
                  jalr x0, x15, 0
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
                  csrrw x11, 0x340, x11
                  add x11, x19, zero
                  1: addi x11, x11, -124
                  sw x1, 4(x11)
                  sw x2, 8(x11)
                  sw x3, 12(x11)
                  sw x4, 16(x11)
                  sw x5, 20(x11)
                  sw x6, 24(x11)
                  sw x7, 28(x11)
                  sw x8, 32(x11)
                  sw x9, 36(x11)
                  sw x10, 40(x11)
                  sw x11, 44(x11)
                  sw x12, 48(x11)
                  sw x13, 52(x11)
                  sw x14, 56(x11)
                  sw x15, 60(x11)
                  sw x16, 64(x11)
                  sw x17, 68(x11)
                  sw x18, 72(x11)
                  sw x19, 76(x11)
                  sw x20, 80(x11)
                  sw x21, 84(x11)
                  sw x22, 88(x11)
                  sw x23, 92(x11)
                  sw x24, 96(x11)
                  sw x25, 100(x11)
                  sw x26, 104(x11)
                  sw x27, 108(x11)
                  sw x28, 112(x11)
                  sw x29, 116(x11)
                  sw x30, 120(x11)
                  sw x31, 124(x11)
                  csrr x13, 0x300 # MSTATUS
                  csrr x13, 0x342 # MCAUSE
                  srli x13, x13, 31
                  bne x13, x0, mmode_intr_handler

mmode_exception_handler:
                  csrr x13, 0x341 # MEPC
                  csrr x13, 0x342 # MCAUSE
                  li x24, 0xb # ECALL_MMODE
                  beq x13, x24, ecall_handler
                  li x24, 0x2 # ILLEGAL_INSTRUCTION
                  beq x13, x24, illegal_instr_handler
                  csrr x24, 0x343 # MTVAL
                  1: la x15, test_done
                  jalr x1, x15, 0

ecall_handler:    
                  la x13, _start
                  sw x0, 0(x13)
                  sw x1, 4(x13)
                  sw x2, 8(x13)
                  sw x3, 12(x13)
                  sw x4, 16(x13)
                  sw x5, 20(x13)
                  sw x6, 24(x13)
                  sw x7, 28(x13)
                  sw x8, 32(x13)
                  sw x9, 36(x13)
                  sw x10, 40(x13)
                  sw x11, 44(x13)
                  sw x12, 48(x13)
                  sw x13, 52(x13)
                  sw x14, 56(x13)
                  sw x15, 60(x13)
                  sw x16, 64(x13)
                  sw x17, 68(x13)
                  sw x18, 72(x13)
                  sw x19, 76(x13)
                  sw x20, 80(x13)
                  sw x21, 84(x13)
                  sw x22, 88(x13)
                  sw x23, 92(x13)
                  sw x24, 96(x13)
                  sw x25, 100(x13)
                  sw x26, 104(x13)
                  sw x27, 108(x13)
                  sw x28, 112(x13)
                  sw x29, 116(x13)
                  sw x30, 120(x13)
                  sw x31, 124(x13)
                  la x15, write_tohost
                  jalr x0, x15, 0

illegal_instr_handler:
                  csrr  x13, 0x341
                  addi  x13, x13, 4
                  csrw  0x341, x13
                  lw x1, 4(x11)
                  lw x2, 8(x11)
                  lw x3, 12(x11)
                  lw x4, 16(x11)
                  lw x5, 20(x11)
                  lw x6, 24(x11)
                  lw x7, 28(x11)
                  lw x8, 32(x11)
                  lw x9, 36(x11)
                  lw x10, 40(x11)
                  lw x11, 44(x11)
                  lw x12, 48(x11)
                  lw x13, 52(x11)
                  lw x14, 56(x11)
                  lw x15, 60(x11)
                  lw x16, 64(x11)
                  lw x17, 68(x11)
                  lw x18, 72(x11)
                  lw x19, 76(x11)
                  lw x20, 80(x11)
                  lw x21, 84(x11)
                  lw x22, 88(x11)
                  lw x23, 92(x11)
                  lw x24, 96(x11)
                  lw x25, 100(x11)
                  lw x26, 104(x11)
                  lw x27, 108(x11)
                  lw x28, 112(x11)
                  lw x29, 116(x11)
                  lw x30, 120(x11)
                  lw x31, 124(x11)
                  addi x11, x11, 124
                  add x19, x11, zero
                  csrrw x11, 0x340, x11
                  mret

pt_fault_handler: 

.align 2
mmode_intr_handler:
                  csrr  x13, 0x300 # MSTATUS;
                  csrr  x13, 0x304 # MIE;
                  csrr  x13, 0x344 # MIP;
                  csrrc x13, 0x344, x13 # MIP;
                  lw x1, 4(x11)
                  lw x2, 8(x11)
                  lw x3, 12(x11)
                  lw x4, 16(x11)
                  lw x5, 20(x11)
                  lw x6, 24(x11)
                  lw x7, 28(x11)
                  lw x8, 32(x11)
                  lw x9, 36(x11)
                  lw x10, 40(x11)
                  lw x11, 44(x11)
                  lw x12, 48(x11)
                  lw x13, 52(x11)
                  lw x14, 56(x11)
                  lw x15, 60(x11)
                  lw x16, 64(x11)
                  lw x17, 68(x11)
                  lw x18, 72(x11)
                  lw x19, 76(x11)
                  lw x20, 80(x11)
                  lw x21, 84(x11)
                  lw x22, 88(x11)
                  lw x23, 92(x11)
                  lw x24, 96(x11)
                  lw x25, 100(x11)
                  lw x26, 104(x11)
                  lw x27, 108(x11)
                  lw x28, 112(x11)
                  lw x29, 116(x11)
                  lw x30, 120(x11)
                  lw x31, 124(x11)
                  addi x11, x11, 124
                  add x19, x11, zero
                  csrrw x11, 0x340, x11
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
