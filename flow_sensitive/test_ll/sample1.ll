; ModuleID = 'sample1.c'
source_filename = "sample1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MyFunc(i32 noundef %0) #0 !dbg !10 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !15, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %3, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 -1, i32* %3, align 4, !dbg !18
  %4 = load i32, i32* %2, align 4, !dbg !19
  %5 = icmp slt i32 %4, 0, !dbg !21
  br i1 %5, label %6, label %7, !dbg !22

6:                                                ; preds = %1
  store i32 0, i32* %3, align 4, !dbg !23
  br label %7, !dbg !24

7:                                                ; preds = %6, %1
  %8 = load i32, i32* %2, align 4, !dbg !25
  %9 = icmp sgt i32 %8, 5, !dbg !27
  br i1 %9, label %10, label %13, !dbg !28

10:                                               ; preds = %7
  %11 = load i32, i32* %2, align 4, !dbg !29
  %12 = sub nsw i32 %11, 3, !dbg !30
  store i32 %12, i32* %3, align 4, !dbg !31
  br label %13, !dbg !32

13:                                               ; preds = %10, %7
  %14 = load i32, i32* %2, align 4, !dbg !33
  %15 = icmp sgt i32 %14, 10, !dbg !35
  br i1 %15, label %16, label %17, !dbg !36

16:                                               ; preds = %13
  store i32 0, i32* %3, align 4, !dbg !37
  br label %17, !dbg !38

17:                                               ; preds = %16, %13
  %18 = load i32, i32* %3, align 4, !dbg !39
  ret i32 %18, !dbg !40
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !41 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !44, metadata !DIExpression()), !dbg !45
  %3 = call i32 @MyFunc(i32 noundef 7), !dbg !46
  store i32 %3, i32* %2, align 4, !dbg !45
  %4 = load i32, i32* %2, align 4, !dbg !47
  %5 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %4), !dbg !48
  ret i32 0, !dbg !49
}

declare i32 @printf(i8* noundef, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "sample1.c", directory: "/home/went/Project/software_security/lab2/testcase/path-sensitive", checksumkind: CSK_MD5, checksum: "62c7e0363faffbb89e32ac7a7a54e3b1")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "MyFunc", scope: !1, file: !1, line: 3, type: !11, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!11 = !DISubroutineType(types: !12)
!12 = !{!13, !13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{}
!15 = !DILocalVariable(name: "x", arg: 1, scope: !10, file: !1, line: 3, type: !13)
!16 = !DILocation(line: 3, column: 16, scope: !10)
!17 = !DILocalVariable(name: "ret", scope: !10, file: !1, line: 4, type: !13)
!18 = !DILocation(line: 4, column: 9, scope: !10)
!19 = !DILocation(line: 5, column: 9, scope: !20)
!20 = distinct !DILexicalBlock(scope: !10, file: !1, line: 5, column: 9)
!21 = !DILocation(line: 5, column: 11, scope: !20)
!22 = !DILocation(line: 5, column: 9, scope: !10)
!23 = !DILocation(line: 6, column: 13, scope: !20)
!24 = !DILocation(line: 6, column: 9, scope: !20)
!25 = !DILocation(line: 7, column: 9, scope: !26)
!26 = distinct !DILexicalBlock(scope: !10, file: !1, line: 7, column: 9)
!27 = !DILocation(line: 7, column: 11, scope: !26)
!28 = !DILocation(line: 7, column: 9, scope: !10)
!29 = !DILocation(line: 8, column: 15, scope: !26)
!30 = !DILocation(line: 8, column: 17, scope: !26)
!31 = !DILocation(line: 8, column: 13, scope: !26)
!32 = !DILocation(line: 8, column: 9, scope: !26)
!33 = !DILocation(line: 9, column: 9, scope: !34)
!34 = distinct !DILexicalBlock(scope: !10, file: !1, line: 9, column: 9)
!35 = !DILocation(line: 9, column: 11, scope: !34)
!36 = !DILocation(line: 9, column: 9, scope: !10)
!37 = !DILocation(line: 10, column: 13, scope: !34)
!38 = !DILocation(line: 10, column: 9, scope: !34)
!39 = !DILocation(line: 11, column: 12, scope: !10)
!40 = !DILocation(line: 11, column: 5, scope: !10)
!41 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !42, scopeLine: 13, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!42 = !DISubroutineType(types: !43)
!43 = !{!13}
!44 = !DILocalVariable(name: "a", scope: !41, file: !1, line: 14, type: !13)
!45 = !DILocation(line: 14, column: 9, scope: !41)
!46 = !DILocation(line: 14, column: 13, scope: !41)
!47 = !DILocation(line: 15, column: 20, scope: !41)
!48 = !DILocation(line: 15, column: 5, scope: !41)
!49 = !DILocation(line: 16, column: 5, scope: !41)
