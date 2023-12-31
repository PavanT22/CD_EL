; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+experimental-zvfh,+f,+d -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8,LMULMAX8RV32
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+experimental-zvfh,+f,+d -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8,LMULMAX8RV64
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+experimental-zvfh,+f,+d -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1,LMULMAX1RV32
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+experimental-zvfh,+f,+d -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1,LMULMAX1RV64

define void @fp2si_v2f32_v2i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = fptosi <2 x float> %a to <2 x i32>
  store <2 x i32> %d, ptr %y
  ret void
}

define void @fp2ui_v2f32_v2i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = fptoui <2 x float> %a to <2 x i32>
  store <2 x i32> %d, ptr %y
  ret void
}

define <2 x i1> @fp2si_v2f32_v2i1(<2 x float> %x) {
; CHECK-LABEL: fp2si_v2f32_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptosi <2 x float> %x to <2 x i1>
  ret <2 x i1> %z
}

define <2 x i15> @fp2si_v2f32_v2i15(<2 x float> %x) {
; CHECK-LABEL: fp2si_v2f32_v2i15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %z = fptosi <2 x float> %x to <2 x i15>
  ret <2 x i15> %z
}

define <2 x i15> @fp2ui_v2f32_v2i15(<2 x float> %x) {
; CHECK-LABEL: fp2ui_v2f32_v2i15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %z = fptoui <2 x float> %x to <2 x i15>
  ret <2 x i15> %z
}

define <2 x i1> @fp2ui_v2f32_v2i1(<2 x float> %x) {
; CHECK-LABEL: fp2ui_v2f32_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptoui <2 x float> %x to <2 x i1>
  ret <2 x i1> %z
}

define void @fp2si_v3f32_v3i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v3f32_v3i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <3 x float>, ptr %x
  %d = fptosi <3 x float> %a to <3 x i32>
  store <3 x i32> %d, ptr %y
  ret void
}

define void @fp2ui_v3f32_v3i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v3f32_v3i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <3 x float>, ptr %x
  %d = fptoui <3 x float> %a to <3 x i32>
  store <3 x i32> %d, ptr %y
  ret void
}

define <3 x i1> @fp2si_v3f32_v3i1(<3 x float> %x) {
; CHECK-LABEL: fp2si_v3f32_v3i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptosi <3 x float> %x to <3 x i1>
  ret <3 x i1> %z
}

