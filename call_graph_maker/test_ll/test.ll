; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.complex_t = type { double, double }

@.str = private unnamed_addr constant [53 x i8] c"Index \09 Cooley-Tukey Output \09 \09 Good-Thomas Output \0A\00", align 1
@.str.1 = private unnamed_addr constant [28 x i8] c"%d: \09 %f + %fi \09 %f + %fi \0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local { double, double } @conv_from_polar(double noundef %0, double noundef %1) #0 {
  %3 = alloca %struct.complex_t, align 8
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  store double %0, double* %4, align 8
  store double %1, double* %5, align 8
  %6 = load double, double* %4, align 8
  %7 = load double, double* %5, align 8
  %8 = call double @cos(double noundef %7) #5
  %9 = fmul double %6, %8
  %10 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %3, i32 0, i32 0
  store double %9, double* %10, align 8
  %11 = load double, double* %4, align 8
  %12 = load double, double* %5, align 8
  %13 = call double @sin(double noundef %12) #5
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

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.complex_t* @DFT_naive(%struct.complex_t* noundef %0, i32 noundef %1) #0 {
  %3 = alloca %struct.complex_t*, align 8
  %4 = alloca i32, align 4
  %5 = alloca %struct.complex_t*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.complex_t, align 8
  %9 = alloca %struct.complex_t, align 8
  %10 = alloca %struct.complex_t, align 8
  store %struct.complex_t* %0, %struct.complex_t** %3, align 8
  store i32 %1, i32* %4, align 4
  %11 = load i32, i32* %4, align 4
  %12 = sext i32 %11 to i64
  %13 = mul i64 16, %12
  %14 = call noalias i8* @malloc(i64 noundef %13) #5
  %15 = bitcast i8* %14 to %struct.complex_t*
  store %struct.complex_t* %15, %struct.complex_t** %5, align 8
  store i32 0, i32* %6, align 4
  br label %16

16:                                               ; preds = %101, %2
  %17 = load i32, i32* %6, align 4
  %18 = load i32, i32* %4, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %104

20:                                               ; preds = %16
  %21 = load %struct.complex_t*, %struct.complex_t** %5, align 8
  %22 = load i32, i32* %6, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %21, i64 %23
  %25 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %24, i32 0, i32 0
  store double 0.000000e+00, double* %25, align 8
  %26 = load %struct.complex_t*, %struct.complex_t** %5, align 8
  %27 = load i32, i32* %6, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %26, i64 %28
  %30 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %29, i32 0, i32 1
  store double 0.000000e+00, double* %30, align 8
  store i32 0, i32* %7, align 4
  br label %31

31:                                               ; preds = %97, %20
  %32 = load i32, i32* %7, align 4
  %33 = load i32, i32* %4, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %100

35:                                               ; preds = %31
  %36 = load %struct.complex_t*, %struct.complex_t** %5, align 8
  %37 = load i32, i32* %6, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %36, i64 %38
  %40 = load %struct.complex_t*, %struct.complex_t** %5, align 8
  %41 = load i32, i32* %6, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %40, i64 %42
  %44 = load %struct.complex_t*, %struct.complex_t** %3, align 8
  %45 = load i32, i32* %7, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %44, i64 %46
  %48 = load i32, i32* %7, align 4
  %49 = sitofp i32 %48 to double
  %50 = fmul double 0xC01921FB54442D18, %49
  %51 = load i32, i32* %6, align 4
  %52 = sitofp i32 %51 to double
  %53 = fmul double %50, %52
  %54 = load i32, i32* %4, align 4
  %55 = sitofp i32 %54 to double
  %56 = fdiv double %53, %55
  %57 = call { double, double } @conv_from_polar(double noundef 1.000000e+00, double noundef %56)
  %58 = bitcast %struct.complex_t* %10 to { double, double }*
  %59 = getelementptr inbounds { double, double }, { double, double }* %58, i32 0, i32 0
  %60 = extractvalue { double, double } %57, 0
  store double %60, double* %59, align 8
  %61 = getelementptr inbounds { double, double }, { double, double }* %58, i32 0, i32 1
  %62 = extractvalue { double, double } %57, 1
  store double %62, double* %61, align 8
  %63 = bitcast %struct.complex_t* %47 to { double, double }*
  %64 = getelementptr inbounds { double, double }, { double, double }* %63, i32 0, i32 0
  %65 = load double, double* %64, align 8
  %66 = getelementptr inbounds { double, double }, { double, double }* %63, i32 0, i32 1
  %67 = load double, double* %66, align 8
  %68 = bitcast %struct.complex_t* %10 to { double, double }*
  %69 = getelementptr inbounds { double, double }, { double, double }* %68, i32 0, i32 0
  %70 = load double, double* %69, align 8
  %71 = getelementptr inbounds { double, double }, { double, double }* %68, i32 0, i32 1
  %72 = load double, double* %71, align 8
  %73 = call { double, double } @multiply(double %65, double %67, double %70, double %72)
  %74 = bitcast %struct.complex_t* %9 to { double, double }*
  %75 = getelementptr inbounds { double, double }, { double, double }* %74, i32 0, i32 0
  %76 = extractvalue { double, double } %73, 0
  store double %76, double* %75, align 8
  %77 = getelementptr inbounds { double, double }, { double, double }* %74, i32 0, i32 1
  %78 = extractvalue { double, double } %73, 1
  store double %78, double* %77, align 8
  %79 = bitcast %struct.complex_t* %43 to { double, double }*
  %80 = getelementptr inbounds { double, double }, { double, double }* %79, i32 0, i32 0
  %81 = load double, double* %80, align 8
  %82 = getelementptr inbounds { double, double }, { double, double }* %79, i32 0, i32 1
  %83 = load double, double* %82, align 8
  %84 = bitcast %struct.complex_t* %9 to { double, double }*
  %85 = getelementptr inbounds { double, double }, { double, double }* %84, i32 0, i32 0
  %86 = load double, double* %85, align 8
  %87 = getelementptr inbounds { double, double }, { double, double }* %84, i32 0, i32 1
  %88 = load double, double* %87, align 8
  %89 = call { double, double } @add(double %81, double %83, double %86, double %88)
  %90 = bitcast %struct.complex_t* %8 to { double, double }*
  %91 = getelementptr inbounds { double, double }, { double, double }* %90, i32 0, i32 0
  %92 = extractvalue { double, double } %89, 0
  store double %92, double* %91, align 8
  %93 = getelementptr inbounds { double, double }, { double, double }* %90, i32 0, i32 1
  %94 = extractvalue { double, double } %89, 1
  store double %94, double* %93, align 8
  %95 = bitcast %struct.complex_t* %39 to i8*
  %96 = bitcast %struct.complex_t* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %95, i8* align 8 %96, i64 16, i1 false)
  br label %97

