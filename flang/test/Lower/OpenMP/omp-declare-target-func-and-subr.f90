!RUN: %flang_fc1 -emit-fir -fopenmp %s -o - | FileCheck %s

! Check specification valid forms of declare target with functions 
! utilising device_type and to clauses as well as the default 
! zero clause declare target

! CHECK-LABEL: func.func @_QPfunc_t_device()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (nohost), capture_clause = (to)>{{.*}}
FUNCTION FUNC_T_DEVICE() RESULT(I)
!$omp declare target to(FUNC_T_DEVICE) device_type(nohost)
    INTEGER :: I
    I = 1
END FUNCTION FUNC_T_DEVICE

! CHECK-LABEL: func.func @_QPfunc_t_host()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (host), capture_clause = (to)>{{.*}}
FUNCTION FUNC_T_HOST() RESULT(I)
!$omp declare target to(FUNC_T_HOST) device_type(host)
    INTEGER :: I
    I = 1
END FUNCTION FUNC_T_HOST

! CHECK-LABEL: func.func @_QPfunc_t_any()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (any), capture_clause = (to)>{{.*}}
FUNCTION FUNC_T_ANY() RESULT(I)
!$omp declare target to(FUNC_T_ANY) device_type(any)
    INTEGER :: I
    I = 1
END FUNCTION FUNC_T_ANY

! CHECK-LABEL: func.func @_QPfunc_default_t_any()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (any), capture_clause = (to)>{{.*}}
FUNCTION FUNC_DEFAULT_T_ANY() RESULT(I)
!$omp declare target to(FUNC_DEFAULT_T_ANY)
    INTEGER :: I
    I = 1
END FUNCTION FUNC_DEFAULT_T_ANY

! CHECK-LABEL: func.func @_QPfunc_default_any()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (any), capture_clause = (to)>{{.*}}
FUNCTION FUNC_DEFAULT_ANY() RESULT(I)
!$omp declare target
    INTEGER :: I
    I = 1
END FUNCTION FUNC_DEFAULT_ANY

! CHECK-LABEL: func.func @_QPfunc_default_extendedlist()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (any), capture_clause = (to)>{{.*}}
FUNCTION FUNC_DEFAULT_EXTENDEDLIST() RESULT(I)
!$omp declare target(FUNC_DEFAULT_EXTENDEDLIST)
    INTEGER :: I
    I = 1
END FUNCTION FUNC_DEFAULT_EXTENDEDLIST

!! -----

! Check specification valid forms of declare target with subroutines 
! utilising device_type and to clauses as well as the default 
! zero clause declare target

! CHECK-LABEL: func.func @_QPsubr_t_device()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (nohost), capture_clause = (to)>{{.*}}
SUBROUTINE SUBR_T_DEVICE()
!$omp declare target to(SUBR_T_DEVICE) device_type(nohost)
END

! CHECK-LABEL: func.func @_QPsubr_t_host()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (host), capture_clause = (to)>{{.*}}
SUBROUTINE SUBR_T_HOST()
!$omp declare target to(SUBR_T_HOST) device_type(host)
END

! CHECK-LABEL: func.func @_QPsubr_t_any()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (any), capture_clause = (to)>{{.*}}
SUBROUTINE SUBR_T_ANY()
!$omp declare target to(SUBR_T_ANY) device_type(any)
END

! CHECK-LABEL: func.func @_QPsubr_default_t_any()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (any), capture_clause = (to)>{{.*}}
SUBROUTINE SUBR_DEFAULT_T_ANY()
!$omp declare target to(SUBR_DEFAULT_T_ANY)
END

! CHECK-LABEL: func.func @_QPsubr_default_any()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (any), capture_clause = (to)>{{.*}}
SUBROUTINE SUBR_DEFAULT_ANY()
!$omp declare target
END

! CHECK-LABEL: func.func @_QPsubr_default_extendedlist()
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (any), capture_clause = (to)>{{.*}}
SUBROUTINE SUBR_DEFAULT_EXTENDEDLIST()
!$omp declare target(SUBR_DEFAULT_EXTENDEDLIST)
END

!! -----

! CHECK-LABEL: func.func @_QPrecursive_declare_target
! CHECK-SAME: {{.*}}attributes {omp.declare_target = #omp.declaretarget<device_type = (nohost), capture_clause = (to)>{{.*}}
RECURSIVE FUNCTION RECURSIVE_DECLARE_TARGET(INCREMENT) RESULT(K)
!$omp declare target to(RECURSIVE_DECLARE_TARGET) device_type(nohost)
    INTEGER :: INCREMENT, K
    IF (INCREMENT == 10) THEN
        K = INCREMENT
    ELSE
        K = RECURSIVE_DECLARE_TARGET(INCREMENT + 1)
    END IF
END FUNCTION RECURSIVE_DECLARE_TARGET
