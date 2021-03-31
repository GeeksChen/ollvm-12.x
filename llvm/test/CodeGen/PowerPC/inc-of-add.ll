; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=ppc32-unknown-unknown | FileCheck %s --check-prefixes=ALL,PPC32
; RUN: llc < %s -mtriple=powerpc64-unknown-unknown | FileCheck %s --check-prefixes=ALL,PPC64,PPC64BE
; RUN: llc < %s -mtriple=powerpc64-ibm-aix-xcoff | FileCheck %s --check-prefixes=ALL,PPC64,PPC64BE
; RUN: llc < %s -mtriple=powerpc64le-unknown-unknown | FileCheck %s --check-prefixes=ALL,PPC64,PPC64LE

; These two forms are equivalent:
;   sub %y, (xor %x, -1)
;   add (add %x, 1), %y
; Some targets may prefer one to the other.

define i8 @scalar_i8(i8 %x, i8 %y) nounwind {
; ALL-LABEL: scalar_i8:
; ALL:       # %bb.0:
; ALL-NEXT:    add 3, 3, 4
; ALL-NEXT:    addi 3, 3, 1
; ALL-NEXT:    blr
  %t0 = add i8 %x, 1
  %t1 = add i8 %y, %t0
  ret i8 %t1
}

define i16 @scalar_i16(i16 %x, i16 %y) nounwind {
; ALL-LABEL: scalar_i16:
; ALL:       # %bb.0:
; ALL-NEXT:    add 3, 3, 4
; ALL-NEXT:    addi 3, 3, 1
; ALL-NEXT:    blr
  %t0 = add i16 %x, 1
  %t1 = add i16 %y, %t0
  ret i16 %t1
}

define i32 @scalar_i32(i32 %x, i32 %y) nounwind {
; ALL-LABEL: scalar_i32:
; ALL:       # %bb.0:
; ALL-NEXT:    add 3, 3, 4
; ALL-NEXT:    addi 3, 3, 1
; ALL-NEXT:    blr
  %t0 = add i32 %x, 1
  %t1 = add i32 %y, %t0
  ret i32 %t1
}

define i64 @scalar_i64(i64 %x, i64 %y) nounwind {
; PPC32-LABEL: scalar_i64:
; PPC32:       # %bb.0:
; PPC32-NEXT:    addc 4, 4, 6
; PPC32-NEXT:    adde 3, 3, 5
; PPC32-NEXT:    addic 4, 4, 1
; PPC32-NEXT:    addze 3, 3
; PPC32-NEXT:    blr
;
; PPC64-LABEL: scalar_i64:
; PPC64:       # %bb.0:
; PPC64-NEXT:    add 3, 3, 4
; PPC64-NEXT:    addi 3, 3, 1
; PPC64-NEXT:    blr
  %t0 = add i64 %x, 1
  %t1 = add i64 %y, %t0
  ret i64 %t1
}

