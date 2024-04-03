; ModuleID = 'complex.c'
source_filename = "complex.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.complex_t = type { double, double }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local { double, double } @conv_from_polar(double noundef %0, double noundef %1) #0 {
  %3 = alloca %struct.complex_t, align 8
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  store double %0, double* %4, align 8
  store double %1, double* %5, align 8
  %6 = load double, double* %4, align 8
  %7 = load double, double* %5, align 8
  %8 = call double @cos(double noundef %7) #3
  %9 = fmul double %6, %8
  %10 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %3, i32 0, i32 0
  store double %9, double* %10, align 8
  %11 = load double, double* %4, align 8
  %12 = load double, double* %5, align 8
  %13 = call double @sin(double noundef %12) #3
  %14 = fmul double %11, %13
  %15 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %3, i32 0, i32 1
  store double %14, double* %15, align 8
  %16 = bitcast %struct.complex_t* %3 to { double, double }*
  %17 = load { double, double }, { double, double }* %16, align 8
  ret { double, double } %17
}

; Function Attrs: nounwind
declare double @cos(double noundef) #1

; Function Attrs: nounwind
declare double @sin(double noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local { double, double } @add(double %0, double %1, double %2, double %3) #0 {
  %5 = alloca %struct.complex_t, align 8
  %6 = alloca %struct.complex_t, align 8
  %7 = alloca %struct.complex_t, align 8
  %8 = bitcast %struct.complex_t* %6 to { double, double }*
  %9 = getelementptr inbounds { double, double }, { double, double }* %8, i32 0, i32 0
  store double %0, double* %9, align 8
  %10 = getelementptr inbounds { double, double }, { double, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct.complex_t* %7 to { double, double }*
  %12 = getelementptr inbounds { double, double }, { double, double }* %11, i32 0, i32 0
  store double %2, double* %12, align 8
  %13 = getelementptr inbounds { double, double }, { double, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %6, i32 0, i32 0
  %15 = load double, double* %14, align 8
  %16 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %7, i32 0, i32 0
  %17 = load double, double* %16, align 8
  %18 = fadd double %15, %17
  %19 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %5, i32 0, i32 0
  store double %18, double* %19, align 8
  %20 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %6, i32 0, i32 1
  %21 = load double, double* %20, align 8
  %22 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %7, i32 0, i32 1
  %23 = load double, double* %22, align 8
  %24 = fadd double %21, %23
  %25 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %5, i32 0, i32 1
  store double %24, double* %25, align 8
  %26 = bitcast %struct.complex_t* %5 to { double, double }*
  %27 = load { double, double }, { double, double }* %26, align 8
  ret { double, double } %27
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local { double, double } @multiply(double %0, double %1, double %2, double %3) #0 {
  %5 = alloca %struct.complex_t, align 8
  %6 = alloca %struct.complex_t, align 8
  %7 = alloca %struct.complex_t, align 8
  %8 = bitcast %struct.complex_t* %6 to { double, double }*
  %9 = getelementptr inbounds { double, double }, { double, double }* %8, i32 0, i32 0
  store double %0, double* %9, align 8
  %10 = getelementptr inbounds { double, double }, { double, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct.complex_t* %7 to { double, double }*
  %12 = getelementptr inbounds { double, double }, { double, double }* %11, i32 0, i32 0
  store double %2, double* %12, align 8
  %13 = getelementptr inbounds { double, double }, { double, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %6, i32 0, i32 0
  %15 = load double, double* %14, align 8
  %16 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %7, i32 0, i32 0
  %17 = load double, double* %16, align 8
  %18 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %6, i32 0, i32 1
  %19 = load double, double* %18, align 8
  %20 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %7, i32 0, i32 1
  %21 = load double, double* %20, align 8
  %22 = fmul double %19, %21
  %23 = fneg double %22
  %24 = call double @llvm.fmuladd.f64(double %15, double %17, double %23)
  %25 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %5, i32 0, i32 0
  store double %24, double* %25, align 8
  %26 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %6, i32 0, i32 0
  %27 = load double, double* %26, align 8
  %28 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %7, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %6, i32 0, i32 1
  %31 = load double, double* %30, align 8
  %32 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %7, i32 0, i32 0
  %33 = load double, double* %32, align 8
  %34 = fmul double %31, %33
  %35 = call double @llvm.fmuladd.f64(double %27, double %29, double %34)
  %36 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %5, i32 0, i32 1
  store double %35, double* %36, align 8
  %37 = bitcast %struct.complex_t* %5 to { double, double }*
  %38 = load { double, double }, { double, double }* %37, align 8
  ret { double, double } %38
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
