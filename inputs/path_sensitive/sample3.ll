; ModuleID = 'inputs/path_sensitive/sample3.c'
source_filename = "inputs/path_sensitive/sample3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d \00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @GenerateRandomArray(i32* noundef %0, i32 noundef %1, i32 ()* noundef %2) #0 !dbg !10 {
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32 ()*, align 8
  %7 = alloca i32, align 4
  store i32* %0, i32** %4, align 8
  call void @llvm.dbg.declare(metadata i32** %4, metadata !19, metadata !DIExpression()), !dbg !20
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 ()* %2, i32 ()** %6, align 8
  call void @llvm.dbg.declare(metadata i32 ()** %6, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %7, metadata !25, metadata !DIExpression()), !dbg !27
  store i32 0, i32* %7, align 4, !dbg !27
  br label %8, !dbg !28

8:                                                ; preds = %19, %3
  %9 = load i32, i32* %7, align 4, !dbg !29
  %10 = load i32, i32* %5, align 4, !dbg !31
  %11 = icmp slt i32 %9, %10, !dbg !32
  br i1 %11, label %12, label %22, !dbg !33

12:                                               ; preds = %8
  %13 = load i32 ()*, i32 ()** %6, align 8, !dbg !34
  %14 = call i32 %13(), !dbg !34
  %15 = load i32*, i32** %4, align 8, !dbg !35
  %16 = load i32, i32* %7, align 4, !dbg !36
  %17 = sext i32 %16 to i64, !dbg !35
  %18 = getelementptr inbounds i32, i32* %15, i64 %17, !dbg !35
  store i32 %14, i32* %18, align 4, !dbg !37
  br label %19, !dbg !35

19:                                               ; preds = %12
  %20 = load i32, i32* %7, align 4, !dbg !38
  %21 = add nsw i32 %20, 1, !dbg !38
  store i32 %21, i32* %7, align 4, !dbg !38
  br label %8, !dbg !39, !llvm.loop !40

22:                                               ; preds = %8
  ret void, !dbg !43
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @GetRandomValue() #0 !dbg !44 {
  %1 = call i32 @rand() #4, !dbg !45
  %2 = srem i32 %1, 114514, !dbg !46
  ret i32 %2, !dbg !47
}

; Function Attrs: nounwind
declare i32 @rand() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !48 {
  %1 = alloca i32, align 4
  %2 = alloca [10 x i32], align 16
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata [10 x i32]* %2, metadata !49, metadata !DIExpression()), !dbg !53
  %4 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i64 0, i64 0, !dbg !54
  call void @GenerateRandomArray(i32* noundef %4, i32 noundef 5, i32 ()* noundef @GetRandomValue), !dbg !55
  call void @llvm.dbg.declare(metadata i32* %3, metadata !56, metadata !DIExpression()), !dbg !58
  store i32 0, i32* %3, align 4, !dbg !58
  br label %5, !dbg !59

5:                                                ; preds = %14, %0
  %6 = load i32, i32* %3, align 4, !dbg !60
  %7 = icmp slt i32 %6, 5, !dbg !62
  br i1 %7, label %8, label %17, !dbg !63

8:                                                ; preds = %5
  %9 = load i32, i32* %3, align 4, !dbg !64
  %10 = sext i32 %9 to i64, !dbg !66
  %11 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i64 0, i64 %10, !dbg !66
  %12 = load i32, i32* %11, align 4, !dbg !66
  %13 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %12), !dbg !67
  br label %14, !dbg !68

14:                                               ; preds = %8
  %15 = load i32, i32* %3, align 4, !dbg !69
  %16 = add nsw i32 %15, 1, !dbg !69
  store i32 %16, i32* %3, align 4, !dbg !69
  br label %5, !dbg !70, !llvm.loop !71

17:                                               ; preds = %5
  ret i32 0, !dbg !73
}

