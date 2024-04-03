#include "func_tree.hpp"

void CreateFuncTree(FTRoot *FT) {
    *FT = (FuncTreeNode *)malloc(sizeof(FuncTreeNode));
    (*FT)->FuncName = (char *)malloc(FUNC_NAME_MAX_LEN * sizeof(char));
    (*FT)->ChildList = (FTRoot *)malloc(CHILD_LIST_MAX_LEN * sizeof(FTRoot));
    (*FT)->Top = 0;
}

void SetFuncName(FTRoot FT, const char* FuncName) {
    strncpy(FT->FuncName, FuncName, FUNC_NAME_MAX_LEN);
    FT->FuncName[FUNC_NAME_MAX_LEN-1] = '\0';
}

bool IsNoChild(FTRoot FT) {
    return !FT->Top;
}

bool AddChildFunc(FTRoot ParentFT, FTRoot ChildFT) {
    if (ParentFT->Top < CHILD_LIST_MAX_LEN - 1) {
        ParentFT->ChildList[ParentFT->Top++] = ChildFT;
        return true;
    } else
        return false;
}

bool DelChildFunc(FTRoot FT) {
    if (FT->Top > 0) {
        FT->Top --;
        return true;
    } else 
        return false;
}

void PrintFuncTree(FTRoot FT) {
    char *buffer = (char *)malloc(2*(CHILD_LIST_MAX_LEN+1) * sizeof(char));
    int pos = 0;

    std::function<void(FTRoot)> print;
    print = [buffer, pos, &print](FTRoot FT)mutable {
        std::cout << "-->" << FT->FuncName << std::endl;
        strncpy(buffer + pos, "--", 2);
        pos += 2;
        buffer[pos] = '\0';
        for (int i = 0; i < FT->Top; i ++) {
            std::cout << buffer;
            print(FT->ChildList[i]);
        }
        pos -= 2;
        buffer[pos] = '\0';
    };

    print(FT);

}

bool SearchChildFunc(FTRoot ParentFT, const char *ChildFuncName) {
    if (! ParentFT->Top)
        return false;
    
    for (int i = 0; i < ParentFT->Top; i ++) {
        if (! strcmp(ParentFT->ChildList[i]->FuncName, ChildFuncName))
            return true;
    }

    return false;
}
