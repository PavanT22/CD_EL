; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=s390x-linux-gnu | FileCheck %s
;
; Test PC-relative memory accesses of globals with packed struct types.
; PC-relative memory accesses cannot be used when the address is not
; aligned. This can happen with programs like the following (which are not
; strictly correct):
;
; #pragma pack(1)
; struct  {
;   short a;
;   int b;
; } c;
;
; void main()    {
;   int *e = &c.b;
;   *e = 0;
; }
;

%packed.i16i32 = type <{ i16, i32 }>
%packed.i16i32i16i32 = type <{ i16, i32, i16, i32 }>
%packed.i16i64 = type <{ i16, i64 }>
%packed.i8i16 = type <{ i8, i16 }>

@A_align2 = dso_local global %packed.i16i32 zeroinitializer, align 2
@B_align2 = dso_local global %packed.i16i32i16i32 zeroinitializer, align 2
@C_align2 = dso_local global %packed.i16i64 zeroinitializer, align 2
@D_align4 = dso_local global %packed.i16i32 zeroinitializer, align 4
@E_align4 = dso_local global %packed.i16i32i16i32 zeroinitializer, align 4
@F_align2 = dso_local global %packed.i8i16 zeroinitializer, align 2

;;; Stores

; unaligned packed struct + 2  -> unaligned address
define dso_local void @f1() {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, A_align2
; CHECK-NEXT:    mvhi 2(%r1), 0
; CHECK-NEXT:    br %r14
  store i32 0, ptr getelementptr inbounds (%packed.i16i32, ptr @A_align2, i64 0, i32 1), align 4
  ret void
}

; unaligned packed struct  + 8  -> unaligned address
define dso_local void @f2() {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, B_align2
; CHECK-NEXT:    mvhi 8(%r1), 0
; CHECK-NEXT:    br %r14
  store i32 0, ptr getelementptr inbounds (%packed.i16i32i16i32, ptr @B_align2, i64 0, i32 3), align 4
  ret void
}

; aligned packed struct + 2  -> unaligned address
define dso_local void @f3() {
; CHECK-LABEL: f3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, D_align4
; CHECK-NEXT:    mvhi 2(%r1), 0
; CHECK-NEXT:    br %r14
  store i32 0, ptr getelementptr inbounds (%packed.i16i32, ptr @D_align4, i64 0, i32 1), align 4
  ret void
}

; aligned packed struct + 8  -> aligned address
define dso_local void @f4() {
; CHECK-LABEL: f4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lhi %r0, 0
; CHECK-NEXT:    strl %r0, E_align4+8
; CHECK-NEXT:    br %r14
  store i32 0, ptr getelementptr inbounds (%packed.i16i32i16i32, ptr @E_align4, i64 0, i32 3), align 4
  ret void
}

define dso_local void @f5() {
; CHECK-LABEL: f5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, C_align2
; CHECK-NEXT:    mvghi 2(%r1), 0
; CHECK-NEXT:    br %r14
  store i64 0, ptr getelementptr inbounds (%packed.i16i64, ptr @C_align2, i64 0, i32 1), align 8
  ret void
}

define dso_local void @f6() {
; CHECK-LABEL: f6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, F_align2
; CHECK-NEXT:    mvhhi 1(%r1), 0
; CHECK-NEXT:    br %r14
  store i16 0, ptr getelementptr inbounds (%packed.i8i16, ptr @F_align2, i64 0, i32 1), align 2
  ret void
}

define dso_local void @f7(ptr %Src) {
; CHECK-LABEL: f7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lg %r0, 0(%r2)
; CHECK-NEXT:    larl %r1, D_align4
; CHECK-NEXT:    st %r0, 2(%r1)
; CHECK-NEXT:    br %r14
  %L = load i64, ptr %Src
  %T = trunc i64 %L to i32
  store i32 %T, ptr getelementptr inbounds (%packed.i16i32, ptr @D_align4, i64 0, i32 1), align 4
  ret void
}

define dso_local void @f8(ptr %Src) {
; CHECK-LABEL: f8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lg %r0, 0(%r2)
; CHECK-NEXT:    larl %r1, F_align2
; CHECK-NEXT:    sth %r0, 1(%r1)
; CHECK-NEXT:    br %r14
  %L = load i64, ptr %Src
  %T = trunc i64 %L to i16
  store i16 %T, ptr getelementptr inbounds (%packed.i8i16, ptr @F_align2, i64 0, i32 1), align 2
  ret void
}

;;; Loads

