#include <llvm/IR/Verifier.h>
#include <llvm/IR/Argument.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/InstrTypes.h>
#include "llvm/IR/InstIterator.h"
#include <llvm/IR/Instructions.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/DebugLoc.h>
#include <llvm/IR/DebugInfoMetadata.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>
#include "llvm/Analysis/TargetLibraryInfo.h"
#include <llvm/IR/IRBuilder.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>

#include <vector>
#include <iostream>

using namespace llvm;
using namespace std;

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

void TraverseFunc(Module *M) {
    for (Function &Func: *M) {
        for (inst_iterator I = inst_begin(Func), E = inst_end(Func); I != E; ++ I) {
            for (Use &U: I->operands()) {
                Value *V = U.get();
                Instruction *Inst = dyn_cast<Instruction>(V);
                const llvm::DebugLoc &D = Inst->getDebugLoc();
                cout << D->getLine() << endl;
            }
        }
    }
}