define <16 x i8> @vector_i128_i8(<16 x i8> %x, <16 x i8> %y) nounwind {
; PPC32-LABEL: vector_i128_i8:
; PPC32:       # %bb.0:
; PPC32-NEXT:    stwu 1, -64(1)
; PPC32-NEXT:    stw 21, 20(1) # 4-byte Folded Spill
; PPC32-NEXT:    lbz 21, 123(1)
; PPC32-NEXT:    stw 22, 24(1) # 4-byte Folded Spill
; PPC32-NEXT:    stw 23, 28(1) # 4-byte Folded Spill
; PPC32-NEXT:    add 7, 21, 7
; PPC32-NEXT:    lbz 23, 115(1)
; PPC32-NEXT:    lbz 22, 119(1)
; PPC32-NEXT:    lbz 21, 135(1)
; PPC32-NEXT:    add 5, 23, 5
; PPC32-NEXT:    lbz 23, 127(1)
; PPC32-NEXT:    add 6, 22, 6
; PPC32-NEXT:    lbz 22, 131(1)
; PPC32-NEXT:    add 10, 21, 10
; PPC32-NEXT:    stw 26, 40(1) # 4-byte Folded Spill
; PPC32-NEXT:    add 8, 23, 8
; PPC32-NEXT:    lbz 26, 83(1)
; PPC32-NEXT:    add 9, 22, 9
; PPC32-NEXT:    lbz 21, 147(1)
; PPC32-NEXT:    stw 24, 32(1) # 4-byte Folded Spill
; PPC32-NEXT:    stw 25, 36(1) # 4-byte Folded Spill
; PPC32-NEXT:    add 26, 21, 26
; PPC32-NEXT:    lbz 25, 79(1)
; PPC32-NEXT:    lbz 24, 75(1)
; PPC32-NEXT:    lbz 23, 139(1)
; PPC32-NEXT:    lbz 22, 143(1)
; PPC32-NEXT:    stw 29, 52(1) # 4-byte Folded Spill
; PPC32-NEXT:    add 24, 23, 24
; PPC32-NEXT:    lbz 29, 95(1)
; PPC32-NEXT:    add 25, 22, 25
; PPC32-NEXT:    lbz 21, 159(1)
; PPC32-NEXT:    stw 27, 44(1) # 4-byte Folded Spill
; PPC32-NEXT:    stw 28, 48(1) # 4-byte Folded Spill
; PPC32-NEXT:    add 29, 21, 29
; PPC32-NEXT:    lbz 28, 91(1)
; PPC32-NEXT:    lbz 27, 87(1)
; PPC32-NEXT:    lbz 23, 151(1)
; PPC32-NEXT:    lbz 22, 155(1)
; PPC32-NEXT:    lbz 4, 111(1)
; PPC32-NEXT:    add 27, 23, 27
; PPC32-NEXT:    lbz 21, 175(1)
; PPC32-NEXT:    add 28, 22, 28
; PPC32-NEXT:    lbz 11, 107(1)
; PPC32-NEXT:    lbz 12, 171(1)
; PPC32-NEXT:    add 4, 21, 4
; PPC32-NEXT:    stw 30, 56(1) # 4-byte Folded Spill
; PPC32-NEXT:    addi 4, 4, 1
; PPC32-NEXT:    lbz 0, 103(1)
; PPC32-NEXT:    add 11, 12, 11
; PPC32-NEXT:    lbz 30, 99(1)
; PPC32-NEXT:    lbz 23, 163(1)
; PPC32-NEXT:    lbz 22, 167(1)
; PPC32-NEXT:    add 30, 23, 30
; PPC32-NEXT:    stb 4, 15(3)
; PPC32-NEXT:    add 23, 22, 0
; PPC32-NEXT:    addi 4, 11, 1
; PPC32-NEXT:    stb 4, 14(3)
; PPC32-NEXT:    addi 4, 23, 1
; PPC32-NEXT:    stb 4, 13(3)
; PPC32-NEXT:    addi 4, 30, 1
; PPC32-NEXT:    stb 4, 12(3)
; PPC32-NEXT:    addi 4, 29, 1
; PPC32-NEXT:    stb 4, 11(3)
; PPC32-NEXT:    addi 4, 28, 1
; PPC32-NEXT:    stb 4, 10(3)
; PPC32-NEXT:    addi 4, 27, 1
; PPC32-NEXT:    stb 4, 9(3)
; PPC32-NEXT:    addi 4, 26, 1
; PPC32-NEXT:    stb 4, 8(3)
; PPC32-NEXT:    addi 4, 25, 1
; PPC32-NEXT:    stb 4, 7(3)
; PPC32-NEXT:    addi 4, 24, 1
; PPC32-NEXT:    stb 4, 6(3)
; PPC32-NEXT:    addi 4, 10, 1
; PPC32-NEXT:    stb 4, 5(3)
; PPC32-NEXT:    addi 4, 9, 1
; PPC32-NEXT:    stb 4, 4(3)
; PPC32-NEXT:    addi 4, 8, 1
; PPC32-NEXT:    stb 4, 3(3)
; PPC32-NEXT:    addi 4, 7, 1
; PPC32-NEXT:    stb 4, 2(3)
; PPC32-NEXT:    addi 4, 6, 1
; PPC32-NEXT:    stb 4, 1(3)
; PPC32-NEXT:    addi 4, 5, 1
; PPC32-NEXT:    stb 4, 0(3)
; PPC32-NEXT:    lwz 30, 56(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 29, 52(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 28, 48(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 27, 44(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 26, 40(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 25, 36(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 24, 32(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 23, 28(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 22, 24(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 21, 20(1) # 4-byte Folded Reload
; PPC32-NEXT:    addi 1, 1, 64
; PPC32-NEXT:    blr
;
; PPC64BE-LABEL: vector_i128_i8:
; PPC64BE:       # %bb.0:
; PPC64BE-NEXT:    std 21, -88(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    lbz 21, 207(1)
; PPC64BE-NEXT:    std 22, -80(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 23, -72(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 25, -56(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 24, -64(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 28, -32(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 27, -40(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 26, -48(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 29, -24(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    lbz 22, 199(1)
; PPC64BE-NEXT:    lbz 23, 191(1)
; PPC64BE-NEXT:    add 6, 21, 6
; PPC64BE-NEXT:    lbz 21, 231(1)
; PPC64BE-NEXT:    add 5, 22, 5
; PPC64BE-NEXT:    lbz 22, 223(1)
; PPC64BE-NEXT:    add 4, 23, 4
; PPC64BE-NEXT:    lbz 23, 215(1)
; PPC64BE-NEXT:    add 9, 21, 9
; PPC64BE-NEXT:    lbz 25, 127(1)
; PPC64BE-NEXT:    add 8, 22, 8
; PPC64BE-NEXT:    lbz 21, 255(1)
; PPC64BE-NEXT:    add 7, 23, 7
; PPC64BE-NEXT:    lbz 24, 119(1)
; PPC64BE-NEXT:    addi 9, 9, 1
; PPC64BE-NEXT:    lbz 22, 247(1)
; PPC64BE-NEXT:    add 25, 21, 25
; PPC64BE-NEXT:    lbz 23, 239(1)
; PPC64BE-NEXT:    addi 8, 8, 1
; PPC64BE-NEXT:    lbz 28, 151(1)
; PPC64BE-NEXT:    add 24, 22, 24
; PPC64BE-NEXT:    lbz 21, 279(1)
; PPC64BE-NEXT:    add 10, 23, 10
; PPC64BE-NEXT:    lbz 27, 143(1)
; PPC64BE-NEXT:    addi 10, 10, 1
; PPC64BE-NEXT:    lbz 22, 271(1)
; PPC64BE-NEXT:    add 28, 21, 28
; PPC64BE-NEXT:    lbz 26, 135(1)
; PPC64BE-NEXT:    addi 7, 7, 1
; PPC64BE-NEXT:    lbz 23, 263(1)
; PPC64BE-NEXT:    add 27, 22, 27
; PPC64BE-NEXT:    lbz 11, 183(1)
; PPC64BE-NEXT:    addi 6, 6, 1
; PPC64BE-NEXT:    lbz 21, 311(1)
; PPC64BE-NEXT:    add 26, 23, 26
; PPC64BE-NEXT:    lbz 12, 175(1)
; PPC64BE-NEXT:    addi 5, 5, 1
; PPC64BE-NEXT:    lbz 0, 303(1)
; PPC64BE-NEXT:    add 11, 21, 11
; PPC64BE-NEXT:    lbz 30, 167(1)
; PPC64BE-NEXT:    addi 11, 11, 1
; PPC64BE-NEXT:    lbz 22, 295(1)
; PPC64BE-NEXT:    add 12, 0, 12
; PPC64BE-NEXT:    lbz 29, 159(1)
; PPC64BE-NEXT:    addi 4, 4, 1
; PPC64BE-NEXT:    lbz 23, 287(1)
; PPC64BE-NEXT:    add 30, 22, 30
; PPC64BE-NEXT:    stb 11, 15(3)
; PPC64BE-NEXT:    addi 11, 12, 1
; PPC64BE-NEXT:    add 29, 23, 29
; PPC64BE-NEXT:    stb 11, 14(3)
; PPC64BE-NEXT:    addi 11, 30, 1
; PPC64BE-NEXT:    stb 11, 13(3)
; PPC64BE-NEXT:    addi 11, 29, 1
; PPC64BE-NEXT:    stb 11, 12(3)
; PPC64BE-NEXT:    addi 11, 28, 1
; PPC64BE-NEXT:    stb 11, 11(3)
; PPC64BE-NEXT:    addi 11, 27, 1
; PPC64BE-NEXT:    stb 11, 10(3)
; PPC64BE-NEXT:    addi 11, 26, 1
; PPC64BE-NEXT:    stb 11, 9(3)
; PPC64BE-NEXT:    addi 11, 25, 1
; PPC64BE-NEXT:    stb 11, 8(3)
; PPC64BE-NEXT:    addi 11, 24, 1
; PPC64BE-NEXT:    stb 11, 7(3)
; PPC64BE-NEXT:    stb 10, 6(3)
; PPC64BE-NEXT:    stb 9, 5(3)
; PPC64BE-NEXT:    stb 8, 4(3)
; PPC64BE-NEXT:    stb 7, 3(3)
; PPC64BE-NEXT:    stb 6, 2(3)
; PPC64BE-NEXT:    stb 5, 1(3)
; PPC64BE-NEXT:    stb 4, 0(3)
; PPC64BE-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 29, -24(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 28, -32(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 27, -40(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 26, -48(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 25, -56(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 24, -64(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 23, -72(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 22, -80(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 21, -88(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    blr
;
; PPC64LE-LABEL: vector_i128_i8:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    xxlnor 34, 34, 34
; PPC64LE-NEXT:    vsububm 2, 3, 2
; PPC64LE-NEXT:    blr
  %t0 = add <16 x i8> %x, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %t1 = add <16 x i8> %y, %t0
  ret <16 x i8> %t1
}

define <8 x i16> @vector_i128_i16(<8 x i16> %x, <8 x i16> %y) nounwind {
; PPC32-LABEL: vector_i128_i16:
; PPC32:       # %bb.0:
; PPC32-NEXT:    stwu 1, -32(1)
; PPC32-NEXT:    stw 26, 8(1) # 4-byte Folded Spill
; PPC32-NEXT:    stw 27, 12(1) # 4-byte Folded Spill
; PPC32-NEXT:    stw 28, 16(1) # 4-byte Folded Spill
; PPC32-NEXT:    stw 29, 20(1) # 4-byte Folded Spill
; PPC32-NEXT:    stw 30, 24(1) # 4-byte Folded Spill
; PPC32-NEXT:    lhz 11, 70(1)
; PPC32-NEXT:    lhz 12, 66(1)
; PPC32-NEXT:    lhz 0, 62(1)
; PPC32-NEXT:    add 10, 11, 10
; PPC32-NEXT:    lhz 30, 58(1)
; PPC32-NEXT:    add 9, 12, 9
; PPC32-NEXT:    lhz 29, 50(1)
; PPC32-NEXT:    add 8, 0, 8
; PPC32-NEXT:    lhz 28, 42(1)
; PPC32-NEXT:    add 7, 30, 7
; PPC32-NEXT:    lhz 27, 46(1)
; PPC32-NEXT:    add 5, 29, 5
; PPC32-NEXT:    lhz 26, 54(1)
; PPC32-NEXT:    add 3, 28, 3
; PPC32-NEXT:    add 4, 27, 4
; PPC32-NEXT:    addi 3, 3, 1
; PPC32-NEXT:    add 6, 26, 6
; PPC32-NEXT:    addi 4, 4, 1
; PPC32-NEXT:    addi 5, 5, 1
; PPC32-NEXT:    addi 6, 6, 1
; PPC32-NEXT:    addi 7, 7, 1
; PPC32-NEXT:    addi 8, 8, 1
; PPC32-NEXT:    addi 9, 9, 1
; PPC32-NEXT:    addi 10, 10, 1
; PPC32-NEXT:    lwz 30, 24(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 29, 20(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 28, 16(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 27, 12(1) # 4-byte Folded Reload
; PPC32-NEXT:    lwz 26, 8(1) # 4-byte Folded Reload
; PPC32-NEXT:    addi 1, 1, 32
; PPC32-NEXT:    blr
;
; PPC64BE-LABEL: vector_i128_i16:
; PPC64BE:       # %bb.0:
; PPC64BE-NEXT:    std 25, -56(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 26, -48(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 27, -40(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 28, -32(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 29, -24(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; PPC64BE-NEXT:    lhz 11, 118(1)
; PPC64BE-NEXT:    lhz 12, 182(1)
; PPC64BE-NEXT:    lhz 0, 174(1)
; PPC64BE-NEXT:    lhz 30, 166(1)
; PPC64BE-NEXT:    add 11, 12, 11
; PPC64BE-NEXT:    lhz 29, 158(1)
; PPC64BE-NEXT:    add 10, 0, 10
; PPC64BE-NEXT:    lhz 28, 142(1)
; PPC64BE-NEXT:    add 9, 30, 9
; PPC64BE-NEXT:    lhz 27, 126(1)
; PPC64BE-NEXT:    add 8, 29, 8
; PPC64BE-NEXT:    lhz 26, 134(1)
; PPC64BE-NEXT:    add 6, 28, 6
; PPC64BE-NEXT:    lhz 25, 150(1)
; PPC64BE-NEXT:    add 4, 27, 4
; PPC64BE-NEXT:    add 5, 26, 5
; PPC64BE-NEXT:    addi 11, 11, 1
; PPC64BE-NEXT:    add 7, 25, 7
; PPC64BE-NEXT:    addi 10, 10, 1
; PPC64BE-NEXT:    addi 9, 9, 1
; PPC64BE-NEXT:    addi 8, 8, 1
; PPC64BE-NEXT:    addi 7, 7, 1
; PPC64BE-NEXT:    addi 6, 6, 1
; PPC64BE-NEXT:    addi 5, 5, 1
; PPC64BE-NEXT:    addi 4, 4, 1
; PPC64BE-NEXT:    sth 11, 14(3)
; PPC64BE-NEXT:    sth 10, 12(3)
; PPC64BE-NEXT:    sth 9, 10(3)
; PPC64BE-NEXT:    sth 8, 8(3)
; PPC64BE-NEXT:    sth 7, 6(3)
; PPC64BE-NEXT:    sth 6, 4(3)
; PPC64BE-NEXT:    sth 5, 2(3)
; PPC64BE-NEXT:    sth 4, 0(3)
; PPC64BE-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 29, -24(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 28, -32(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 27, -40(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 26, -48(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    ld 25, -56(1) # 8-byte Folded Reload
; PPC64BE-NEXT:    blr
;
; PPC64LE-LABEL: vector_i128_i16:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    xxlnor 34, 34, 34
; PPC64LE-NEXT:    vsubuhm 2, 3, 2
; PPC64LE-NEXT:    blr
  %t0 = add <8 x i16> %x, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %t1 = add <8 x i16> %y, %t0
  ret <8 x i16> %t1
}

define <4 x i32> @vector_i128_i32(<4 x i32> %x, <4 x i32> %y) nounwind {
; PPC32-LABEL: vector_i128_i32:
; PPC32:       # %bb.0:
; PPC32-NEXT:    add 3, 7, 3
; PPC32-NEXT:    add 4, 8, 4
; PPC32-NEXT:    add 5, 9, 5
; PPC32-NEXT:    add 6, 10, 6
; PPC32-NEXT:    addi 3, 3, 1
; PPC32-NEXT:    addi 4, 4, 1
; PPC32-NEXT:    addi 5, 5, 1
; PPC32-NEXT:    addi 6, 6, 1
; PPC32-NEXT:    blr
;
; PPC64BE-LABEL: vector_i128_i32:
; PPC64BE:       # %bb.0:
; PPC64BE-NEXT:    add 6, 10, 6
; PPC64BE-NEXT:    add 5, 9, 5
; PPC64BE-NEXT:    add 4, 8, 4
; PPC64BE-NEXT:    add 3, 7, 3
; PPC64BE-NEXT:    addi 6, 6, 1
; PPC64BE-NEXT:    addi 5, 5, 1
; PPC64BE-NEXT:    addi 4, 4, 1
; PPC64BE-NEXT:    addi 3, 3, 1
; PPC64BE-NEXT:    blr
;
; PPC64LE-LABEL: vector_i128_i32:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    xxlnor 34, 34, 34
; PPC64LE-NEXT:    vsubuwm 2, 3, 2
; PPC64LE-NEXT:    blr
  %t0 = add <4 x i32> %x, <i32 1, i32 1, i32 1, i32 1>
  %t1 = add <4 x i32> %y, %t0
  ret <4 x i32> %t1
}

define <2 x i64> @vector_i128_i64(<2 x i64> %x, <2 x i64> %y) nounwind {
; PPC32-LABEL: vector_i128_i64:
; PPC32:       # %bb.0:
; PPC32-NEXT:    not 4, 4
; PPC32-NEXT:    not 3, 3
; PPC32-NEXT:    subc 4, 8, 4
; PPC32-NEXT:    not 6, 6
; PPC32-NEXT:    subfe 3, 3, 7
; PPC32-NEXT:    not 5, 5
; PPC32-NEXT:    subc 6, 10, 6
; PPC32-NEXT:    subfe 5, 5, 9
; PPC32-NEXT:    blr
;
; PPC64BE-LABEL: vector_i128_i64:
; PPC64BE:       # %bb.0:
; PPC64BE-NEXT:    add 3, 5, 3
; PPC64BE-NEXT:    add 4, 6, 4
; PPC64BE-NEXT:    addi 3, 3, 1
; PPC64BE-NEXT:    addi 4, 4, 1
; PPC64BE-NEXT:    blr
;
; PPC64LE-LABEL: vector_i128_i64:
; PPC64LE:       # %bb.0:
; PPC64LE-NEXT:    xxlnor 34, 34, 34
; PPC64LE-NEXT:    vsubudm 2, 3, 2
; PPC64LE-NEXT:    blr
  %t0 = add <2 x i64> %x, <i64 1, i64 1>
  %t1 = add <2 x i64> %y, %t0
  ret <2 x i64> %t1
}