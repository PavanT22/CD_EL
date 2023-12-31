; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi lp64f -disable-strictnode-mutation < %s | \
; RUN:   FileCheck %s -check-prefix=RV64IZFH
; RUN: llc -mtriple=riscv64 -mattr=+zhinx -verify-machineinstrs \
; RUN:   -target-abi lp64 -disable-strictnode-mutation < %s | \
; RUN:   FileCheck %s -check-prefix=RV64IZHINX

; This file exhaustively checks half<->i32 conversions. In general,
; fcvt.l[u].h can be selected instead of fcvt.w[u].h because poison is
; generated for an fpto[s|u]i conversion if the result doesn't fit in the
; target type.

define i32 @aext_fptosi(half %a) nounwind {
; RV64IZFH-LABEL: aext_fptosi:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.w.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: aext_fptosi:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.w.h a0, a0, rtz
; RV64IZHINX-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}
declare i32 @llvm.experimental.constrained.fptosi.i32.f16(half, metadata)

define signext i32 @sext_fptosi(half %a) nounwind {
; RV64IZFH-LABEL: sext_fptosi:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.w.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: sext_fptosi:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.w.h a0, a0, rtz
; RV64IZHINX-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}

define zeroext i32 @zext_fptosi(half %a) nounwind {
; RV64IZFH-LABEL: zext_fptosi:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.w.h a0, fa0, rtz
; RV64IZFH-NEXT:    slli a0, a0, 32
; RV64IZFH-NEXT:    srli a0, a0, 32
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: zext_fptosi:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.w.h a0, a0, rtz
; RV64IZHINX-NEXT:    slli a0, a0, 32
; RV64IZHINX-NEXT:    srli a0, a0, 32
; RV64IZHINX-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}

define i32 @aext_fptoui(half %a) nounwind {
; RV64IZFH-LABEL: aext_fptoui:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.wu.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: aext_fptoui:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.wu.h a0, a0, rtz
; RV64IZHINX-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}
declare i32 @llvm.experimental.constrained.fptoui.i32.f16(half, metadata)

define signext i32 @sext_fptoui(half %a) nounwind {
; RV64IZFH-LABEL: sext_fptoui:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.wu.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: sext_fptoui:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.wu.h a0, a0, rtz
; RV64IZHINX-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}

define zeroext i32 @zext_fptoui(half %a) nounwind {
; RV64IZFH-LABEL: zext_fptoui:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.lu.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: zext_fptoui:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.lu.h a0, a0, rtz
; RV64IZHINX-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f16(half %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}

define half @uitofp_aext_i32_to_f16(i32 %a) nounwind {
; RV64IZFH-LABEL: uitofp_aext_i32_to_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.wu fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: uitofp_aext_i32_to_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.h.wu a0, a0
; RV64IZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.uitofp.f16.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}
declare half @llvm.experimental.constrained.uitofp.f16.i32(i32 %a, metadata, metadata)

define half @uitofp_sext_i32_to_f16(i32 signext %a) nounwind {
; RV64IZFH-LABEL: uitofp_sext_i32_to_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.wu fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: uitofp_sext_i32_to_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.h.wu a0, a0
; RV64IZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.uitofp.f16.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

define half @uitofp_zext_i32_to_f16(i32 zeroext %a) nounwind {
; RV64IZFH-LABEL: uitofp_zext_i32_to_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.wu fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: uitofp_zext_i32_to_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.h.wu a0, a0
; RV64IZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.uitofp.f16.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

define half @sitofp_aext_i32_to_f16(i32 %a) nounwind {
; RV64IZFH-LABEL: sitofp_aext_i32_to_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.w fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: sitofp_aext_i32_to_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.h.w a0, a0
; RV64IZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.sitofp.f16.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}
declare half @llvm.experimental.constrained.sitofp.f16.i32(i32 %a, metadata, metadata)

define half @sitofp_sext_i32_to_f16(i32 signext %a) nounwind {
; RV64IZFH-LABEL: sitofp_sext_i32_to_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.w fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: sitofp_sext_i32_to_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.h.w a0, a0
; RV64IZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.sitofp.f16.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}

define half @sitofp_zext_i32_to_f16(i32 zeroext %a) nounwind {
; RV64IZFH-LABEL: sitofp_zext_i32_to_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.w fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: sitofp_zext_i32_to_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    fcvt.h.w a0, a0
; RV64IZHINX-NEXT:    ret
  %1 = call half @llvm.experimental.constrained.sitofp.f16.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret half %1
}