; FIXME: This is expanded when they could be widened + promoted
define <3 x i15> @fp2si_v3f32_v3i15(<3 x float> %x) {
; LMULMAX8RV32-LABEL: fp2si_v3f32_v3i15:
; LMULMAX8RV32:       # %bb.0:
; LMULMAX8RV32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX8RV32-NEXT:    vfncvt.rtz.x.f.w v9, v8
; LMULMAX8RV32-NEXT:    vslidedown.vi v8, v9, 2
; LMULMAX8RV32-NEXT:    vmv.x.s a1, v8
; LMULMAX8RV32-NEXT:    slli a2, a1, 17
; LMULMAX8RV32-NEXT:    srli a2, a2, 19
; LMULMAX8RV32-NEXT:    sh a2, 4(a0)
; LMULMAX8RV32-NEXT:    vmv.x.s a2, v9
; LMULMAX8RV32-NEXT:    lui a3, 8
; LMULMAX8RV32-NEXT:    addi a3, a3, -1
; LMULMAX8RV32-NEXT:    and a2, a2, a3
; LMULMAX8RV32-NEXT:    vslidedown.vi v8, v9, 1
; LMULMAX8RV32-NEXT:    vmv.x.s a4, v8
; LMULMAX8RV32-NEXT:    and a3, a4, a3
; LMULMAX8RV32-NEXT:    slli a3, a3, 15
; LMULMAX8RV32-NEXT:    slli a1, a1, 30
; LMULMAX8RV32-NEXT:    or a1, a2, a1
; LMULMAX8RV32-NEXT:    or a1, a1, a3
; LMULMAX8RV32-NEXT:    sw a1, 0(a0)
; LMULMAX8RV32-NEXT:    ret
;
; LMULMAX8RV64-LABEL: fp2si_v3f32_v3i15:
; LMULMAX8RV64:       # %bb.0:
; LMULMAX8RV64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX8RV64-NEXT:    vfncvt.rtz.x.f.w v9, v8
; LMULMAX8RV64-NEXT:    vmv.x.s a1, v9
; LMULMAX8RV64-NEXT:    lui a2, 8
; LMULMAX8RV64-NEXT:    addiw a2, a2, -1
; LMULMAX8RV64-NEXT:    and a1, a1, a2
; LMULMAX8RV64-NEXT:    vslidedown.vi v8, v9, 1
; LMULMAX8RV64-NEXT:    vmv.x.s a3, v8
; LMULMAX8RV64-NEXT:    and a2, a3, a2
; LMULMAX8RV64-NEXT:    slli a2, a2, 15
; LMULMAX8RV64-NEXT:    vslidedown.vi v8, v9, 2
; LMULMAX8RV64-NEXT:    vmv.x.s a3, v8
; LMULMAX8RV64-NEXT:    slli a3, a3, 30
; LMULMAX8RV64-NEXT:    or a1, a1, a3
; LMULMAX8RV64-NEXT:    or a1, a1, a2
; LMULMAX8RV64-NEXT:    sw a1, 0(a0)
; LMULMAX8RV64-NEXT:    slli a1, a1, 19
; LMULMAX8RV64-NEXT:    srli a1, a1, 51
; LMULMAX8RV64-NEXT:    sh a1, 4(a0)
; LMULMAX8RV64-NEXT:    ret
;
; LMULMAX1RV32-LABEL: fp2si_v3f32_v3i15:
; LMULMAX1RV32:       # %bb.0:
; LMULMAX1RV32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX1RV32-NEXT:    vfncvt.rtz.x.f.w v9, v8
; LMULMAX1RV32-NEXT:    vslidedown.vi v8, v9, 2
; LMULMAX1RV32-NEXT:    vmv.x.s a1, v8
; LMULMAX1RV32-NEXT:    slli a2, a1, 17
; LMULMAX1RV32-NEXT:    srli a2, a2, 19
; LMULMAX1RV32-NEXT:    sh a2, 4(a0)
; LMULMAX1RV32-NEXT:    vmv.x.s a2, v9
; LMULMAX1RV32-NEXT:    lui a3, 8
; LMULMAX1RV32-NEXT:    addi a3, a3, -1
; LMULMAX1RV32-NEXT:    and a2, a2, a3
; LMULMAX1RV32-NEXT:    vslidedown.vi v8, v9, 1
; LMULMAX1RV32-NEXT:    vmv.x.s a4, v8
; LMULMAX1RV32-NEXT:    and a3, a4, a3
; LMULMAX1RV32-NEXT:    slli a3, a3, 15
; LMULMAX1RV32-NEXT:    slli a1, a1, 30
; LMULMAX1RV32-NEXT:    or a1, a2, a1
; LMULMAX1RV32-NEXT:    or a1, a1, a3
; LMULMAX1RV32-NEXT:    sw a1, 0(a0)
; LMULMAX1RV32-NEXT:    ret
;
; LMULMAX1RV64-LABEL: fp2si_v3f32_v3i15:
; LMULMAX1RV64:       # %bb.0:
; LMULMAX1RV64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX1RV64-NEXT:    vfncvt.rtz.x.f.w v9, v8
; LMULMAX1RV64-NEXT:    vmv.x.s a1, v9
; LMULMAX1RV64-NEXT:    lui a2, 8
; LMULMAX1RV64-NEXT:    addiw a2, a2, -1
; LMULMAX1RV64-NEXT:    and a1, a1, a2
; LMULMAX1RV64-NEXT:    vslidedown.vi v8, v9, 1
; LMULMAX1RV64-NEXT:    vmv.x.s a3, v8
; LMULMAX1RV64-NEXT:    and a2, a3, a2
; LMULMAX1RV64-NEXT:    slli a2, a2, 15
; LMULMAX1RV64-NEXT:    vslidedown.vi v8, v9, 2
; LMULMAX1RV64-NEXT:    vmv.x.s a3, v8
; LMULMAX1RV64-NEXT:    slli a3, a3, 30
; LMULMAX1RV64-NEXT:    or a1, a1, a3
; LMULMAX1RV64-NEXT:    or a1, a1, a2
; LMULMAX1RV64-NEXT:    sw a1, 0(a0)
; LMULMAX1RV64-NEXT:    slli a1, a1, 19
; LMULMAX1RV64-NEXT:    srli a1, a1, 51
; LMULMAX1RV64-NEXT:    sh a1, 4(a0)
; LMULMAX1RV64-NEXT:    ret
  %z = fptosi <3 x float> %x to <3 x i15>
  ret <3 x i15> %z
}