97:                                               ; preds = %35
  %98 = load i32, i32* %7, align 4
  %99 = add nsw i32 %98, 1
  store i32 %99, i32* %7, align 4
  br label %31, !llvm.loop !6

100:                                              ; preds = %31
  br label %101

101:                                              ; preds = %100
  %102 = load i32, i32* %6, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, i32* %6, align 4
  br label %16, !llvm.loop !8

104:                                              ; preds = %16
  %105 = load %struct.complex_t*, %struct.complex_t** %5, align 8
  ret %struct.complex_t* %105
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64 noundef) #1

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.complex_t* @FFT_GoodThomas(%struct.complex_t* noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca %struct.complex_t*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca %struct.complex_t**, align 8
  %13 = alloca %struct.complex_t**, align 8
  %14 = alloca %struct.complex_t*, align 8
  store %struct.complex_t* %0, %struct.complex_t** %5, align 8
  store i32 %1, i32* %6, align 4
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %15 = load i32, i32* %7, align 4
  %16 = sext i32 %15 to i64
  %17 = mul i64 8, %16
  %18 = call noalias i8* @malloc(i64 noundef %17) #5
  %19 = bitcast i8* %18 to %struct.complex_t**
  store %struct.complex_t** %19, %struct.complex_t*** %12, align 8
  store i32 0, i32* %9, align 4
  br label %20

20:                                               ; preds = %34, %4
  %21 = load i32, i32* %9, align 4
  %22 = load i32, i32* %7, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %37

24:                                               ; preds = %20
  %25 = load i32, i32* %8, align 4
  %26 = sext i32 %25 to i64
  %27 = mul i64 16, %26
  %28 = call noalias i8* @malloc(i64 noundef %27) #5
  %29 = bitcast i8* %28 to %struct.complex_t*
  %30 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %31 = load i32, i32* %9, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %30, i64 %32
  store %struct.complex_t* %29, %struct.complex_t** %33, align 8
  br label %34

34:                                               ; preds = %24
  %35 = load i32, i32* %9, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %9, align 4
  br label %20, !llvm.loop !9

37:                                               ; preds = %20
  %38 = load i32, i32* %8, align 4
  %39 = sext i32 %38 to i64
  %40 = mul i64 8, %39
  %41 = call noalias i8* @malloc(i64 noundef %40) #5
  %42 = bitcast i8* %41 to %struct.complex_t**
  store %struct.complex_t** %42, %struct.complex_t*** %13, align 8
  store i32 0, i32* %10, align 4
  br label %43

43:                                               ; preds = %57, %37
  %44 = load i32, i32* %10, align 4
  %45 = load i32, i32* %8, align 4
  %46 = icmp slt i32 %44, %45
  br i1 %46, label %47, label %60

47:                                               ; preds = %43
  %48 = load i32, i32* %7, align 4
  %49 = sext i32 %48 to i64
  %50 = mul i64 16, %49
  %51 = call noalias i8* @malloc(i64 noundef %50) #5
  %52 = bitcast i8* %51 to %struct.complex_t*
  %53 = load %struct.complex_t**, %struct.complex_t*** %13, align 8
  %54 = load i32, i32* %10, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %53, i64 %55
  store %struct.complex_t* %52, %struct.complex_t** %56, align 8
  br label %57

57:                                               ; preds = %47
  %58 = load i32, i32* %10, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, i32* %10, align 4
  br label %43, !llvm.loop !10

60:                                               ; preds = %43
  store i32 0, i32* %11, align 4
  br label %61

61:                                               ; preds = %85, %60
  %62 = load i32, i32* %11, align 4
  %63 = icmp slt i32 %62, 30
  br i1 %63, label %64, label %88

64:                                               ; preds = %61
  %65 = load i32, i32* %11, align 4
  %66 = load i32, i32* %7, align 4
  %67 = srem i32 %65, %66
  store i32 %67, i32* %9, align 4
  %68 = load i32, i32* %11, align 4
  %69 = load i32, i32* %8, align 4
  %70 = srem i32 %68, %69
  store i32 %70, i32* %10, align 4
  %71 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %72 = load i32, i32* %9, align 4
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %71, i64 %73
  %75 = load %struct.complex_t*, %struct.complex_t** %74, align 8
  %76 = load i32, i32* %10, align 4
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %75, i64 %77
  %79 = load %struct.complex_t*, %struct.complex_t** %5, align 8
  %80 = load i32, i32* %11, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %79, i64 %81
  %83 = bitcast %struct.complex_t* %78 to i8*
  %84 = bitcast %struct.complex_t* %82 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %83, i8* align 8 %84, i64 16, i1 false)
  br label %85

