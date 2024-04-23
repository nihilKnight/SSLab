; ModuleID = '../testcase/path-sensitive/sample2.c'
source_filename = "../testcase/path-sensitive/sample2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [27 x i8] c"Move disk 1 from %c to %c\0A\00", align 1
@.str.1 = private unnamed_addr constant [28 x i8] c"Move disk %d from %c to %c\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @hanoi(i32 noundef %0, i8 noundef signext %1, i8 noundef signext %2, i8 noundef signext %3) #0 !dbg !10 {
  %5 = alloca i32, align 4
  %6 = alloca i8, align 1
  %7 = alloca i8, align 1
  %8 = alloca i8, align 1
  store i32 %0, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !16, metadata !DIExpression()), !dbg !17
  store i8 %1, i8* %6, align 1
  call void @llvm.dbg.declare(metadata i8* %6, metadata !18, metadata !DIExpression()), !dbg !19
  store i8 %2, i8* %7, align 1
  call void @llvm.dbg.declare(metadata i8* %7, metadata !20, metadata !DIExpression()), !dbg !21
  store i8 %3, i8* %8, align 1
  call void @llvm.dbg.declare(metadata i8* %8, metadata !22, metadata !DIExpression()), !dbg !23
  %9 = load i32, i32* %5, align 4, !dbg !24
  %10 = icmp eq i32 %9, 1, !dbg !26
  br i1 %10, label %11, label %17, !dbg !27

11:                                               ; preds = %4
  %12 = load i8, i8* %6, align 1, !dbg !28
  %13 = sext i8 %12 to i32, !dbg !28
  %14 = load i8, i8* %8, align 1, !dbg !30
  %15 = sext i8 %14 to i32, !dbg !30
  %16 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i64 0, i64 0), i32 noundef %13, i32 noundef %15), !dbg !31
  br label %34, !dbg !32

17:                                               ; preds = %4
  %18 = load i32, i32* %5, align 4, !dbg !33
  %19 = sub nsw i32 %18, 1, !dbg !34
  %20 = load i8, i8* %6, align 1, !dbg !35
  %21 = load i8, i8* %8, align 1, !dbg !36
  %22 = load i8, i8* %7, align 1, !dbg !37
  call void @hanoi(i32 noundef %19, i8 noundef signext %20, i8 noundef signext %21, i8 noundef signext %22), !dbg !38
  %23 = load i32, i32* %5, align 4, !dbg !39
  %24 = load i8, i8* %6, align 1, !dbg !40
  %25 = sext i8 %24 to i32, !dbg !40
  %26 = load i8, i8* %8, align 1, !dbg !41
  %27 = sext i8 %26 to i32, !dbg !41
  %28 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i64 0, i64 0), i32 noundef %23, i32 noundef %25, i32 noundef %27), !dbg !42
  %29 = load i32, i32* %5, align 4, !dbg !43
  %30 = sub nsw i32 %29, 1, !dbg !44
  %31 = load i8, i8* %7, align 1, !dbg !45
  %32 = load i8, i8* %6, align 1, !dbg !46
  %33 = load i8, i8* %8, align 1, !dbg !47
  call void @hanoi(i32 noundef %30, i8 noundef signext %31, i8 noundef signext %32, i8 noundef signext %33), !dbg !48
  br label %34, !dbg !49

34:                                               ; preds = %17, %11
  ret void, !dbg !49
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8* noundef, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !50 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !53, metadata !DIExpression()), !dbg !54
  store i32 7, i32* %2, align 4, !dbg !54
  %3 = load i32, i32* %2, align 4, !dbg !55
  call void @hanoi(i32 noundef %3, i8 noundef signext 65, i8 noundef signext 66, i8 noundef signext 67), !dbg !56
  ret i32 0, !dbg !57
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcase/path-sensitive/sample2.c", directory: "/home/went/Project/software_security/lab2/path_sensitive", checksumkind: CSK_MD5, checksum: "a26431d0fa2c42c1f31eaa5dbbf622f0")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "hanoi", scope: !1, file: !1, line: 3, type: !11, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !14, !14, !14}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !{}
!16 = !DILocalVariable(name: "n", arg: 1, scope: !10, file: !1, line: 3, type: !13)
!17 = !DILocation(line: 3, column: 16, scope: !10)
!18 = !DILocalVariable(name: "A", arg: 2, scope: !10, file: !1, line: 3, type: !14)
!19 = !DILocation(line: 3, column: 24, scope: !10)
!20 = !DILocalVariable(name: "B", arg: 3, scope: !10, file: !1, line: 3, type: !14)
!21 = !DILocation(line: 3, column: 32, scope: !10)
!22 = !DILocalVariable(name: "C", arg: 4, scope: !10, file: !1, line: 3, type: !14)
!23 = !DILocation(line: 3, column: 40, scope: !10)
!24 = !DILocation(line: 4, column: 9, scope: !25)
!25 = distinct !DILexicalBlock(scope: !10, file: !1, line: 4, column: 9)
!26 = !DILocation(line: 4, column: 11, scope: !25)
!27 = !DILocation(line: 4, column: 9, scope: !10)
!28 = !DILocation(line: 5, column: 47, scope: !29)
!29 = distinct !DILexicalBlock(scope: !25, file: !1, line: 4, column: 17)
!30 = !DILocation(line: 5, column: 50, scope: !29)
!31 = !DILocation(line: 5, column: 9, scope: !29)
!32 = !DILocation(line: 6, column: 9, scope: !29)
!33 = !DILocation(line: 8, column: 11, scope: !10)
!34 = !DILocation(line: 8, column: 13, scope: !10)
!35 = !DILocation(line: 8, column: 18, scope: !10)
!36 = !DILocation(line: 8, column: 21, scope: !10)
!37 = !DILocation(line: 8, column: 24, scope: !10)
!38 = !DILocation(line: 8, column: 5, scope: !10)
!39 = !DILocation(line: 9, column: 44, scope: !10)
!40 = !DILocation(line: 9, column: 47, scope: !10)
!41 = !DILocation(line: 9, column: 50, scope: !10)
!42 = !DILocation(line: 9, column: 5, scope: !10)
!43 = !DILocation(line: 10, column: 11, scope: !10)
!44 = !DILocation(line: 10, column: 13, scope: !10)
!45 = !DILocation(line: 10, column: 18, scope: !10)
!46 = !DILocation(line: 10, column: 21, scope: !10)
!47 = !DILocation(line: 10, column: 24, scope: !10)
!48 = !DILocation(line: 10, column: 5, scope: !10)
!49 = !DILocation(line: 11, column: 1, scope: !10)
!50 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !51, scopeLine: 13, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!51 = !DISubroutineType(types: !52)
!52 = !{!13}
!53 = !DILocalVariable(name: "n", scope: !50, file: !1, line: 14, type: !13)
!54 = !DILocation(line: 14, column: 9, scope: !50)
!55 = !DILocation(line: 15, column: 11, scope: !50)
!56 = !DILocation(line: 15, column: 5, scope: !50)
!57 = !DILocation(line: 16, column: 5, scope: !50)
