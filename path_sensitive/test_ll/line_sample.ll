; ModuleID = 'test_c/line_sample.c'
source_filename = "test_c/line_sample.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"Hello, World!\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"Hello, %d\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !10 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 0, i32* %2, align 4, !dbg !16
  %3 = load i32, i32* %2, align 4, !dbg !17
  %4 = icmp sgt i32 %3, 1, !dbg !19
  br i1 %4, label %5, label %7, !dbg !20

5:                                                ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i64 0, i64 0)), !dbg !21
  br label %11, !dbg !21

7:                                                ; preds = %0
  %8 = load i32, i32* %2, align 4, !dbg !22
  %9 = add nsw i32 %8, 10, !dbg !23
  %10 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i32 noundef %9), !dbg !24
  br label %11

11:                                               ; preds = %7, %5
  ret i32 0, !dbg !25
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8* noundef, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test_c/line_sample.c", directory: "/home/went/Project/software_security/lab2/path_sensitive", checksumkind: CSK_MD5, checksum: "64642c0a0a8230236bd7e4dedf358f53")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !11, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!11 = !DISubroutineType(types: !12)
!12 = !{!13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{}
!15 = !DILocalVariable(name: "x", scope: !10, file: !1, line: 5, type: !13)
!16 = !DILocation(line: 5, column: 9, scope: !10)
!17 = !DILocation(line: 7, column: 9, scope: !18)
!18 = distinct !DILexicalBlock(scope: !10, file: !1, line: 7, column: 9)
!19 = !DILocation(line: 7, column: 11, scope: !18)
!20 = !DILocation(line: 7, column: 9, scope: !10)
!21 = !DILocation(line: 8, column: 9, scope: !18)
!22 = !DILocation(line: 10, column: 29, scope: !18)
!23 = !DILocation(line: 10, column: 30, scope: !18)
!24 = !DILocation(line: 10, column: 9, scope: !18)
!25 = !DILocation(line: 12, column: 5, scope: !10)