85:                                               ; preds = %64
  %86 = load i32, i32* %11, align 4
  %87 = add nsw i32 %86, 1
  store i32 %87, i32* %11, align 4
  br label %61, !llvm.loop !11

88:                                               ; preds = %61
  store i32 0, i32* %9, align 4
  br label %89

89:                                               ; preds = %105, %88
  %90 = load i32, i32* %9, align 4
  %91 = load i32, i32* %7, align 4
  %92 = icmp slt i32 %90, %91
  br i1 %92, label %93, label %108

93:                                               ; preds = %89
  %94 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %95 = load i32, i32* %9, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %94, i64 %96
  %98 = load %struct.complex_t*, %struct.complex_t** %97, align 8
  %99 = load i32, i32* %8, align 4
  %100 = call %struct.complex_t* @DFT_naive(%struct.complex_t* noundef %98, i32 noundef %99)
  %101 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %102 = load i32, i32* %9, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %101, i64 %103
  store %struct.complex_t* %100, %struct.complex_t** %104, align 8
  br label %105

105:                                              ; preds = %93
  %106 = load i32, i32* %9, align 4
  %107 = add nsw i32 %106, 1
  store i32 %107, i32* %9, align 4
  br label %89, !llvm.loop !12

108:                                              ; preds = %89
  store i32 0, i32* %9, align 4
  br label %109

109:                                              ; preds = %141, %108
  %110 = load i32, i32* %9, align 4
  %111 = load i32, i32* %7, align 4
  %112 = icmp slt i32 %110, %111
  br i1 %112, label %113, label %144

113:                                              ; preds = %109
  store i32 0, i32* %10, align 4
  br label %114

114:                                              ; preds = %137, %113
  %115 = load i32, i32* %10, align 4
  %116 = load i32, i32* %8, align 4
  %117 = icmp slt i32 %115, %116
  br i1 %117, label %118, label %140

118:                                              ; preds = %114
  %119 = load %struct.complex_t**, %struct.complex_t*** %13, align 8
  %120 = load i32, i32* %10, align 4
  %121 = sext i32 %120 to i64
  %122 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %119, i64 %121
  %123 = load %struct.complex_t*, %struct.complex_t** %122, align 8
  %124 = load i32, i32* %9, align 4
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %123, i64 %125
  %127 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %128 = load i32, i32* %9, align 4
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %127, i64 %129
  %131 = load %struct.complex_t*, %struct.complex_t** %130, align 8
  %132 = load i32, i32* %10, align 4
  %133 = sext i32 %132 to i64
  %134 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %131, i64 %133
  %135 = bitcast %struct.complex_t* %126 to i8*
  %136 = bitcast %struct.complex_t* %134 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %135, i8* align 8 %136, i64 16, i1 false)
  br label %137

137:                                              ; preds = %118
  %138 = load i32, i32* %10, align 4
  %139 = add nsw i32 %138, 1
  store i32 %139, i32* %10, align 4
  br label %114, !llvm.loop !13

140:                                              ; preds = %114
  br label %141

141:                                              ; preds = %140
  %142 = load i32, i32* %9, align 4
  %143 = add nsw i32 %142, 1
  store i32 %143, i32* %9, align 4
  br label %109, !llvm.loop !14

144:                                              ; preds = %109
  store i32 0, i32* %10, align 4
  br label %145

145:                                              ; preds = %161, %144
  %146 = load i32, i32* %10, align 4
  %147 = load i32, i32* %8, align 4
  %148 = icmp slt i32 %146, %147
  br i1 %148, label %149, label %164

149:                                              ; preds = %145
  %150 = load %struct.complex_t**, %struct.complex_t*** %13, align 8
  %151 = load i32, i32* %10, align 4
  %152 = sext i32 %151 to i64
  %153 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %150, i64 %152
  %154 = load %struct.complex_t*, %struct.complex_t** %153, align 8
  %155 = load i32, i32* %7, align 4
  %156 = call %struct.complex_t* @DFT_naive(%struct.complex_t* noundef %154, i32 noundef %155)
  %157 = load %struct.complex_t**, %struct.complex_t*** %13, align 8
  %158 = load i32, i32* %10, align 4
  %159 = sext i32 %158 to i64
  %160 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %157, i64 %159
  store %struct.complex_t* %156, %struct.complex_t** %160, align 8
  br label %161

161:                                              ; preds = %149
  %162 = load i32, i32* %10, align 4
  %163 = add nsw i32 %162, 1
  store i32 %163, i32* %10, align 4
  br label %145, !llvm.loop !15