; FIXME: This is expanded when they could be widened + promoted
define <3 x i15> @fp2ui_v3f32_v3i15(<3 x float> %x) {
; LMULMAX8RV32-LABEL: fp2ui_v3f32_v3i15:
; LMULMAX8RV32:       # %bb.0:
; LMULMAX8RV32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX8RV32-NEXT:    vfncvt.rtz.x.f.w v9, v8
; LMULMAX8RV32-NEXT:    vslidedown.vi v8, v9, 2
; LMULMAX8RV32-NEXT:    vmv.x.s a1, v8
; LMULMAX8RV32-NEXT:    slli a2, a1, 17
; LMULMAX8RV32-NEXT:    srli a2, a2, 19
; LMULMAX8RV32-NEXT:    sh a2, 4(a0)
; LMULMAX8RV32-NEXT:    vmv.x.s a2, v9
; LMULMAX8RV32-NEXT:    lui a3, 16
; LMULMAX8RV32-NEXT:    addi a3, a3, -1
; LMULMAX8RV32-NEXT:    and a2, a2, a3
; LMULMAX8RV32-NEXT:    vslidedown.vi v8, v9, 1
; LMULMAX8RV32-NEXT:    vmv.x.s a4, v8
; LMULMAX8RV32-NEXT:    and a3, a4, a3
; LMULMAX8RV32-NEXT:    slli a3, a3, 15
; LMULMAX8RV32-NEXT:    slli a1, a1, 30
; LMULMAX8RV32-NEXT:    or a1, a2, a1
; LMULMAX8RV32-NEXT:    or a1, a1, a3
; LMULMAX8RV32-NEXT:    sw a1, 0(a0)
; LMULMAX8RV32-NEXT:    ret
;
; LMULMAX8RV64-LABEL: fp2ui_v3f32_v3i15:
; LMULMAX8RV64:       # %bb.0:
; LMULMAX8RV64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX8RV64-NEXT:    vfncvt.rtz.x.f.w v9, v8
; LMULMAX8RV64-NEXT:    vmv.x.s a1, v9
; LMULMAX8RV64-NEXT:    lui a2, 16
; LMULMAX8RV64-NEXT:    addiw a2, a2, -1
; LMULMAX8RV64-NEXT:    and a1, a1, a2
; LMULMAX8RV64-NEXT:    vslidedown.vi v8, v9, 1
; LMULMAX8RV64-NEXT:    vmv.x.s a3, v8
; LMULMAX8RV64-NEXT:    and a2, a3, a2
; LMULMAX8RV64-NEXT:    slli a2, a2, 15
; LMULMAX8RV64-NEXT:    vslidedown.vi v8, v9, 2
; LMULMAX8RV64-NEXT:    vmv.x.s a3, v8
; LMULMAX8RV64-NEXT:    slli a3, a3, 30
; LMULMAX8RV64-NEXT:    or a1, a1, a3
; LMULMAX8RV64-NEXT:    or a1, a1, a2
; LMULMAX8RV64-NEXT:    sw a1, 0(a0)
; LMULMAX8RV64-NEXT:    slli a1, a1, 19
; LMULMAX8RV64-NEXT:    srli a1, a1, 51
; LMULMAX8RV64-NEXT:    sh a1, 4(a0)
; LMULMAX8RV64-NEXT:    ret
;
; LMULMAX1RV32-LABEL: fp2ui_v3f32_v3i15:
; LMULMAX1RV32:       # %bb.0:
; LMULMAX1RV32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX1RV32-NEXT:    vfncvt.rtz.x.f.w v9, v8
; LMULMAX1RV32-NEXT:    vslidedown.vi v8, v9, 2
; LMULMAX1RV32-NEXT:    vmv.x.s a1, v8
; LMULMAX1RV32-NEXT:    slli a2, a1, 17
; LMULMAX1RV32-NEXT:    srli a2, a2, 19
; LMULMAX1RV32-NEXT:    sh a2, 4(a0)
; LMULMAX1RV32-NEXT:    vmv.x.s a2, v9
; LMULMAX1RV32-NEXT:    lui a3, 16
; LMULMAX1RV32-NEXT:    addi a3, a3, -1
; LMULMAX1RV32-NEXT:    and a2, a2, a3
; LMULMAX1RV32-NEXT:    vslidedown.vi v8, v9, 1
; LMULMAX1RV32-NEXT:    vmv.x.s a4, v8
; LMULMAX1RV32-NEXT:    and a3, a4, a3
; LMULMAX1RV32-NEXT:    slli a3, a3, 15
; LMULMAX1RV32-NEXT:    slli a1, a1, 30
; LMULMAX1RV32-NEXT:    or a1, a2, a1
; LMULMAX1RV32-NEXT:    or a1, a1, a3
; LMULMAX1RV32-NEXT:    sw a1, 0(a0)
; LMULMAX1RV32-NEXT:    ret
;
; LMULMAX1RV64-LABEL: fp2ui_v3f32_v3i15:
; LMULMAX1RV64:       # %bb.0:
; LMULMAX1RV64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX1RV64-NEXT:    vfncvt.rtz.x.f.w v9, v8
; LMULMAX1RV64-NEXT:    vmv.x.s a1, v9
; LMULMAX1RV64-NEXT:    lui a2, 16
; LMULMAX1RV64-NEXT:    addiw a2, a2, -1
; LMULMAX1RV64-NEXT:    and a1, a1, a2
; LMULMAX1RV64-NEXT:    vslidedown.vi v8, v9, 1
; LMULMAX1RV64-NEXT:    vmv.x.s a3, v8
; LMULMAX1RV64-NEXT:    and a2, a3, a2
; LMULMAX1RV64-NEXT:    slli a2, a2, 15
; LMULMAX1RV64-NEXT:    vslidedown.vi v8, v9, 2
; LMULMAX1RV64-NEXT:    vmv.x.s a3, v8
; LMULMAX1RV64-NEXT:    slli a3, a3, 30
; LMULMAX1RV64-NEXT:    or a1, a1, a3
; LMULMAX1RV64-NEXT:    or a1, a1, a2
; LMULMAX1RV64-NEXT:    sw a1, 0(a0)
; LMULMAX1RV64-NEXT:    slli a1, a1, 19
; LMULMAX1RV64-NEXT:    srli a1, a1, 51
; LMULMAX1RV64-NEXT:    sh a1, 4(a0)
; LMULMAX1RV64-NEXT:    ret
  %z = fptoui <3 x float> %x to <3 x i15>
  ret <3 x i15> %z
}

