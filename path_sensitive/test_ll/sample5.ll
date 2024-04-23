; ModuleID = '../testcase/path-sensitive/sample5.c'
source_filename = "../testcase/path-sensitive/sample5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._xlsWorkBook = type { i8 }
%struct._bof = type { i16, i16 }
%struct.anon = type { i16, i8, i8 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @xls_isRecordTooSmall(%struct._xlsWorkBook* noundef %0, %struct._bof* noundef %1, i8* noundef %2) #0 !dbg !12 {
  %4 = alloca i32, align 4
  %5 = alloca %struct._xlsWorkBook*, align 8
  %6 = alloca %struct._bof*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct.anon*, align 8
  store %struct._xlsWorkBook* %0, %struct._xlsWorkBook** %5, align 8
  call void @llvm.dbg.declare(metadata %struct._xlsWorkBook** %5, metadata !34, metadata !DIExpression()), !dbg !35
  store %struct._bof* %1, %struct._bof** %6, align 8
  call void @llvm.dbg.declare(metadata %struct._bof** %6, metadata !36, metadata !DIExpression()), !dbg !37
  store i8* %2, i8** %7, align 8
  call void @llvm.dbg.declare(metadata i8** %7, metadata !38, metadata !DIExpression()), !dbg !39
  %9 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !40
  %10 = getelementptr inbounds %struct._bof, %struct._bof* %9, i32 0, i32 0, !dbg !41
  %11 = load i16, i16* %10, align 2, !dbg !41
  %12 = zext i16 %11 to i32, !dbg !40
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
  ], !dbg !42

13:                                               ; preds = %3
  %14 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !43
  %15 = getelementptr inbounds %struct._bof, %struct._bof* %14, i32 0, i32 1, !dbg !45
  %16 = load i16, i16* %15, align 2, !dbg !45
  %17 = zext i16 %16 to i64, !dbg !43
  %18 = icmp ult i64 %17, 4, !dbg !46
  %19 = zext i1 %18 to i32, !dbg !46
  store i32 %19, i32* %4, align 4, !dbg !47
  br label %132, !dbg !47

20:                                               ; preds = %3
  %21 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !48
  %22 = getelementptr inbounds %struct._bof, %struct._bof* %21, i32 0, i32 1, !dbg !49
  %23 = load i16, i16* %22, align 2, !dbg !49
  %24 = zext i16 %23 to i64, !dbg !48
  %25 = icmp ult i64 %24, 2, !dbg !50
  %26 = zext i1 %25 to i32, !dbg !50
  store i32 %26, i32* %4, align 4, !dbg !51
  br label %132, !dbg !51

27:                                               ; preds = %3
  %28 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !52
  %29 = getelementptr inbounds %struct._bof, %struct._bof* %28, i32 0, i32 1, !dbg !53
  %30 = load i16, i16* %29, align 2, !dbg !53
  %31 = zext i16 %30 to i64, !dbg !52
  %32 = icmp ult i64 %31, 0, !dbg !54
  %33 = zext i1 %32 to i32, !dbg !54
  store i32 %33, i32* %4, align 4, !dbg !55
  br label %132, !dbg !55

34:                                               ; preds = %3
  %35 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !56
  %36 = getelementptr inbounds %struct._bof, %struct._bof* %35, i32 0, i32 1, !dbg !57
  %37 = load i16, i16* %36, align 2, !dbg !57
  %38 = zext i16 %37 to i64, !dbg !56
  %39 = icmp ult i64 %38, 0, !dbg !58
  %40 = zext i1 %39 to i32, !dbg !58
  store i32 %40, i32* %4, align 4, !dbg !59
  br label %132, !dbg !59

41:                                               ; preds = %3
  %42 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !60
  %43 = getelementptr inbounds %struct._bof, %struct._bof* %42, i32 0, i32 1, !dbg !61
  %44 = load i16, i16* %43, align 2, !dbg !61
  %45 = zext i16 %44 to i64, !dbg !60
  %46 = icmp ult i64 %45, 0, !dbg !62
  %47 = zext i1 %46 to i32, !dbg !62
  store i32 %47, i32* %4, align 4, !dbg !63
  br label %132, !dbg !63