164:                                              ; preds = %145
  %165 = load i32, i32* %6, align 4
  %166 = sext i32 %165 to i64
  %167 = mul i64 16, %166
  %168 = call noalias i8* @malloc(i64 noundef %167) #5
  %169 = bitcast i8* %168 to %struct.complex_t*
  store %struct.complex_t* %169, %struct.complex_t** %14, align 8
  store i32 0, i32* %9, align 4
  br label %170

170:                                              ; preds = %207, %164
  %171 = load i32, i32* %9, align 4
  %172 = load i32, i32* %7, align 4
  %173 = icmp slt i32 %171, %172
  br i1 %173, label %174, label %210

174:                                              ; preds = %170
  store i32 0, i32* %10, align 4
  br label %175

175:                                              ; preds = %203, %174
  %176 = load i32, i32* %10, align 4
  %177 = load i32, i32* %8, align 4
  %178 = icmp slt i32 %176, %177
  br i1 %178, label %179, label %206

179:                                              ; preds = %175
  %180 = load i32, i32* %7, align 4
  %181 = load i32, i32* %10, align 4
  %182 = mul nsw i32 %180, %181
  %183 = load i32, i32* %8, align 4
  %184 = load i32, i32* %9, align 4
  %185 = mul nsw i32 %183, %184
  %186 = add nsw i32 %182, %185
  store i32 %186, i32* %11, align 4
  %187 = load %struct.complex_t*, %struct.complex_t** %14, align 8
  %188 = load i32, i32* %11, align 4
  %189 = load i32, i32* %6, align 4
  %190 = srem i32 %188, %189
  %191 = sext i32 %190 to i64
  %192 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %187, i64 %191
  %193 = load %struct.complex_t**, %struct.complex_t*** %13, align 8
  %194 = load i32, i32* %10, align 4
  %195 = sext i32 %194 to i64
  %196 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %193, i64 %195
  %197 = load %struct.complex_t*, %struct.complex_t** %196, align 8
  %198 = load i32, i32* %9, align 4
  %199 = sext i32 %198 to i64
  %200 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %197, i64 %199
  %201 = bitcast %struct.complex_t* %192 to i8*
  %202 = bitcast %struct.complex_t* %200 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %201, i8* align 8 %202, i64 16, i1 false)
  br label %203

203:                                              ; preds = %179
  %204 = load i32, i32* %10, align 4
  %205 = add nsw i32 %204, 1
  store i32 %205, i32* %10, align 4
  br label %175, !llvm.loop !16

206:                                              ; preds = %175
  br label %207

207:                                              ; preds = %206
  %208 = load i32, i32* %9, align 4
  %209 = add nsw i32 %208, 1
  store i32 %209, i32* %9, align 4
  br label %170, !llvm.loop !17

210:                                              ; preds = %170
  store i32 0, i32* %9, align 4
  br label %211

211:                                              ; preds = %222, %210
  %212 = load i32, i32* %9, align 4
  %213 = load i32, i32* %7, align 4
  %214 = icmp slt i32 %212, %213
  br i1 %214, label %215, label %225

215:                                              ; preds = %211
  %216 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %217 = load i32, i32* %9, align 4
  %218 = sext i32 %217 to i64
  %219 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %216, i64 %218
  %220 = load %struct.complex_t*, %struct.complex_t** %219, align 8
  %221 = bitcast %struct.complex_t* %220 to i8*
  call void @free(i8* noundef %221) #5
  br label %222

222:                                              ; preds = %215
  %223 = load i32, i32* %9, align 4
  %224 = add nsw i32 %223, 1
  store i32 %224, i32* %9, align 4
  br label %211, !llvm.loop !18

225:                                              ; preds = %211
  store i32 0, i32* %10, align 4
  br label %226

226:                                              ; preds = %237, %225
  %227 = load i32, i32* %10, align 4
  %228 = load i32, i32* %8, align 4
  %229 = icmp slt i32 %227, %228
  br i1 %229, label %230, label %240

230:                                              ; preds = %226
  %231 = load %struct.complex_t**, %struct.complex_t*** %13, align 8
  %232 = load i32, i32* %10, align 4
  %233 = sext i32 %232 to i64
  %234 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %231, i64 %233
  %235 = load %struct.complex_t*, %struct.complex_t** %234, align 8
  %236 = bitcast %struct.complex_t* %235 to i8*
  call void @free(i8* noundef %236) #5
  br label %237

237:                                              ; preds = %230
  %238 = load i32, i32* %10, align 4
  %239 = add nsw i32 %238, 1
  store i32 %239, i32* %10, align 4
  br label %226, !llvm.loop !19

240:                                              ; preds = %226
  %241 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %242 = bitcast %struct.complex_t** %241 to i8*
  call void @free(i8* noundef %242) #5
  %243 = load %struct.complex_t**, %struct.complex_t*** %13, align 8
  %244 = bitcast %struct.complex_t** %243 to i8*
  call void @free(i8* noundef %244) #5
  %245 = load %struct.complex_t*, %struct.complex_t** %14, align 8
  ret %struct.complex_t* %245
}

