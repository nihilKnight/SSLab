#include "func_tree.hpp"

int main() {
    FTRoot FT, ChildFT_1, ChildFT_2, ChildFT_3;

    CreateFuncTree(&FT);
    CreateFuncTree(&ChildFT_1);
    CreateFuncTree(&ChildFT_2);
    CreateFuncTree(&ChildFT_3);

    SetFuncName(FT, "main");
    SetFuncName(ChildFT_1, "hello_A");
    SetFuncName(ChildFT_2, "hello_B");
    SetFuncName(ChildFT_3, "hello_C");

    AddFuncChild(FT, ChildFT_1);
    AddFuncChild(ChildFT_1, ChildFT_2);
    AddFuncChild(ChildFT_2, ChildFT_3);

    PrintFuncTree(FT);

    std::cout << SearchChildTree(ChildFT_2, "hello_C") << std::endl;

    return 0;
}