define <3 x i1> @fp2ui_v3f32_v3i1(<3 x float> %x) {
; CHECK-LABEL: fp2ui_v3f32_v3i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptoui <3 x float> %x to <3 x i1>
  ret <3 x i1> %z
}

define void @fp2si_v8f32_v8i32(ptr %x, ptr %y) {
; LMULMAX8-LABEL: fp2si_v8f32_v8i32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX8-NEXT:    vle32.v v8, (a0)
; LMULMAX8-NEXT:    vfcvt.rtz.x.f.v v8, v8
; LMULMAX8-NEXT:    vse32.v v8, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2si_v8f32_v8i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle32.v v8, (a2)
; LMULMAX1-NEXT:    vle32.v v9, (a0)
; LMULMAX1-NEXT:    vfcvt.rtz.x.f.v v8, v8
; LMULMAX1-NEXT:    vfcvt.rtz.x.f.v v9, v9
; LMULMAX1-NEXT:    vse32.v v9, (a1)
; LMULMAX1-NEXT:    addi a1, a1, 16
; LMULMAX1-NEXT:    vse32.v v8, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = fptosi <8 x float> %a to <8 x i32>
  store <8 x i32> %d, ptr %y
  ret void
}

define void @fp2ui_v8f32_v8i32(ptr %x, ptr %y) {
; LMULMAX8-LABEL: fp2ui_v8f32_v8i32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX8-NEXT:    vle32.v v8, (a0)
; LMULMAX8-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; LMULMAX8-NEXT:    vse32.v v8, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2ui_v8f32_v8i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle32.v v8, (a2)
; LMULMAX1-NEXT:    vle32.v v9, (a0)
; LMULMAX1-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; LMULMAX1-NEXT:    vfcvt.rtz.xu.f.v v9, v9
; LMULMAX1-NEXT:    vse32.v v9, (a1)
; LMULMAX1-NEXT:    addi a1, a1, 16
; LMULMAX1-NEXT:    vse32.v v8, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = fptoui <8 x float> %a to <8 x i32>
  store <8 x i32> %d, ptr %y
  ret void
}