; Function Attrs: nounwind
declare void @free(i8* noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.complex_t* @FFT_CooleyTukey(%struct.complex_t* noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca %struct.complex_t*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.complex_t**, align 8
  %12 = alloca %struct.complex_t**, align 8
  %13 = alloca %struct.complex_t, align 8
  %14 = alloca %struct.complex_t, align 8
  %15 = alloca %struct.complex_t*, align 8
  store %struct.complex_t* %0, %struct.complex_t** %5, align 8
  store i32 %1, i32* %6, align 4
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %16 = load i32, i32* %7, align 4
  %17 = sext i32 %16 to i64
  %18 = mul i64 8, %17
  %19 = call noalias i8* @malloc(i64 noundef %18) #5
  %20 = bitcast i8* %19 to %struct.complex_t**
  store %struct.complex_t** %20, %struct.complex_t*** %11, align 8
  store i32 0, i32* %9, align 4
  br label %21

21:                                               ; preds = %35, %4
  %22 = load i32, i32* %9, align 4
  %23 = load i32, i32* %7, align 4
  %24 = icmp slt i32 %22, %23
  br i1 %24, label %25, label %38

25:                                               ; preds = %21
  %26 = load i32, i32* %8, align 4
  %27 = sext i32 %26 to i64
  %28 = mul i64 16, %27
  %29 = call noalias i8* @malloc(i64 noundef %28) #5
  %30 = bitcast i8* %29 to %struct.complex_t*
  %31 = load %struct.complex_t**, %struct.complex_t*** %11, align 8
  %32 = load i32, i32* %9, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %31, i64 %33
  store %struct.complex_t* %30, %struct.complex_t** %34, align 8
  br label %35

35:                                               ; preds = %25
  %36 = load i32, i32* %9, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %9, align 4
  br label %21, !llvm.loop !20

38:                                               ; preds = %21
  %39 = load i32, i32* %8, align 4
  %40 = sext i32 %39 to i64
  %41 = mul i64 8, %40
  %42 = call noalias i8* @malloc(i64 noundef %41) #5
  %43 = bitcast i8* %42 to %struct.complex_t**
  store %struct.complex_t** %43, %struct.complex_t*** %12, align 8
  store i32 0, i32* %10, align 4
  br label %44

44:                                               ; preds = %58, %38
  %45 = load i32, i32* %10, align 4
  %46 = load i32, i32* %8, align 4
  %47 = icmp slt i32 %45, %46
  br i1 %47, label %48, label %61

48:                                               ; preds = %44
  %49 = load i32, i32* %7, align 4
  %50 = sext i32 %49 to i64
  %51 = mul i64 16, %50
  %52 = call noalias i8* @malloc(i64 noundef %51) #5
  %53 = bitcast i8* %52 to %struct.complex_t*
  %54 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %55 = load i32, i32* %10, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %54, i64 %56
  store %struct.complex_t* %53, %struct.complex_t** %57, align 8
  br label %58

58:                                               ; preds = %48
  %59 = load i32, i32* %10, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, i32* %10, align 4
  br label %44, !llvm.loop !21

61:                                               ; preds = %44
  store i32 0, i32* %9, align 4
  br label %62

62:                                               ; preds = %94, %61
  %63 = load i32, i32* %9, align 4
  %64 = load i32, i32* %7, align 4
  %65 = icmp slt i32 %63, %64
  br i1 %65, label %66, label %97

66:                                               ; preds = %62
  store i32 0, i32* %10, align 4
  br label %67

67:                                               ; preds = %90, %66
  %68 = load i32, i32* %10, align 4
  %69 = load i32, i32* %8, align 4
  %70 = icmp slt i32 %68, %69
  br i1 %70, label %71, label %93

71:                                               ; preds = %67
  %72 = load %struct.complex_t**, %struct.complex_t*** %11, align 8
  %73 = load i32, i32* %9, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %72, i64 %74
  %76 = load %struct.complex_t*, %struct.complex_t** %75, align 8
  %77 = load i32, i32* %10, align 4
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %76, i64 %78
  %80 = load %struct.complex_t*, %struct.complex_t** %5, align 8
  %81 = load i32, i32* %7, align 4
  %82 = load i32, i32* %10, align 4
  %83 = mul nsw i32 %81, %82
  %84 = load i32, i32* %9, align 4
  %85 = add nsw i32 %83, %84
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %80, i64 %86
  %88 = bitcast %struct.complex_t* %79 to i8*
  %89 = bitcast %struct.complex_t* %87 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %88, i8* align 8 %89, i64 16, i1 false)
  br label %90

90:                                               ; preds = %71
  %91 = load i32, i32* %10, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, i32* %10, align 4
  br label %67, !llvm.loop !22

93:                                               ; preds = %67
  br label %94

94:                                               ; preds = %93
  %95 = load i32, i32* %9, align 4
  %96 = add nsw i32 %95, 1
  store i32 %96, i32* %9, align 4
  br label %62, !llvm.loop !23

97:                                               ; preds = %62
  store i32 0, i32* %9, align 4
  br label %98

98:                                               ; preds = %114, %97
  %99 = load i32, i32* %9, align 4
  %100 = load i32, i32* %7, align 4
  %101 = icmp slt i32 %99, %100
  br i1 %101, label %102, label %117

102:                                              ; preds = %98
  %103 = load %struct.complex_t**, %struct.complex_t*** %11, align 8
  %104 = load i32, i32* %9, align 4
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %103, i64 %105
  %107 = load %struct.complex_t*, %struct.complex_t** %106, align 8
  %108 = load i32, i32* %8, align 4
  %109 = call %struct.complex_t* @DFT_naive(%struct.complex_t* noundef %107, i32 noundef %108)
  %110 = load %struct.complex_t**, %struct.complex_t*** %11, align 8
  %111 = load i32, i32* %9, align 4
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %110, i64 %112
  store %struct.complex_t* %109, %struct.complex_t** %113, align 8
  br label %114

114:                                              ; preds = %102
  %115 = load i32, i32* %9, align 4
  %116 = add nsw i32 %115, 1
  store i32 %116, i32* %9, align 4
  br label %98, !llvm.loop !24

117:                                              ; preds = %98
  store i32 0, i32* %9, align 4
  br label %118

118:                                              ; preds = %181, %117
  %119 = load i32, i32* %9, align 4
  %120 = load i32, i32* %7, align 4
  %121 = icmp slt i32 %119, %120
  br i1 %121, label %122, label %184

122:                                              ; preds = %118
  store i32 0, i32* %10, align 4
  br label %123

123:                                              ; preds = %177, %122
  %124 = load i32, i32* %10, align 4
  %125 = load i32, i32* %8, align 4
  %126 = icmp slt i32 %124, %125
  br i1 %126, label %127, label %180

127:                                              ; preds = %123
  %128 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %129 = load i32, i32* %10, align 4
  %130 = sext i32 %129 to i64
  %131 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %128, i64 %130
  %132 = load %struct.complex_t*, %struct.complex_t** %131, align 8
  %133 = load i32, i32* %9, align 4
  %134 = sext i32 %133 to i64
  %135 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %132, i64 %134
  %136 = load i32, i32* %9, align 4
  %137 = sitofp i32 %136 to double
  %138 = fmul double 0xC01921FB54442D18, %137
  %139 = load i32, i32* %10, align 4
  %140 = sitofp i32 %139 to double
  %141 = fmul double %138, %140
  %142 = load i32, i32* %6, align 4
  %143 = sitofp i32 %142 to double
  %144 = fdiv double %141, %143
  %145 = call { double, double } @conv_from_polar(double noundef 1.000000e+00, double noundef %144)
  %146 = bitcast %struct.complex_t* %14 to { double, double }*
  %147 = getelementptr inbounds { double, double }, { double, double }* %146, i32 0, i32 0
  %148 = extractvalue { double, double } %145, 0
  store double %148, double* %147, align 8
  %149 = getelementptr inbounds { double, double }, { double, double }* %146, i32 0, i32 1
  %150 = extractvalue { double, double } %145, 1
  store double %150, double* %149, align 8
  %151 = load %struct.complex_t**, %struct.complex_t*** %11, align 8
  %152 = load i32, i32* %9, align 4
  %153 = sext i32 %152 to i64
  %154 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %151, i64 %153
  %155 = load %struct.complex_t*, %struct.complex_t** %154, align 8
  %156 = load i32, i32* %10, align 4
  %157 = sext i32 %156 to i64
  %158 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %155, i64 %157
  %159 = bitcast %struct.complex_t* %14 to { double, double }*
  %160 = getelementptr inbounds { double, double }, { double, double }* %159, i32 0, i32 0
  %161 = load double, double* %160, align 8
  %162 = getelementptr inbounds { double, double }, { double, double }* %159, i32 0, i32 1
  %163 = load double, double* %162, align 8
  %164 = bitcast %struct.complex_t* %158 to { double, double }*
  %165 = getelementptr inbounds { double, double }, { double, double }* %164, i32 0, i32 0
  %166 = load double, double* %165, align 8
  %167 = getelementptr inbounds { double, double }, { double, double }* %164, i32 0, i32 1
  %168 = load double, double* %167, align 8
  %169 = call { double, double } @multiply(double %161, double %163, double %166, double %168)
  %170 = bitcast %struct.complex_t* %13 to { double, double }*
  %171 = getelementptr inbounds { double, double }, { double, double }* %170, i32 0, i32 0
  %172 = extractvalue { double, double } %169, 0
  store double %172, double* %171, align 8
  %173 = getelementptr inbounds { double, double }, { double, double }* %170, i32 0, i32 1
  %174 = extractvalue { double, double } %169, 1
  store double %174, double* %173, align 8
  %175 = bitcast %struct.complex_t* %135 to i8*
  %176 = bitcast %struct.complex_t* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %175, i8* align 8 %176, i64 16, i1 false)
  br label %177

