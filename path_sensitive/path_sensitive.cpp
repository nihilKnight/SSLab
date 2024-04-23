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
#include <functional>

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
		PartialFlowCache *pfc = new PartialFlowCache();
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
				// if the instruction is `Br`.
				if (Inst.getOpcode() == Instruction::Br) {
					BranchInst &bri = cast<BranchInst>(Inst);
					if (bri.isConditional()) {
						BasicBlock *false_dst = cast<BasicBlock>(bri.getOperand(1));
						BasicBlock *true_dst = cast<BasicBlock>(bri.getOperand(2));
						pf->setNextBlocks(vector<BasicBlock*>({false_dst, true_dst}));
					}
				}
			}
        }
		pfcs.push_back(pfc);
    }

	// for (pair<BasicBlock*, PartialFlow*> bpPair: (**pfcs.begin()).cached_) {
	// 	cout << "BasicBlock `" << bpPair.first << "` flow: ";
	// 	cout << bpPair.second->toString() << endl;
	// }
	for (PartialFlowCache *pfc: pfcs) {
		PartialFlow *beginPartialFlow = pfc->beginPartialFlow_;
		WholeFlow wf = vector<PartialFlow*>({beginPartialFlow});
		std::function<void(PartialFlow *)> printFlow;
		printFlow = [wf, pfc, printFlow](PartialFlow *pf)mutable {
			wf.push_back(pf);
			for (auto nextBlock: pf->nextBlocks_) {
				printFlow(pfc->getPartialFlow(nextBlock));
			}
		};

	}
}