define <8 x i1> @fp2si_v8f32_v8i1(<8 x float> %x) {
; LMULMAX8-LABEL: fp2si_v8f32_v8i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; LMULMAX8-NEXT:    vfncvt.rtz.x.f.w v10, v8
; LMULMAX8-NEXT:    vand.vi v8, v10, 1
; LMULMAX8-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2si_v8f32_v8i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v10, v8
; LMULMAX1-NEXT:    vand.vi v8, v10, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vmv.v.i v8, 0
; LMULMAX1-NEXT:    vmerge.vim v8, v8, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v10, v9
; LMULMAX1-NEXT:    vand.vi v9, v10, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v9, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; LMULMAX1-NEXT:    vmv.v.i v9, 0
; LMULMAX1-NEXT:    vmerge.vim v9, v9, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslideup.vi v8, v9, 4
; LMULMAX1-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX1-NEXT:    ret
  %z = fptosi <8 x float> %x to <8 x i1>
  ret <8 x i1> %z
}

define <8 x i1> @fp2ui_v8f32_v8i1(<8 x float> %x) {
; LMULMAX8-LABEL: fp2ui_v8f32_v8i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; LMULMAX8-NEXT:    vfncvt.rtz.xu.f.w v10, v8
; LMULMAX8-NEXT:    vand.vi v8, v10, 1
; LMULMAX8-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2ui_v8f32_v8i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v10, v8
; LMULMAX1-NEXT:    vand.vi v8, v10, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vmv.v.i v8, 0
; LMULMAX1-NEXT:    vmerge.vim v8, v8, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v10, v9
; LMULMAX1-NEXT:    vand.vi v9, v10, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v9, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; LMULMAX1-NEXT:    vmv.v.i v9, 0
; LMULMAX1-NEXT:    vmerge.vim v9, v9, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslideup.vi v8, v9, 4
; LMULMAX1-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX1-NEXT:    ret
  %z = fptoui <8 x float> %x to <8 x i1>
  ret <8 x i1> %z
}

define void @fp2si_v2f32_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v9, v8
; CHECK-NEXT:    vse64.v v9, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = fptosi <2 x float> %a to <2 x i64>
  store <2 x i64> %d, ptr %y
  ret void
}