177:                                              ; preds = %127
  %178 = load i32, i32* %10, align 4
  %179 = add nsw i32 %178, 1
  store i32 %179, i32* %10, align 4
  br label %123, !llvm.loop !25

180:                                              ; preds = %123
  br label %181

181:                                              ; preds = %180
  %182 = load i32, i32* %9, align 4
  %183 = add nsw i32 %182, 1
  store i32 %183, i32* %9, align 4
  br label %118, !llvm.loop !26

184:                                              ; preds = %118
  store i32 0, i32* %10, align 4
  br label %185

185:                                              ; preds = %201, %184
  %186 = load i32, i32* %10, align 4
  %187 = load i32, i32* %8, align 4
  %188 = icmp slt i32 %186, %187
  br i1 %188, label %189, label %204

189:                                              ; preds = %185
  %190 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %191 = load i32, i32* %10, align 4
  %192 = sext i32 %191 to i64
  %193 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %190, i64 %192
  %194 = load %struct.complex_t*, %struct.complex_t** %193, align 8
  %195 = load i32, i32* %7, align 4
  %196 = call %struct.complex_t* @DFT_naive(%struct.complex_t* noundef %194, i32 noundef %195)
  %197 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %198 = load i32, i32* %10, align 4
  %199 = sext i32 %198 to i64
  %200 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %197, i64 %199
  store %struct.complex_t* %196, %struct.complex_t** %200, align 8
  br label %201

