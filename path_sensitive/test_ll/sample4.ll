; ModuleID = 'sample4.c'
source_filename = "sample4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.xlsWorkBook = type { i32 }
%struct.BOF = type { i16, i16 }
%struct.LABEL = type { [3 x i16] }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @xls_isCellTooSmall(%struct.xlsWorkBook* noundef %0, %struct.BOF* noundef %1, i8* noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.xlsWorkBook*, align 8
  %6 = alloca %struct.BOF*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i64, align 8
  store %struct.xlsWorkBook* %0, %struct.xlsWorkBook** %5, align 8
  store %struct.BOF* %1, %struct.BOF** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load %struct.BOF*, %struct.BOF** %6, align 8
  %10 = getelementptr inbounds %struct.BOF, %struct.BOF* %9, i32 0, i32 1
  %11 = load i16, i16* %10, align 2
  %12 = zext i16 %11 to i64
  %13 = icmp ult i64 %12, 2
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  store i32 1, i32* %4, align 4
  br label %204

15:                                               ; preds = %3
  %16 = load %struct.BOF*, %struct.BOF** %6, align 8
  %17 = getelementptr inbounds %struct.BOF, %struct.BOF* %16, i32 0, i32 0
  %18 = load i16, i16* %17, align 2
  %19 = zext i16 %18 to i32
  %20 = icmp eq i32 %19, 6
  br i1 %20, label %27, label %21

21:                                               ; preds = %15
  %22 = load %struct.BOF*, %struct.BOF** %6, align 8
  %23 = getelementptr inbounds %struct.BOF, %struct.BOF* %22, i32 0, i32 0
  %24 = load i16, i16* %23, align 2
  %25 = zext i16 %24 to i32
  %26 = icmp eq i32 %25, 10
  br i1 %26, label %27, label %34

27:                                               ; preds = %21, %15
  %28 = load %struct.BOF*, %struct.BOF** %6, align 8
  %29 = getelementptr inbounds %struct.BOF, %struct.BOF* %28, i32 0, i32 1
  %30 = load i16, i16* %29, align 2
  %31 = zext i16 %30 to i64
  %32 = icmp ult i64 %31, 2
  %33 = zext i1 %32 to i32
  store i32 %33, i32* %4, align 4
  br label %204

34:                                               ; preds = %21
  %35 = load %struct.BOF*, %struct.BOF** %6, align 8
  %36 = getelementptr inbounds %struct.BOF, %struct.BOF* %35, i32 0, i32 0
  %37 = load i16, i16* %36, align 2
  %38 = zext i16 %37 to i32
  %39 = icmp eq i32 %38, 189
  br i1 %39, label %40, label %47

40:                                               ; preds = %34
  %41 = load %struct.BOF*, %struct.BOF** %6, align 8
  %42 = getelementptr inbounds %struct.BOF, %struct.BOF* %41, i32 0, i32 1
  %43 = load i16, i16* %42, align 2
  %44 = zext i16 %43 to i64
  %45 = icmp ult i64 %44, 2
  %46 = zext i1 %45 to i32
  store i32 %46, i32* %4, align 4
  br label %204

47:                                               ; preds = %34
  %48 = load %struct.BOF*, %struct.BOF** %6, align 8
  %49 = getelementptr inbounds %struct.BOF, %struct.BOF* %48, i32 0, i32 0
  %50 = load i16, i16* %49, align 2
  %51 = zext i16 %50 to i32
  %52 = icmp eq i32 %51, 190
  br i1 %52, label %53, label %60

53:                                               ; preds = %47
  %54 = load %struct.BOF*, %struct.BOF** %6, align 8
  %55 = getelementptr inbounds %struct.BOF, %struct.BOF* %54, i32 0, i32 1
  %56 = load i16, i16* %55, align 2
  %57 = zext i16 %56 to i64
  %58 = icmp ult i64 %57, 2
  %59 = zext i1 %58 to i32
  store i32 %59, i32* %4, align 4
  br label %204

60:                                               ; preds = %47
  %61 = load %struct.BOF*, %struct.BOF** %6, align 8
  %62 = getelementptr inbounds %struct.BOF, %struct.BOF* %61, i32 0, i32 0
  %63 = load i16, i16* %62, align 2
  %64 = zext i16 %63 to i32
  %65 = icmp eq i32 %64, 252
  br i1 %65, label %66, label %81

66:                                               ; preds = %60
  %67 = load %struct.BOF*, %struct.BOF** %6, align 8
  %68 = getelementptr inbounds %struct.BOF, %struct.BOF* %67, i32 0, i32 1
  %69 = load i16, i16* %68, align 2
  %70 = zext i16 %69 to i64
  %71 = load %struct.xlsWorkBook*, %struct.xlsWorkBook** %5, align 8
  %72 = getelementptr inbounds %struct.xlsWorkBook, %struct.xlsWorkBook* %71, i32 0, i32 0
  %73 = load i32, i32* %72, align 4
  %74 = icmp ne i32 %73, 0
  %75 = zext i1 %74 to i64
  %76 = select i1 %74, i32 2, i32 4
  %77 = sext i32 %76 to i64
  %78 = add i64 0, %77
  %79 = icmp ult i64 %70, %78
  %80 = zext i1 %79 to i32
  store i32 %80, i32* %4, align 4
  br label %204

81:                                               ; preds = %60
  %82 = load %struct.BOF*, %struct.BOF** %6, align 8
  %83 = getelementptr inbounds %struct.BOF, %struct.BOF* %82, i32 0, i32 0
  %84 = load i16, i16* %83, align 2
  %85 = zext i16 %84 to i32
  %86 = icmp eq i32 %85, 516
  br i1 %86, label %93, label %87

87:                                               ; preds = %81
  %88 = load %struct.BOF*, %struct.BOF** %6, align 8
  %89 = getelementptr inbounds %struct.BOF, %struct.BOF* %88, i32 0, i32 0
  %90 = load i16, i16* %89, align 2
  %91 = zext i16 %90 to i32
  %92 = icmp eq i32 %91, 214
  br i1 %92, label %93, label %164

93:                                               ; preds = %87, %81
  %94 = load %struct.BOF*, %struct.BOF** %6, align 8
  %95 = getelementptr inbounds %struct.BOF, %struct.BOF* %94, i32 0, i32 1
  %96 = load i16, i16* %95, align 2
  %97 = zext i16 %96 to i64
  %98 = icmp ult i64 %97, 2
  br i1 %98, label %99, label %100

99:                                               ; preds = %93
  store i32 1, i32* %4, align 4
  br label %204

100:                                              ; preds = %93
  %101 = load i8*, i8** %7, align 8
  %102 = bitcast i8* %101 to %struct.LABEL*
  %103 = getelementptr inbounds %struct.LABEL, %struct.LABEL* %102, i32 0, i32 0
  %104 = getelementptr inbounds [3 x i16], [3 x i16]* %103, i64 0, i64 0
  %105 = load i16, i16* %104, align 2
  %106 = zext i16 %105 to i32
  %107 = load i8*, i8** %7, align 8
  %108 = bitcast i8* %107 to %struct.LABEL*
  %109 = getelementptr inbounds %struct.LABEL, %struct.LABEL* %108, i32 0, i32 0
  %110 = getelementptr inbounds [3 x i16], [3 x i16]* %109, i64 0, i64 1
  %111 = load i16, i16* %110, align 2
  %112 = zext i16 %111 to i32
  %113 = shl i32 %112, 8
  %114 = add nsw i32 %106, %113
  %115 = sext i32 %114 to i64
  store i64 %115, i64* %8, align 8
  %116 = load %struct.xlsWorkBook*, %struct.xlsWorkBook** %5, align 8
  %117 = getelementptr inbounds %struct.xlsWorkBook, %struct.xlsWorkBook* %116, i32 0, i32 0
  %118 = load i32, i32* %117, align 4
  %119 = icmp ne i32 %118, 0
  br i1 %119, label %120, label %129

120:                                              ; preds = %100
  %121 = load %struct.BOF*, %struct.BOF** %6, align 8
  %122 = getelementptr inbounds %struct.BOF, %struct.BOF* %121, i32 0, i32 1
  %123 = load i16, i16* %122, align 2
  %124 = zext i16 %123 to i64
  %125 = load i64, i64* %8, align 8
  %126 = add i64 2, %125
  %127 = icmp ult i64 %124, %126
  %128 = zext i1 %127 to i32
  store i32 %128, i32* %4, align 4
  br label %204

129:                                              ; preds = %100
  %130 = load %struct.BOF*, %struct.BOF** %6, align 8
  %131 = getelementptr inbounds %struct.BOF, %struct.BOF* %130, i32 0, i32 1
  %132 = load i16, i16* %131, align 2
  %133 = zext i16 %132 to i64
  %134 = icmp ult i64 %133, 3
  br i1 %134, label %135, label %136

135:                                              ; preds = %129
  store i32 1, i32* %4, align 4
  br label %204

136:                                              ; preds = %129
  %137 = load i8*, i8** %7, align 8
  %138 = bitcast i8* %137 to %struct.LABEL*
  %139 = getelementptr inbounds %struct.LABEL, %struct.LABEL* %138, i32 0, i32 0
  %140 = getelementptr inbounds [3 x i16], [3 x i16]* %139, i64 0, i64 2
  %141 = load i16, i16* %140, align 2
  %142 = zext i16 %141 to i32
  %143 = and i32 %142, 1
  %144 = icmp eq i32 %143, 0
  br i1 %144, label %145, label %154

145:                                              ; preds = %136
  %146 = load %struct.BOF*, %struct.BOF** %6, align 8
  %147 = getelementptr inbounds %struct.BOF, %struct.BOF* %146, i32 0, i32 1
  %148 = load i16, i16* %147, align 2
  %149 = zext i16 %148 to i64
  %150 = load i64, i64* %8, align 8
  %151 = add i64 3, %150
  %152 = icmp ult i64 %149, %151
  %153 = zext i1 %152 to i32
  store i32 %153, i32* %4, align 4
  br label %204

154:                                              ; preds = %136
  %155 = load %struct.BOF*, %struct.BOF** %6, align 8
  %156 = getelementptr inbounds %struct.BOF, %struct.BOF* %155, i32 0, i32 1
  %157 = load i16, i16* %156, align 2
  %158 = zext i16 %157 to i64
  %159 = load i64, i64* %8, align 8
  %160 = mul i64 2, %159
  %161 = add i64 3, %160
  %162 = icmp ult i64 %158, %161
  %163 = zext i1 %162 to i32
  store i32 %163, i32* %4, align 4
  br label %204

164:                                              ; preds = %87
  %165 = load %struct.BOF*, %struct.BOF** %6, align 8
  %166 = getelementptr inbounds %struct.BOF, %struct.BOF* %165, i32 0, i32 0
  %167 = load i16, i16* %166, align 2
  %168 = zext i16 %167 to i32
  %169 = icmp eq i32 %168, 7
  br i1 %169, label %170, label %177

170:                                              ; preds = %164
  %171 = load %struct.BOF*, %struct.BOF** %6, align 8
  %172 = getelementptr inbounds %struct.BOF, %struct.BOF* %171, i32 0, i32 1
  %173 = load i16, i16* %172, align 2
  %174 = zext i16 %173 to i64
  %175 = icmp ult i64 %174, 4
  %176 = zext i1 %175 to i32
  store i32 %176, i32* %4, align 4
  br label %204

177:                                              ; preds = %164
  %178 = load %struct.BOF*, %struct.BOF** %6, align 8
  %179 = getelementptr inbounds %struct.BOF, %struct.BOF* %178, i32 0, i32 0
  %180 = load i16, i16* %179, align 2
  %181 = zext i16 %180 to i32
  %182 = icmp eq i32 %181, 515
  br i1 %182, label %183, label %190

183:                                              ; preds = %177
  %184 = load %struct.BOF*, %struct.BOF** %6, align 8
  %185 = getelementptr inbounds %struct.BOF, %struct.BOF* %184, i32 0, i32 1
  %186 = load i16, i16* %185, align 2
  %187 = zext i16 %186 to i64
  %188 = icmp ult i64 %187, 2
  %189 = zext i1 %188 to i32
  store i32 %189, i32* %4, align 4
  br label %204

190:                                              ; preds = %177
  %191 = load %struct.BOF*, %struct.BOF** %6, align 8
  %192 = getelementptr inbounds %struct.BOF, %struct.BOF* %191, i32 0, i32 0
  %193 = load i16, i16* %192, align 2
  %194 = zext i16 %193 to i32
  %195 = icmp eq i32 %194, 517
  br i1 %195, label %196, label %203

196:                                              ; preds = %190
  %197 = load %struct.BOF*, %struct.BOF** %6, align 8
  %198 = getelementptr inbounds %struct.BOF, %struct.BOF* %197, i32 0, i32 1
  %199 = load i16, i16* %198, align 2
  %200 = zext i16 %199 to i64
  %201 = icmp ult i64 %200, 2
  %202 = zext i1 %201 to i32
  store i32 %202, i32* %4, align 4
  br label %204

203:                                              ; preds = %190
  store i32 0, i32* %4, align 4
  br label %204

204:                                              ; preds = %203, %196, %183, %170, %154, %145, %135, %120, %99, %66, %53, %40, %27, %14
  %205 = load i32, i32* %4, align 4
  ret i32 %205
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