declare i32 @printf(i8* noundef, ...) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "inputs/path_sensitive/sample3.c", directory: "/home/went/Project/software_security/mycc", checksumkind: CSK_MD5, checksum: "0195a736db702d2a4dbffc3375a566c4")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "GenerateRandomArray", scope: !1, file: !1, line: 4, type: !11, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !18)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !14, !15}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DISubroutineType(types: !17)
!17 = !{!14}
!18 = !{}
!19 = !DILocalVariable(name: "arr", arg: 1, scope: !10, file: !1, line: 4, type: !13)
!20 = !DILocation(line: 4, column: 31, scope: !10)
!21 = !DILocalVariable(name: "len", arg: 2, scope: !10, file: !1, line: 4, type: !14)
!22 = !DILocation(line: 4, column: 40, scope: !10)
!23 = !DILocalVariable(name: "GetNextValue", arg: 3, scope: !10, file: !1, line: 4, type: !15)
!24 = !DILocation(line: 4, column: 51, scope: !10)
!25 = !DILocalVariable(name: "i", scope: !26, file: !1, line: 5, type: !14)
!26 = distinct !DILexicalBlock(scope: !10, file: !1, line: 5, column: 5)
!27 = !DILocation(line: 5, column: 14, scope: !26)
!28 = !DILocation(line: 5, column: 10, scope: !26)
!29 = !DILocation(line: 5, column: 21, scope: !30)
!30 = distinct !DILexicalBlock(scope: !26, file: !1, line: 5, column: 5)
!31 = !DILocation(line: 5, column: 25, scope: !30)
!32 = !DILocation(line: 5, column: 23, scope: !30)
!33 = !DILocation(line: 5, column: 5, scope: !26)
!34 = !DILocation(line: 6, column: 18, scope: !30)
!35 = !DILocation(line: 6, column: 9, scope: !30)
!36 = !DILocation(line: 6, column: 13, scope: !30)
!37 = !DILocation(line: 6, column: 16, scope: !30)
!38 = !DILocation(line: 5, column: 31, scope: !30)
!39 = !DILocation(line: 5, column: 5, scope: !30)
!40 = distinct !{!40, !33, !41, !42}
!41 = !DILocation(line: 6, column: 31, scope: !26)
!42 = !{!"llvm.loop.mustprogress"}
!43 = !DILocation(line: 7, column: 1, scope: !10)
!44 = distinct !DISubprogram(name: "GetRandomValue", scope: !1, file: !1, line: 9, type: !16, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !18)
!45 = !DILocation(line: 10, column: 12, scope: !44)
!46 = !DILocation(line: 10, column: 19, scope: !44)
!47 = !DILocation(line: 10, column: 5, scope: !44)
!48 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !16, scopeLine: 13, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !18)
!49 = !DILocalVariable(name: "arr", scope: !48, file: !1, line: 14, type: !50)
!50 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 320, elements: !51)
!51 = !{!52}
!52 = !DISubrange(count: 10)
!53 = !DILocation(line: 14, column: 9, scope: !48)
!54 = !DILocation(line: 15, column: 25, scope: !48)
!55 = !DILocation(line: 15, column: 5, scope: !48)
!56 = !DILocalVariable(name: "i", scope: !57, file: !1, line: 16, type: !14)
!57 = distinct !DILexicalBlock(scope: !48, file: !1, line: 16, column: 5)
!58 = !DILocation(line: 16, column: 13, scope: !57)
!59 = !DILocation(line: 16, column: 9, scope: !57)
!60 = !DILocation(line: 16, column: 20, scope: !61)
!61 = distinct !DILexicalBlock(scope: !57, file: !1, line: 16, column: 5)
!62 = !DILocation(line: 16, column: 22, scope: !61)
!63 = !DILocation(line: 16, column: 5, scope: !57)
!64 = !DILocation(line: 17, column: 27, scope: !65)
!65 = distinct !DILexicalBlock(scope: !61, file: !1, line: 16, column: 32)
!66 = !DILocation(line: 17, column: 23, scope: !65)
!67 = !DILocation(line: 17, column: 9, scope: !65)
!68 = !DILocation(line: 18, column: 5, scope: !65)
!69 = !DILocation(line: 16, column: 28, scope: !61)
!70 = !DILocation(line: 16, column: 5, scope: !61)
!71 = distinct !{!71, !63, !72, !42}
!72 = !DILocation(line: 18, column: 5, scope: !57)
!73 = !DILocation(line: 19, column: 5, scope: !48)