48:                                               ; preds = %3
  %49 = load %struct._xlsWorkBook*, %struct._xlsWorkBook** %5, align 8, !dbg !64
  %50 = getelementptr inbounds %struct._xlsWorkBook, %struct._xlsWorkBook* %49, i32 0, i32 0, !dbg !66
  %51 = load i8, i8* %50, align 1, !dbg !66
  %52 = icmp ne i8 %51, 0, !dbg !64
  br i1 %52, label %53, label %60, !dbg !67

53:                                               ; preds = %48
  %54 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !68
  %55 = getelementptr inbounds %struct._bof, %struct._bof* %54, i32 0, i32 1, !dbg !70
  %56 = load i16, i16* %55, align 2, !dbg !70
  %57 = zext i16 %56 to i64, !dbg !68
  %58 = icmp ult i64 %57, 0, !dbg !71
  %59 = zext i1 %58 to i32, !dbg !71
  store i32 %59, i32* %4, align 4, !dbg !72
  br label %132, !dbg !72

60:                                               ; preds = %48
  %61 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !73
  %62 = getelementptr inbounds %struct._bof, %struct._bof* %61, i32 0, i32 1, !dbg !74
  %63 = load i16, i16* %62, align 2, !dbg !74
  %64 = zext i16 %63 to i64, !dbg !73
  %65 = icmp ult i64 %64, 0, !dbg !75
  %66 = zext i1 %65 to i32, !dbg !75
  store i32 %66, i32* %4, align 4, !dbg !76
  br label %132, !dbg !76

67:                                               ; preds = %3, %3
  %68 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !77
  %69 = getelementptr inbounds %struct._bof, %struct._bof* %68, i32 0, i32 1, !dbg !78
  %70 = load i16, i16* %69, align 2, !dbg !78
  %71 = zext i16 %70 to i64, !dbg !77
  %72 = icmp ult i64 %71, 0, !dbg !79
  %73 = zext i1 %72 to i32, !dbg !79
  store i32 %73, i32* %4, align 4, !dbg !80
  br label %132, !dbg !80

74:                                               ; preds = %3
  %75 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !81
  %76 = getelementptr inbounds %struct._bof, %struct._bof* %75, i32 0, i32 1, !dbg !82
  %77 = load i16, i16* %76, align 2, !dbg !82
  %78 = zext i16 %77 to i64, !dbg !81
  %79 = icmp ult i64 %78, 0, !dbg !83
  %80 = zext i1 %79 to i32, !dbg !83
  store i32 %80, i32* %4, align 4, !dbg !84
  br label %132, !dbg !84

81:                                               ; preds = %3
  call void @llvm.dbg.declare(metadata %struct.anon** %8, metadata !85, metadata !DIExpression()), !dbg !93
  %82 = load i8*, i8** %7, align 8, !dbg !94
  %83 = bitcast i8* %82 to %struct.anon*, !dbg !95
  store %struct.anon* %83, %struct.anon** %8, align 8, !dbg !96
  %84 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !97
  %85 = getelementptr inbounds %struct._bof, %struct._bof* %84, i32 0, i32 1, !dbg !99
  %86 = load i16, i16* %85, align 2, !dbg !99
  %87 = zext i16 %86 to i32, !dbg !97
  %88 = icmp slt i32 %87, 2, !dbg !100
  br i1 %88, label %89, label %90, !dbg !101

89:                                               ; preds = %81
  store i32 1, i32* %4, align 4, !dbg !102
  br label %132, !dbg !102

90:                                               ; preds = %81
  %91 = load %struct.anon*, %struct.anon** %8, align 8, !dbg !104
  %92 = getelementptr inbounds %struct.anon, %struct.anon* %91, i32 0, i32 0, !dbg !106
  %93 = load i16, i16* %92, align 2, !dbg !106
  %94 = zext i16 %93 to i32, !dbg !104
  %95 = and i32 %94, 32768, !dbg !107
  %96 = icmp ne i32 %95, 0, !dbg !107
  br i1 %96, label %97, label %104, !dbg !108

