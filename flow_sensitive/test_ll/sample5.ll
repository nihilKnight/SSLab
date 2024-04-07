; ModuleID = 'sample5.c'
source_filename = "sample5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._xlsWorkBook = type { i8 }
%struct._bof = type { i16, i16 }
%struct.anon = type { i16, i8, i8 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @xls_isRecordTooSmall(%struct._xlsWorkBook* noundef %0, %struct._bof* noundef %1, i8* noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca %struct._xlsWorkBook*, align 8
  %6 = alloca %struct._bof*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct.anon*, align 8
  store %struct._xlsWorkBook* %0, %struct._xlsWorkBook** %5, align 8
  store %struct._bof* %1, %struct._bof** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load %struct._bof*, %struct._bof** %6, align 8
  %10 = getelementptr inbounds %struct._bof, %struct._bof* %9, i32 0, i32 0
  %11 = load i16, i16* %10, align 2
  %12 = zext i16 %11 to i32
  switch i32 %12, label %130 [
    i32 2057, label %13
    i32 66, label %20
    i32 61, label %27
    i32 252, label %34
    i32 133, label %41
    i32 224, label %48
    i32 49, label %67
    i32 50, label %67
    i32 1054, label %74
    i32 659, label %81
    i32 34, label %123
  ]

13:                                               ; preds = %3
  %14 = load %struct._bof*, %struct._bof** %6, align 8
  %15 = getelementptr inbounds %struct._bof, %struct._bof* %14, i32 0, i32 1
  %16 = load i16, i16* %15, align 2
  %17 = zext i16 %16 to i64
  %18 = icmp ult i64 %17, 4
  %19 = zext i1 %18 to i32
  store i32 %19, i32* %4, align 4
  br label %132

20:                                               ; preds = %3
  %21 = load %struct._bof*, %struct._bof** %6, align 8
  %22 = getelementptr inbounds %struct._bof, %struct._bof* %21, i32 0, i32 1
  %23 = load i16, i16* %22, align 2
  %24 = zext i16 %23 to i64
  %25 = icmp ult i64 %24, 2
  %26 = zext i1 %25 to i32
  store i32 %26, i32* %4, align 4
  br label %132

27:                                               ; preds = %3
  %28 = load %struct._bof*, %struct._bof** %6, align 8
  %29 = getelementptr inbounds %struct._bof, %struct._bof* %28, i32 0, i32 1
  %30 = load i16, i16* %29, align 2
  %31 = zext i16 %30 to i64
  %32 = icmp ult i64 %31, 0
  %33 = zext i1 %32 to i32
  store i32 %33, i32* %4, align 4
  br label %132

34:                                               ; preds = %3
  %35 = load %struct._bof*, %struct._bof** %6, align 8
  %36 = getelementptr inbounds %struct._bof, %struct._bof* %35, i32 0, i32 1
  %37 = load i16, i16* %36, align 2
  %38 = zext i16 %37 to i64
  %39 = icmp ult i64 %38, 0
  %40 = zext i1 %39 to i32
  store i32 %40, i32* %4, align 4
  br label %132

41:                                               ; preds = %3
  %42 = load %struct._bof*, %struct._bof** %6, align 8
  %43 = getelementptr inbounds %struct._bof, %struct._bof* %42, i32 0, i32 1
  %44 = load i16, i16* %43, align 2
  %45 = zext i16 %44 to i64
  %46 = icmp ult i64 %45, 0
  %47 = zext i1 %46 to i32
  store i32 %47, i32* %4, align 4
  br label %132

48:                                               ; preds = %3
  %49 = load %struct._xlsWorkBook*, %struct._xlsWorkBook** %5, align 8
  %50 = getelementptr inbounds %struct._xlsWorkBook, %struct._xlsWorkBook* %49, i32 0, i32 0
  %51 = load i8, i8* %50, align 1
  %52 = icmp ne i8 %51, 0
  br i1 %52, label %53, label %60

53:                                               ; preds = %48
  %54 = load %struct._bof*, %struct._bof** %6, align 8
  %55 = getelementptr inbounds %struct._bof, %struct._bof* %54, i32 0, i32 1
  %56 = load i16, i16* %55, align 2
  %57 = zext i16 %56 to i64
  %58 = icmp ult i64 %57, 0
  %59 = zext i1 %58 to i32
  store i32 %59, i32* %4, align 4
  br label %132

60:                                               ; preds = %48
  %61 = load %struct._bof*, %struct._bof** %6, align 8
  %62 = getelementptr inbounds %struct._bof, %struct._bof* %61, i32 0, i32 1
  %63 = load i16, i16* %62, align 2
  %64 = zext i16 %63 to i64
  %65 = icmp ult i64 %64, 0
  %66 = zext i1 %65 to i32
  store i32 %66, i32* %4, align 4
  br label %132

67:                                               ; preds = %3, %3
  %68 = load %struct._bof*, %struct._bof** %6, align 8
  %69 = getelementptr inbounds %struct._bof, %struct._bof* %68, i32 0, i32 1
  %70 = load i16, i16* %69, align 2
  %71 = zext i16 %70 to i64
  %72 = icmp ult i64 %71, 0
  %73 = zext i1 %72 to i32
  store i32 %73, i32* %4, align 4
  br label %132

74:                                               ; preds = %3
  %75 = load %struct._bof*, %struct._bof** %6, align 8
  %76 = getelementptr inbounds %struct._bof, %struct._bof* %75, i32 0, i32 1
  %77 = load i16, i16* %76, align 2
  %78 = zext i16 %77 to i64
  %79 = icmp ult i64 %78, 0
  %80 = zext i1 %79 to i32
  store i32 %80, i32* %4, align 4
  br label %132

81:                                               ; preds = %3
  %82 = load i8*, i8** %7, align 8
  %83 = bitcast i8* %82 to %struct.anon*
  store %struct.anon* %83, %struct.anon** %8, align 8
  %84 = load %struct._bof*, %struct._bof** %6, align 8
  %85 = getelementptr inbounds %struct._bof, %struct._bof* %84, i32 0, i32 1
  %86 = load i16, i16* %85, align 2
  %87 = zext i16 %86 to i32
  %88 = icmp slt i32 %87, 2
  br i1 %88, label %89, label %90

89:                                               ; preds = %81
  store i32 1, i32* %4, align 4
  br label %132

90:                                               ; preds = %81
  %91 = load %struct.anon*, %struct.anon** %8, align 8
  %92 = getelementptr inbounds %struct.anon, %struct.anon* %91, i32 0, i32 0
  %93 = load i16, i16* %92, align 2
  %94 = zext i16 %93 to i32
  %95 = and i32 %94, 32768
  %96 = icmp ne i32 %95, 0
  br i1 %96, label %97, label %104

97:                                               ; preds = %90
  %98 = load %struct._bof*, %struct._bof** %6, align 8
  %99 = getelementptr inbounds %struct._bof, %struct._bof* %98, i32 0, i32 1
  %100 = load i16, i16* %99, align 2
  %101 = zext i16 %100 to i32
  %102 = icmp slt i32 %101, 4
  %103 = zext i1 %102 to i32
  store i32 %103, i32* %4, align 4
  br label %132

104:                                              ; preds = %90
  %105 = load %struct._bof*, %struct._bof** %6, align 8
  %106 = getelementptr inbounds %struct._bof, %struct._bof* %105, i32 0, i32 1
  %107 = load i16, i16* %106, align 2
  %108 = zext i16 %107 to i32
  %109 = icmp slt i32 %108, 3
  br i1 %109, label %110, label %111

110:                                              ; preds = %104
  store i32 1, i32* %4, align 4
  br label %132

111:                                              ; preds = %104
  %112 = load %struct._bof*, %struct._bof** %6, align 8
  %113 = getelementptr inbounds %struct._bof, %struct._bof* %112, i32 0, i32 1
  %114 = load i16, i16* %113, align 2
  %115 = zext i16 %114 to i32
  %116 = load %struct.anon*, %struct.anon** %8, align 8
  %117 = getelementptr inbounds %struct.anon, %struct.anon* %116, i32 0, i32 1
  %118 = load i8, i8* %117, align 2
  %119 = zext i8 %118 to i32
  %120 = add nsw i32 3, %119
  %121 = icmp slt i32 %115, %120
  %122 = zext i1 %121 to i32
  store i32 %122, i32* %4, align 4
  br label %132

123:                                              ; preds = %3
  %124 = load %struct._bof*, %struct._bof** %6, align 8
  %125 = getelementptr inbounds %struct._bof, %struct._bof* %124, i32 0, i32 1
  %126 = load i16, i16* %125, align 2
  %127 = zext i16 %126 to i64
  %128 = icmp ult i64 %127, 1
  %129 = zext i1 %128 to i32
  store i32 %129, i32* %4, align 4
  br label %132

130:                                              ; preds = %3
  br label %131

131:                                              ; preds = %130
  store i32 0, i32* %4, align 4
  br label %132

132:                                              ; preds = %131, %123, %111, %110, %97, %89, %74, %67, %60, %53, %41, %34, %27, %20, %13
  %133 = load i32, i32* %4, align 4
  ret i32 %133
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