define void @fp2ui_v2f32_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v9, v8
; CHECK-NEXT:    vse64.v v9, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = fptoui <2 x float> %a to <2 x i64>
  store <2 x i64> %d, ptr %y
  ret void
}

define void @fp2si_v8f32_v8i64(ptr %x, ptr %y) {
; LMULMAX8-LABEL: fp2si_v8f32_v8i64:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX8-NEXT:    vle32.v v8, (a0)
; LMULMAX8-NEXT:    vfwcvt.rtz.x.f.v v12, v8
; LMULMAX8-NEXT:    vse64.v v12, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2si_v8f32_v8i64:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle32.v v8, (a2)
; LMULMAX1-NEXT:    vle32.v v9, (a0)
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v10, v8, 2
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfwcvt.rtz.x.f.v v11, v10
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v10, v9, 2
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfwcvt.rtz.x.f.v v12, v10
; LMULMAX1-NEXT:    vfwcvt.rtz.x.f.v v10, v8
; LMULMAX1-NEXT:    vfwcvt.rtz.x.f.v v8, v9
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vse64.v v12, (a0)
; LMULMAX1-NEXT:    vse64.v v8, (a1)
; LMULMAX1-NEXT:    addi a0, a1, 48
; LMULMAX1-NEXT:    vse64.v v11, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 32
; LMULMAX1-NEXT:    vse64.v v10, (a0)
; LMULMAX1-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = fptosi <8 x float> %a to <8 x i64>
  store <8 x i64> %d, ptr %y
  ret void
}

define void @fp2ui_v8f32_v8i64(ptr %x, ptr %y) {
; LMULMAX8-LABEL: fp2ui_v8f32_v8i64:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX8-NEXT:    vle32.v v8, (a0)
; LMULMAX8-NEXT:    vfwcvt.rtz.xu.f.v v12, v8
; LMULMAX8-NEXT:    vse64.v v12, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2ui_v8f32_v8i64:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle32.v v8, (a2)
; LMULMAX1-NEXT:    vle32.v v9, (a0)
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v10, v8, 2
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfwcvt.rtz.xu.f.v v11, v10
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, m1, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v10, v9, 2
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfwcvt.rtz.xu.f.v v12, v10
; LMULMAX1-NEXT:    vfwcvt.rtz.xu.f.v v10, v8
; LMULMAX1-NEXT:    vfwcvt.rtz.xu.f.v v8, v9
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vse64.v v12, (a0)
; LMULMAX1-NEXT:    vse64.v v8, (a1)
; LMULMAX1-NEXT:    addi a0, a1, 48
; LMULMAX1-NEXT:    vse64.v v11, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 32
; LMULMAX1-NEXT:    vse64.v v10, (a0)
; LMULMAX1-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = fptoui <8 x float> %a to <8 x i64>
  store <8 x i64> %d, ptr %y
  ret void
}

define void @fp2si_v2f16_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v8, v9
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x half>, ptr %x
  %d = fptosi <2 x half> %a to <2 x i64>
  store <2 x i64> %d, ptr %y
  ret void
}

define void @fp2ui_v2f16_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v8, v9
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x half>, ptr %x
  %d = fptoui <2 x half> %a to <2 x i64>
  store <2 x i64> %d, ptr %y
  ret void
}

define <2 x i1> @fp2si_v2f16_v2i1(<2 x half> %x) {
; CHECK-LABEL: fp2si_v2f16_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptosi <2 x half> %x to <2 x i1>
  ret <2 x i1> %z
}

define <2 x i1> @fp2ui_v2f16_v2i1(<2 x half> %x) {
; CHECK-LABEL: fp2ui_v2f16_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptoui <2 x half> %x to <2 x i1>
  ret <2 x i1> %z
}

define void @fp2si_v2f64_v2i8(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f64_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v9, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %d = fptosi <2 x double> %a to <2 x i8>
  store <2 x i8> %d, ptr %y
  ret void
}