97:                                               ; preds = %90
  %98 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !109
  %99 = getelementptr inbounds %struct._bof, %struct._bof* %98, i32 0, i32 1, !dbg !111
  %100 = load i16, i16* %99, align 2, !dbg !111
  %101 = zext i16 %100 to i32, !dbg !109
  %102 = icmp slt i32 %101, 4, !dbg !112
  %103 = zext i1 %102 to i32, !dbg !112
  store i32 %103, i32* %4, align 4, !dbg !113
  br label %132, !dbg !113

104:                                              ; preds = %90
  %105 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !114
  %106 = getelementptr inbounds %struct._bof, %struct._bof* %105, i32 0, i32 1, !dbg !117
  %107 = load i16, i16* %106, align 2, !dbg !117
  %108 = zext i16 %107 to i32, !dbg !114
  %109 = icmp slt i32 %108, 3, !dbg !118
  br i1 %109, label %110, label %111, !dbg !119

110:                                              ; preds = %104
  store i32 1, i32* %4, align 4, !dbg !120
  br label %132, !dbg !120

111:                                              ; preds = %104
  %112 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !121
  %113 = getelementptr inbounds %struct._bof, %struct._bof* %112, i32 0, i32 1, !dbg !122
  %114 = load i16, i16* %113, align 2, !dbg !122
  %115 = zext i16 %114 to i32, !dbg !121
  %116 = load %struct.anon*, %struct.anon** %8, align 8, !dbg !123
  %117 = getelementptr inbounds %struct.anon, %struct.anon* %116, i32 0, i32 1, !dbg !124
  %118 = load i8, i8* %117, align 2, !dbg !124
  %119 = zext i8 %118 to i32, !dbg !123
  %120 = add nsw i32 3, %119, !dbg !125
  %121 = icmp slt i32 %115, %120, !dbg !126
  %122 = zext i1 %121 to i32, !dbg !126
  store i32 %122, i32* %4, align 4, !dbg !127
  br label %132, !dbg !127

123:                                              ; preds = %3
  %124 = load %struct._bof*, %struct._bof** %6, align 8, !dbg !128
  %125 = getelementptr inbounds %struct._bof, %struct._bof* %124, i32 0, i32 1, !dbg !129
  %126 = load i16, i16* %125, align 2, !dbg !129
  %127 = zext i16 %126 to i64, !dbg !128
  %128 = icmp ult i64 %127, 1, !dbg !130
  %129 = zext i1 %128 to i32, !dbg !130
  store i32 %129, i32* %4, align 4, !dbg !131
  br label %132, !dbg !131

130:                                              ; preds = %3
  br label %131, !dbg !132

131:                                              ; preds = %130
  store i32 0, i32* %4, align 4, !dbg !133
  br label %132, !dbg !133