201:                                              ; preds = %189
  %202 = load i32, i32* %10, align 4
  %203 = add nsw i32 %202, 1
  store i32 %203, i32* %10, align 4
  br label %185, !llvm.loop !27

204:                                              ; preds = %185
  %205 = load i32, i32* %6, align 4
  %206 = sext i32 %205 to i64
  %207 = mul i64 16, %206
  %208 = call noalias i8* @malloc(i64 noundef %207) #5
  %209 = bitcast i8* %208 to %struct.complex_t*
  store %struct.complex_t* %209, %struct.complex_t** %15, align 8
  store i32 0, i32* %9, align 4
  br label %210

210:                                              ; preds = %242, %204
  %211 = load i32, i32* %9, align 4
  %212 = load i32, i32* %7, align 4
  %213 = icmp slt i32 %211, %212
  br i1 %213, label %214, label %245

214:                                              ; preds = %210
  store i32 0, i32* %10, align 4
  br label %215

215:                                              ; preds = %238, %214
  %216 = load i32, i32* %10, align 4
  %217 = load i32, i32* %8, align 4
  %218 = icmp slt i32 %216, %217
  br i1 %218, label %219, label %241

219:                                              ; preds = %215
  %220 = load %struct.complex_t*, %struct.complex_t** %15, align 8
  %221 = load i32, i32* %8, align 4
  %222 = load i32, i32* %9, align 4
  %223 = mul nsw i32 %221, %222
  %224 = load i32, i32* %10, align 4
  %225 = add nsw i32 %223, %224
  %226 = sext i32 %225 to i64
  %227 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %220, i64 %226
  %228 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %229 = load i32, i32* %10, align 4
  %230 = sext i32 %229 to i64
  %231 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %228, i64 %230
  %232 = load %struct.complex_t*, %struct.complex_t** %231, align 8
  %233 = load i32, i32* %9, align 4
  %234 = sext i32 %233 to i64
  %235 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %232, i64 %234
  %236 = bitcast %struct.complex_t* %227 to i8*
  %237 = bitcast %struct.complex_t* %235 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %236, i8* align 8 %237, i64 16, i1 false)
  br label %238

238:                                              ; preds = %219
  %239 = load i32, i32* %10, align 4
  %240 = add nsw i32 %239, 1
  store i32 %240, i32* %10, align 4
  br label %215, !llvm.loop !28

241:                                              ; preds = %215
  br label %242

242:                                              ; preds = %241
  %243 = load i32, i32* %9, align 4
  %244 = add nsw i32 %243, 1
  store i32 %244, i32* %9, align 4
  br label %210, !llvm.loop !29

245:                                              ; preds = %210
  store i32 0, i32* %9, align 4
  br label %246

246:                                              ; preds = %257, %245
  %247 = load i32, i32* %9, align 4
  %248 = load i32, i32* %7, align 4
  %249 = icmp slt i32 %247, %248
  br i1 %249, label %250, label %260

250:                                              ; preds = %246
  %251 = load %struct.complex_t**, %struct.complex_t*** %11, align 8
  %252 = load i32, i32* %9, align 4
  %253 = sext i32 %252 to i64
  %254 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %251, i64 %253
  %255 = load %struct.complex_t*, %struct.complex_t** %254, align 8
  %256 = bitcast %struct.complex_t* %255 to i8*
  call void @free(i8* noundef %256) #5
  br label %257

257:                                              ; preds = %250
  %258 = load i32, i32* %9, align 4
  %259 = add nsw i32 %258, 1
  store i32 %259, i32* %9, align 4
  br label %246, !llvm.loop !30

260:                                              ; preds = %246
  store i32 0, i32* %10, align 4
  br label %261

261:                                              ; preds = %272, %260
  %262 = load i32, i32* %10, align 4
  %263 = load i32, i32* %8, align 4
  %264 = icmp slt i32 %262, %263
  br i1 %264, label %265, label %275

265:                                              ; preds = %261
  %266 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %267 = load i32, i32* %10, align 4
  %268 = sext i32 %267 to i64
  %269 = getelementptr inbounds %struct.complex_t*, %struct.complex_t** %266, i64 %268
  %270 = load %struct.complex_t*, %struct.complex_t** %269, align 8
  %271 = bitcast %struct.complex_t* %270 to i8*
  call void @free(i8* noundef %271) #5
  br label %272

272:                                              ; preds = %265
  %273 = load i32, i32* %10, align 4
  %274 = add nsw i32 %273, 1
  store i32 %274, i32* %10, align 4
  br label %261, !llvm.loop !31