; unaligned packed struct + 2  -> unaligned address
define dso_local i32 @f9() {
; CHECK-LABEL: f9:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, A_align2
; CHECK-NEXT:    l %r2, 2(%r1)
; CHECK-NEXT:    br %r14
  %L = load i32, ptr getelementptr inbounds (%packed.i16i32, ptr @A_align2, i64 0, i32 1), align 4
  ret i32 %L
}

; unaligned packed struct  + 8  -> unaligned address
define dso_local i32 @f10() {
; CHECK-LABEL: f10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, B_align2
; CHECK-NEXT:    l %r2, 8(%r1)
; CHECK-NEXT:    br %r14
  %L = load i32, ptr getelementptr inbounds (%packed.i16i32i16i32, ptr @B_align2, i64 0, i32 3), align 4
  ret i32 %L
}

; aligned packed struct + 2  -> unaligned address
define dso_local i32 @f11() {
; CHECK-LABEL: f11:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, D_align4
; CHECK-NEXT:    l %r2, 2(%r1)
; CHECK-NEXT:    br %r14
  %L = load i32, ptr getelementptr inbounds (%packed.i16i32, ptr @D_align4, i64 0, i32 1), align 4
  ret i32 %L
}

; aligned packed struct + 8  -> aligned address
define dso_local i32 @f12() {
; CHECK-LABEL: f12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lrl %r2, E_align4+8
; CHECK-NEXT:    br %r14
  %L = load i32, ptr getelementptr inbounds (%packed.i16i32i16i32, ptr @E_align4, i64 0, i32 3), align 4
  ret i32 %L
}

define dso_local i64 @f13() {
; CHECK-LABEL: f13:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, C_align2
; CHECK-NEXT:    lg %r2, 2(%r1)
; CHECK-NEXT:    br %r14
  %L = load i64, ptr getelementptr inbounds (%packed.i16i64, ptr @C_align2, i64 0, i32 1), align 8
  ret i64 %L
}

define dso_local i32 @f14() {
; CHECK-LABEL: f14:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, F_align2
; CHECK-NEXT:    lh %r2, 1(%r1)
; CHECK-NEXT:    br %r14
  %L = load i16, ptr getelementptr inbounds (%packed.i8i16, ptr @F_align2, i64 0, i32 1), align 2
  %ext = sext i16 %L to i32
  ret i32 %ext
}

define dso_local i64 @f15() {
; CHECK-LABEL: f15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    larl %r1, F_align2
; CHECK-NEXT:    llgh %r2, 1(%r1)
; CHECK-NEXT:    br %r14
  %L = load i16, ptr getelementptr inbounds (%packed.i8i16, ptr @F_align2, i64 0, i32 1), align 2
  %ext = zext i16 %L to i64
  ret i64 %ext
}

;;; Loads folded into compare instructions

define dso_local i32 @f16(i32 %src1) {
; CHECK-LABEL: f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    larl %r1, A_align2
; CHECK-NEXT:    c %r2, 2(%r1)
; CHECK-NEXT:    blr %r14
; CHECK-NEXT:  .LBB15_1: # %mulb
; CHECK-NEXT:    msr %r2, %r2
; CHECK-NEXT:    br %r14
entry:
  %src2 = load i32, ptr getelementptr inbounds (%packed.i16i32, ptr @A_align2, i64 0, i32 1), align 4
  %cond = icmp slt i32 %src1, %src2
  br i1 %cond, label %exit, label %mulb
mulb:
  %mul = mul i32 %src1, %src1
  br label %exit
exit:
  %res = phi i32 [ %src1, %entry ], [ %mul, %mulb ]
  ret i32 %res
}

define dso_local i64 @f17(i64 %src1) {
; CHECK-LABEL: f17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    larl %r1, C_align2
; CHECK-NEXT:    clg %r2, 2(%r1)
; CHECK-NEXT:    blr %r14
; CHECK-NEXT:  .LBB16_1: # %mulb
; CHECK-NEXT:    msgr %r2, %r2
; CHECK-NEXT:    br %r14
entry:
  %src2 = load i64, ptr getelementptr inbounds (%packed.i16i64, ptr @C_align2, i64 0, i32 1), align 8
  %cond = icmp ult i64 %src1, %src2
  br i1 %cond, label %exit, label %mulb
mulb:
  %mul = mul i64 %src1, %src1
  br label %exit
exit:
  %res = phi i64 [ %src1, %entry ], [ %mul, %mulb ]
  ret i64 %res
}
