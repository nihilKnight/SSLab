#include <llvm/IR/Verifier.h>
#include <llvm/IR/Argument.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/InstrTypes.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Type.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>
#include "llvm/Analysis/TargetLibraryInfo.h"
#include <llvm/IR/IRBuilder.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>

#include <vector>
#include "func_tree.hpp"

using namespace llvm;
using namespace std;

set<string> GetBuiltinFuncs(Module *M);
bool IsLLVMBuiltinFuncs(string FuncName);
void TraverseFunc(Module *M);


int main(int argc, char **argv){
	if (argc != 2) {
		cerr << "usage: " << argv[0] 
			 << " [inputFileName] " << endl;
		exit(0);
	}

	SMDiagnostic Err;
	LLVMContext Context;
	StringRef InputFileName(argv[1]);
	unique_ptr<Module> M = parseIRFile(InputFileName, Err, Context);
	if(!M) return Err.print(argv[0], errs()), 1; 

	Module *Mod = M.get();
    TraverseFunc(Mod);

	return 0;
}

set<string> GetBuiltinFuncs(Module *M) {
    const TargetLibraryInfo *TLI;
    LibFunc BuiltinFunc;
    set<string> Builtins;
    for (Function &Func: *M) {
        if (TLI->getLibFunc(Func, BuiltinFunc))
            Builtins.insert(Func.getFunction().getName().data());
    }

    return Builtins;
}

bool IsLLVMBuiltinFuncs(string FuncName) {
    string prefix = FuncName.substr(0, 4);
    return prefix == "llvm";
}

void TraverseFunc(Module *M) {
    vector<FTRoot> FTList;
    // library built-in(s).
    set<string> Builtins = GetBuiltinFuncs(M);

    // define a closure for recursion.
    function<FTRoot(Function *)> traverse;
    traverse = [&traverse](Function *Func) -> FTRoot {
        FTRoot FT;
        CreateFuncTree(&FT);
        SetFuncName(FT, Func->getName().data());
        for (BasicBlock &BB: *Func) {
            for (Instruction &Inst: BB) {
                if (Inst.getOpcode() == 56) {
                    Function *CalledFunc = cast<CallInst>(Inst).getCalledFunction();
                    // filter llvm built-in(s).
                    if (IsLLVMBuiltinFuncs(CalledFunc->getName().data()))
                        continue;
                    // if `FT` has no child or has had current child.
                    if (IsNoChild(FT) || ! SearchChildFunc(FT, CalledFunc->getName().data())) {
                        FTRoot ChildFunc = traverse(CalledFunc);
                        AddChildFunc(FT, ChildFunc);
                    }
                }
            }
        }
        return FT;
    };

    for (Function &Func: *M) {
        // filter llvm and library built-in(s).
        if (IsLLVMBuiltinFuncs(Func.getName().data()) || Builtins.count(Func.getName().data()))
            continue;
        FTList.push_back(traverse(&Func));
    }

    for (FTRoot FT: FTList) {
        if (! IsNoChild(FT)) {
            cout << "> The call tree of the function `" << FT->FuncName << "` for traversing: " << endl;
            PrintFuncTree(FT);
            cout << endl;
        }
    }
}

