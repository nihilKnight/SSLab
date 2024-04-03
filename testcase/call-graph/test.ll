; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.complex_t = type { double, double }

@.str = private unnamed_addr constant [53 x i8] c"Index \09 Cooley-Tukey Output \09 \09 Good-Thomas Output \0A\00", align 1
@.str.1 = private unnamed_addr constant [28 x i8] c"%d: \09 %f + %fi \09 %f + %fi \0A\00", align 1

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
  %8 = call noalias i8* @malloc(i64 noundef 480) #3
  %9 = bitcast i8* %8 to %struct.complex_t*
  store %struct.complex_t* %9, %struct.complex_t** %2, align 8
  %10 = call noalias i8* @malloc(i64 noundef 480) #3
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
  br label %12, !llvm.loop !6

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
  br label %49, !llvm.loop !8

82:                                               ; preds = %49
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64 noundef) #1

declare %struct.complex_t* @FFT_CooleyTukey(%struct.complex_t* noundef, i32 noundef, i32 noundef, i32 noundef) #2

declare %struct.complex_t* @FFT_GoodThomas(%struct.complex_t* noundef, i32 noundef, i32 noundef, i32 noundef) #2

declare i32 @printf(i8* noundef, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