275:                                              ; preds = %261
  %276 = load %struct.complex_t**, %struct.complex_t*** %11, align 8
  %277 = bitcast %struct.complex_t** %276 to i8*
  call void @free(i8* noundef %277) #5
  %278 = load %struct.complex_t**, %struct.complex_t*** %12, align 8
  %279 = bitcast %struct.complex_t** %278 to i8*
  call void @free(i8* noundef %279) #5
  %280 = load %struct.complex_t*, %struct.complex_t** %15, align 8
  ret %struct.complex_t* %280
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.complex_t*, align 8
  %3 = alloca %struct.complex_t*, align 8
  %4 = alloca %struct.complex_t*, align 8
  %5 = alloca %struct.complex_t*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %8 = call noalias i8* @malloc(i64 noundef 480) #5
  %9 = bitcast i8* %8 to %struct.complex_t*
  store %struct.complex_t* %9, %struct.complex_t** %2, align 8
  %10 = call noalias i8* @malloc(i64 noundef 480) #5
  %11 = bitcast i8* %10 to %struct.complex_t*
  store %struct.complex_t* %11, %struct.complex_t** %3, align 8
  store i32 0, i32* %6, align 4
  br label %12

12:                                               ; preds = %40, %0
  %13 = load i32, i32* %6, align 4
  %14 = icmp slt i32 %13, 30
  br i1 %14, label %15, label %43

15:                                               ; preds = %12
  %16 = load i32, i32* %6, align 4
  %17 = sitofp i32 %16 to double
  %18 = load %struct.complex_t*, %struct.complex_t** %2, align 8
  %19 = load i32, i32* %6, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %18, i64 %20
  %22 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %21, i32 0, i32 0
  store double %17, double* %22, align 8
  %23 = load %struct.complex_t*, %struct.complex_t** %2, align 8
  %24 = load i32, i32* %6, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %23, i64 %25
  %27 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %26, i32 0, i32 1
  store double 0.000000e+00, double* %27, align 8
  %28 = load i32, i32* %6, align 4
  %29 = sitofp i32 %28 to double
  %30 = load %struct.complex_t*, %struct.complex_t** %3, align 8
  %31 = load i32, i32* %6, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %30, i64 %32
  %34 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %33, i32 0, i32 0
  store double %29, double* %34, align 8
  %35 = load %struct.complex_t*, %struct.complex_t** %3, align 8
  %36 = load i32, i32* %6, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %35, i64 %37
  %39 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %38, i32 0, i32 1
  store double 0.000000e+00, double* %39, align 8
  br label %40

40:                                               ; preds = %15
  %41 = load i32, i32* %6, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %6, align 4
  br label %12, !llvm.loop !32

43:                                               ; preds = %12
  %44 = load %struct.complex_t*, %struct.complex_t** %2, align 8
  %45 = call %struct.complex_t* @FFT_CooleyTukey(%struct.complex_t* noundef %44, i32 noundef 30, i32 noundef 6, i32 noundef 5)
  store %struct.complex_t* %45, %struct.complex_t** %4, align 8
  %46 = load %struct.complex_t*, %struct.complex_t** %3, align 8
  %47 = call %struct.complex_t* @FFT_GoodThomas(%struct.complex_t* noundef %46, i32 noundef 30, i32 noundef 6, i32 noundef 5)
  store %struct.complex_t* %47, %struct.complex_t** %5, align 8
  %48 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([53 x i8], [53 x i8]* @.str, i64 0, i64 0))
  store i32 0, i32* %7, align 4
  br label %49

49:                                               ; preds = %79, %43
  %50 = load i32, i32* %7, align 4
  %51 = icmp slt i32 %50, 30
  br i1 %51, label %52, label %82

52:                                               ; preds = %49
  %53 = load i32, i32* %7, align 4
  %54 = load %struct.complex_t*, %struct.complex_t** %4, align 8
  %55 = load i32, i32* %7, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %54, i64 %56
  %58 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %57, i32 0, i32 0
  %59 = load double, double* %58, align 8
  %60 = load %struct.complex_t*, %struct.complex_t** %4, align 8
  %61 = load i32, i32* %7, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %60, i64 %62
  %64 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %63, i32 0, i32 1
  %65 = load double, double* %64, align 8
  %66 = load %struct.complex_t*, %struct.complex_t** %5, align 8
  %67 = load i32, i32* %7, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %66, i64 %68
  %70 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %69, i32 0, i32 0
  %71 = load double, double* %70, align 8
  %72 = load %struct.complex_t*, %struct.complex_t** %5, align 8
  %73 = load i32, i32* %7, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %72, i64 %74
  %76 = getelementptr inbounds %struct.complex_t, %struct.complex_t* %75, i32 0, i32 1
  %77 = load double, double* %76, align 8
  %78 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i64 0, i64 0), i32 noundef %53, double noundef %59, double noundef %65, double noundef %71, double noundef %77)
  br label %79

79:                                               ; preds = %52
  %80 = load i32, i32* %7, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, i32* %7, align 4
  br label %49, !llvm.loop !33

82:                                               ; preds = %49
  ret i32 0
}

declare i32 @printf(i8* noundef, ...) #4

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #3 = { argmemonly nofree nounwind willreturn }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }

!llvm.ident = !{!0, !0, !0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
!24 = distinct !{!24, !7}
!25 = distinct !{!25, !7}
!26 = distinct !{!26, !7}
!27 = distinct !{!27, !7}
!28 = distinct !{!28, !7}
!29 = distinct !{!29, !7}
!30 = distinct !{!30, !7}
!31 = distinct !{!31, !7}
!32 = distinct !{!32, !7}
!33 = distinct !{!33, !7}
