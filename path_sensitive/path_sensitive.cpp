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

#include <iostream>
#include "z3++.h"
#include "block_flow.hpp"

using namespace z3;
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
	vector<PartialFlowCache*> pfcs;

    for (Function &Func: *M) {
		PartialFlowCache *pfc = new PartialFlowCache(string(Func.getName().data()));
        for (BasicBlock &BB: Func) {
			PartialFlow *pf = new PartialFlow();
			pfc->addPartialFlow(&BB, pf);
            for (Instruction &Inst: BB) {
				const DebugLoc &loc = Inst.getDebugLoc();
				if (loc) {
					unsigned int line = loc.getLine();
					if (pf->getLastLine() != line) {
						pf->addLine(line);
					}
				}
			}
			Instruction *lastInst = BB.getTerminator();
			if (lastInst->getOpcode() == Instruction::Br || lastInst->getOpcode() == Instruction::Switch) {
				for (unsigned int i = 0;i < lastInst->getNumSuccessors(); i ++) {
					BasicBlock *nextBlock = lastInst->getSuccessor(i);
					if (pfc->cached_.count(nextBlock) == 0) {
						pf->setNextBlocks(lastInst->getSuccessor(i));
					}
				}
			}
        }
		pfcs.push_back(pfc);
    }

	for (PartialFlowCache *pfc: pfcs) {
		pfc->printFlow();
	}
}