define void @fp2ui_v2f64_v2i8(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f64_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v9, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %d = fptoui <2 x double> %a to <2 x i8>
  store <2 x i8> %d, ptr %y
  ret void
}

define <2 x i1> @fp2si_v2f64_v2i1(<2 x double> %x) {
; CHECK-LABEL: fp2si_v2f64_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptosi <2 x double> %x to <2 x i1>
  ret <2 x i1> %z
}

define <2 x i1> @fp2ui_v2f64_v2i1(<2 x double> %x) {
; CHECK-LABEL: fp2ui_v2f64_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptoui <2 x double> %x to <2 x i1>
  ret <2 x i1> %z
}

define void @fp2si_v8f64_v8i8(ptr %x, ptr %y) {
; LMULMAX8-LABEL: fp2si_v8f64_v8i8:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX8-NEXT:    vle64.v v8, (a0)
; LMULMAX8-NEXT:    vfncvt.rtz.x.f.w v12, v8
; LMULMAX8-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; LMULMAX8-NEXT:    vnsrl.wi v8, v12, 0
; LMULMAX8-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; LMULMAX8-NEXT:    vnsrl.wi v8, v8, 0
; LMULMAX8-NEXT:    vse8.v v8, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2si_v8f64_v8i8:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    addi a2, a0, 48
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vle64.v v8, (a2)
; LMULMAX1-NEXT:    addi a2, a0, 32
; LMULMAX1-NEXT:    vle64.v v9, (a0)
; LMULMAX1-NEXT:    vle64.v v10, (a2)
; LMULMAX1-NEXT:    addi a0, a0, 16
; LMULMAX1-NEXT:    vle64.v v11, (a0)
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v12, v9
; LMULMAX1-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v9, v12, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v9, v9, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v12, v11
; LMULMAX1-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v11, v12, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v11, v11, 0
; LMULMAX1-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; LMULMAX1-NEXT:    vslideup.vi v9, v11, 2
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v11, v10
; LMULMAX1-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v10, v11, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v10, v10, 0
; LMULMAX1-NEXT:    vsetivli zero, 6, e8, mf2, tu, ma
; LMULMAX1-NEXT:    vslideup.vi v9, v10, 4
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v10, v8
; LMULMAX1-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v8, v10, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v8, v8, 0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslideup.vi v9, v8, 6
; LMULMAX1-NEXT:    vse8.v v9, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x double>, ptr %x
  %d = fptosi <8 x double> %a to <8 x i8>
  store <8 x i8> %d, ptr %y
  ret void
}

define void @fp2ui_v8f64_v8i8(ptr %x, ptr %y) {
; LMULMAX8-LABEL: fp2ui_v8f64_v8i8:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX8-NEXT:    vle64.v v8, (a0)
; LMULMAX8-NEXT:    vfncvt.rtz.xu.f.w v12, v8
; LMULMAX8-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; LMULMAX8-NEXT:    vnsrl.wi v8, v12, 0
; LMULMAX8-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; LMULMAX8-NEXT:    vnsrl.wi v8, v8, 0
; LMULMAX8-NEXT:    vse8.v v8, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2ui_v8f64_v8i8:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    addi a2, a0, 48
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vle64.v v8, (a2)
; LMULMAX1-NEXT:    addi a2, a0, 32
; LMULMAX1-NEXT:    vle64.v v9, (a0)
; LMULMAX1-NEXT:    vle64.v v10, (a2)
; LMULMAX1-NEXT:    addi a0, a0, 16
; LMULMAX1-NEXT:    vle64.v v11, (a0)
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v12, v9
; LMULMAX1-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v9, v12, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v9, v9, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v12, v11
; LMULMAX1-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v11, v12, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v11, v11, 0
; LMULMAX1-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; LMULMAX1-NEXT:    vslideup.vi v9, v11, 2
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v11, v10
; LMULMAX1-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v10, v11, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v10, v10, 0
; LMULMAX1-NEXT:    vsetivli zero, 6, e8, mf2, tu, ma
; LMULMAX1-NEXT:    vslideup.vi v9, v10, 4
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v10, v8
; LMULMAX1-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v8, v10, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v8, v8, 0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslideup.vi v9, v8, 6
; LMULMAX1-NEXT:    vse8.v v9, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x double>, ptr %x
  %d = fptoui <8 x double> %a to <8 x i8>
  store <8 x i8> %d, ptr %y
  ret void
}

