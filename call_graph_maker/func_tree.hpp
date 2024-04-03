#pragma once

#include <iostream>
#include <cstring>
#include <functional>

#define CHILD_LIST_MAX_LEN 10
#define FUNC_NAME_MAX_LEN 20

typedef struct FuncTreeNode {
    char *FuncName;
    FuncTreeNode **ChildList;
    int Top;
} *FTRoot;


void CreateFuncTree(FTRoot *FT);
void SetFuncName(FTRoot FT, const char* FuncName);
bool IsNoChild(FTRoot FT);
bool AddChildFunc(FTRoot ParentFT, FTRoot ChildFT);
bool DelChildFunc(FTRoot FT);
void PrintFuncTree(FTRoot FT);
bool SearchChildFunc(FTRoot ParentFT, const char *ChildFuncName);