132:                                              ; preds = %131, %123, %111, %110, %97, %89, %74, %67, %60, %53, %41, %34, %27, %20, %13
  %133 = load i32, i32* %4, align 4, !dbg !134
  ret i32 %133, !dbg !134
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!4, !5, !6, !7, !8, !9, !10}
!llvm.ident = !{!11}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcase/path-sensitive/sample5.c", directory: "/home/went/Project/software_security/lab2/path_sensitive", checksumkind: CSK_MD5, checksum: "b11032b5d298a24ac8cfce014213c46c")
!2 = !{!3}
!3 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!4 = !{i32 7, !"Dwarf Version", i32 5}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = !{i32 7, !"PIC Level", i32 2}
!8 = !{i32 7, !"PIE Level", i32 2}
!9 = !{i32 7, !"uwtable", i32 1}
!10 = !{i32 7, !"frame-pointer", i32 2}
!11 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!12 = distinct !DISubprogram(name: "xls_isRecordTooSmall", scope: !1, file: !1, line: 45, type: !13, scopeLine: 45, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !33)
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !16, !22, !29}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "xlsWorkBook", file: !1, line: 26, baseType: !18)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_xlsWorkBook", file: !1, line: 24, size: 8, elements: !19)
!19 = !{!20}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "is5ver", scope: !18, file: !1, line: 25, baseType: !21, size: 8)
!21 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "BOF", file: !1, line: 22, baseType: !24)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_bof", file: !1, line: 19, size: 32, elements: !25)
!25 = !{!26, !28}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !24, file: !1, line: 20, baseType: !27, size: 16)
!27 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !24, file: !1, line: 21, baseType: !27, size: 16, offset: 16)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !31)
!31 = !DIDerivedType(tag: DW_TAG_typedef, name: "BYTE", file: !1, line: 16, baseType: !32)
!32 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!33 = !{}
!34 = !DILocalVariable(name: "pWB", arg: 1, scope: !12, file: !1, line: 45, type: !16)
!35 = !DILocation(line: 45, column: 39, scope: !12)
!36 = !DILocalVariable(name: "bof1", arg: 2, scope: !12, file: !1, line: 45, type: !22)
!37 = !DILocation(line: 45, column: 49, scope: !12)
!38 = !DILocalVariable(name: "buf", arg: 3, scope: !12, file: !1, line: 45, type: !29)
!39 = !DILocation(line: 45, column: 67, scope: !12)
!40 = !DILocation(line: 46, column: 13, scope: !12)
!41 = !DILocation(line: 46, column: 19, scope: !12)
!42 = !DILocation(line: 46, column: 5, scope: !12)
!43 = !DILocation(line: 48, column: 21, scope: !44)
!44 = distinct !DILexicalBlock(scope: !12, file: !1, line: 46, column: 23)
!45 = !DILocation(line: 48, column: 27, scope: !44)
!46 = !DILocation(line: 48, column: 32, scope: !44)
!47 = !DILocation(line: 48, column: 13, scope: !44)
!48 = !DILocation(line: 50, column: 21, scope: !44)
!49 = !DILocation(line: 50, column: 27, scope: !44)
!50 = !DILocation(line: 50, column: 32, scope: !44)
!51 = !DILocation(line: 50, column: 13, scope: !44)
!52 = !DILocation(line: 52, column: 21, scope: !44)
!53 = !DILocation(line: 52, column: 27, scope: !44)
!54 = !DILocation(line: 52, column: 32, scope: !44)
!55 = !DILocation(line: 52, column: 13, scope: !44)
!56 = !DILocation(line: 54, column: 21, scope: !44)
!57 = !DILocation(line: 54, column: 27, scope: !44)
!58 = !DILocation(line: 54, column: 32, scope: !44)
!59 = !DILocation(line: 54, column: 13, scope: !44)
!60 = !DILocation(line: 56, column: 21, scope: !44)
!61 = !DILocation(line: 56, column: 27, scope: !44)
!62 = !DILocation(line: 56, column: 32, scope: !44)
!63 = !DILocation(line: 56, column: 13, scope: !44)
!64 = !DILocation(line: 58, column: 7, scope: !65)
!65 = distinct !DILexicalBlock(scope: !44, file: !1, line: 58, column: 7)
!66 = !DILocation(line: 58, column: 12, scope: !65)
!67 = !DILocation(line: 58, column: 7, scope: !44)
!68 = !DILocation(line: 59, column: 25, scope: !69)
!69 = distinct !DILexicalBlock(scope: !65, file: !1, line: 58, column: 20)
!70 = !DILocation(line: 59, column: 31, scope: !69)
!71 = !DILocation(line: 59, column: 36, scope: !69)
!72 = !DILocation(line: 59, column: 17, scope: !69)
!73 = !DILocation(line: 61, column: 21, scope: !44)
!74 = !DILocation(line: 61, column: 27, scope: !44)
!75 = !DILocation(line: 61, column: 32, scope: !44)
!76 = !DILocation(line: 61, column: 13, scope: !44)
!77 = !DILocation(line: 64, column: 21, scope: !44)
!78 = !DILocation(line: 64, column: 27, scope: !44)
!79 = !DILocation(line: 64, column: 32, scope: !44)
!80 = !DILocation(line: 64, column: 13, scope: !44)
!81 = !DILocation(line: 66, column: 21, scope: !44)
!82 = !DILocation(line: 66, column: 27, scope: !44)
!83 = !DILocation(line: 66, column: 32, scope: !44)
!84 = !DILocation(line: 66, column: 13, scope: !44)
!85 = !DILocalVariable(name: "styl", scope: !86, file: !1, line: 73, type: !87)
!86 = distinct !DILexicalBlock(scope: !44, file: !1, line: 68, column: 13)
!87 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !88, size: 64)
!88 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !12, file: !1, line: 69, size: 32, elements: !89)
!89 = !{!90, !91, !92}
!90 = !DIDerivedType(tag: DW_TAG_member, name: "idx", scope: !88, file: !1, line: 70, baseType: !27, size: 16)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "ident", scope: !88, file: !1, line: 71, baseType: !32, size: 8, offset: 16)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "lvl", scope: !88, file: !1, line: 72, baseType: !32, size: 8, offset: 24)
!93 = !DILocation(line: 73, column: 20, scope: !86)
!94 = !DILocation(line: 74, column: 32, scope: !86)
!95 = !DILocation(line: 74, column: 24, scope: !86)
!96 = !DILocation(line: 74, column: 22, scope: !86)
!97 = !DILocation(line: 75, column: 20, scope: !98)
!98 = distinct !DILexicalBlock(scope: !86, file: !1, line: 75, column: 20)
!99 = !DILocation(line: 75, column: 26, scope: !98)
!100 = !DILocation(line: 75, column: 31, scope: !98)
!101 = !DILocation(line: 75, column: 20, scope: !86)
!102 = !DILocation(line: 76, column: 21, scope: !103)
!103 = distinct !DILexicalBlock(scope: !98, file: !1, line: 75, column: 36)
!104 = !DILocation(line: 78, column: 20, scope: !105)
!105 = distinct !DILexicalBlock(scope: !86, file: !1, line: 78, column: 20)
!106 = !DILocation(line: 78, column: 26, scope: !105)
!107 = !DILocation(line: 78, column: 30, scope: !105)
!108 = !DILocation(line: 78, column: 20, scope: !86)
!109 = !DILocation(line: 79, column: 28, scope: !110)
!110 = distinct !DILexicalBlock(scope: !105, file: !1, line: 78, column: 40)
!111 = !DILocation(line: 79, column: 34, scope: !110)
!112 = !DILocation(line: 79, column: 39, scope: !110)
!113 = !DILocation(line: 79, column: 21, scope: !110)
!114 = !DILocation(line: 81, column: 24, scope: !115)
!115 = distinct !DILexicalBlock(scope: !116, file: !1, line: 81, column: 24)
!116 = distinct !DILexicalBlock(scope: !105, file: !1, line: 80, column: 24)
!117 = !DILocation(line: 81, column: 30, scope: !115)
!118 = !DILocation(line: 81, column: 35, scope: !115)
!119 = !DILocation(line: 81, column: 24, scope: !116)
!120 = !DILocation(line: 81, column: 40, scope: !115)
!121 = !DILocation(line: 82, column: 28, scope: !116)
!122 = !DILocation(line: 82, column: 34, scope: !116)
!123 = !DILocation(line: 82, column: 45, scope: !116)
!124 = !DILocation(line: 82, column: 51, scope: !116)
!125 = !DILocation(line: 82, column: 43, scope: !116)
!126 = !DILocation(line: 82, column: 39, scope: !116)
!127 = !DILocation(line: 82, column: 21, scope: !116)
!128 = !DILocation(line: 86, column: 21, scope: !44)
!129 = !DILocation(line: 86, column: 27, scope: !44)
!130 = !DILocation(line: 86, column: 32, scope: !44)
!131 = !DILocation(line: 86, column: 13, scope: !44)
!132 = !DILocation(line: 88, column: 13, scope: !44)
!133 = !DILocation(line: 90, column: 5, scope: !12)
!134 = !DILocation(line: 91, column: 1, scope: !12)