define <8 x i1> @fp2si_v8f64_v8i1(<8 x double> %x) {
; LMULMAX8-LABEL: fp2si_v8f64_v8i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX8-NEXT:    vfncvt.rtz.x.f.w v12, v8
; LMULMAX8-NEXT:    vand.vi v8, v12, 1
; LMULMAX8-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2si_v8f64_v8i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v12, v8
; LMULMAX1-NEXT:    vand.vi v8, v12, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vmv.v.i v8, 0
; LMULMAX1-NEXT:    vmerge.vim v12, v8, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v13, v9
; LMULMAX1-NEXT:    vand.vi v9, v13, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v9, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vmv.v.i v9, 0
; LMULMAX1-NEXT:    vmerge.vim v13, v9, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; LMULMAX1-NEXT:    vslideup.vi v12, v13, 2
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vmsne.vi v0, v12, 0
; LMULMAX1-NEXT:    vmerge.vim v12, v8, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v13, v10
; LMULMAX1-NEXT:    vand.vi v10, v13, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v10, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vmerge.vim v10, v9, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 6, e8, mf2, tu, ma
; LMULMAX1-NEXT:    vslideup.vi v12, v10, 4
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vmsne.vi v0, v12, 0
; LMULMAX1-NEXT:    vmerge.vim v8, v8, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v10, v11
; LMULMAX1-NEXT:    vand.vi v10, v10, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v10, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vmerge.vim v9, v9, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslideup.vi v8, v9, 6
; LMULMAX1-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX1-NEXT:    ret
  %z = fptosi <8 x double> %x to <8 x i1>
  ret <8 x i1> %z
}

define <8 x i1> @fp2ui_v8f64_v8i1(<8 x double> %x) {
; LMULMAX8-LABEL: fp2ui_v8f64_v8i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX8-NEXT:    vfncvt.rtz.xu.f.w v12, v8
; LMULMAX8-NEXT:    vand.vi v8, v12, 1
; LMULMAX8-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2ui_v8f64_v8i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v12, v8
; LMULMAX1-NEXT:    vand.vi v8, v12, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vmv.v.i v8, 0
; LMULMAX1-NEXT:    vmerge.vim v12, v8, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v13, v9
; LMULMAX1-NEXT:    vand.vi v9, v13, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v9, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vmv.v.i v9, 0
; LMULMAX1-NEXT:    vmerge.vim v13, v9, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; LMULMAX1-NEXT:    vslideup.vi v12, v13, 2
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vmsne.vi v0, v12, 0
; LMULMAX1-NEXT:    vmerge.vim v12, v8, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v13, v10
; LMULMAX1-NEXT:    vand.vi v10, v13, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v10, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vmerge.vim v10, v9, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 6, e8, mf2, tu, ma
; LMULMAX1-NEXT:    vslideup.vi v12, v10, 4
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vmsne.vi v0, v12, 0
; LMULMAX1-NEXT:    vmerge.vim v8, v8, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v10, v11
; LMULMAX1-NEXT:    vand.vi v10, v10, 1
; LMULMAX1-NEXT:    vmsne.vi v0, v10, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; LMULMAX1-NEXT:    vmerge.vim v9, v9, 1, v0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslideup.vi v8, v9, 6
; LMULMAX1-NEXT:    vmsne.vi v0, v8, 0
; LMULMAX1-NEXT:    ret
  %z = fptoui <8 x double> %x to <8 x i1>
  ret <8 x i1> %z
}
