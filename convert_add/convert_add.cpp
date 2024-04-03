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
#include <llvm/IR/IRBuilder.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>

using namespace llvm;

#include <iostream>

using namespace std;

static Function *CreateSpecialAddFunction(Module *M, LLVMContext &Context);
void Modify(Module *M, LLVMContext &Context);

int main(int argc, char **argv){
	if (argc != 3) {
		cerr << "usage: " << argv[0] 
			 << " [inputFileName] [OutputFileName]" << endl;
		exit(0);
	}

	SMDiagnostic Err;
	LLVMContext Context;
	StringRef InputFileName(argv[1]);
	unique_ptr<Module> M = parseIRFile(InputFileName, Err, Context);
	if(!M) return Err.print(argv[0], errs()), 1; 

	Module *Mod = M.get();
	Modify(Mod, Context);

    if (verifyModule(*M)) {
        errs() << argv[0] << ": Error modifying module!\n";
        return 1;
    }
	
	error_code Code;
	StringRef OutputFileName(argv[2]);
	raw_fd_ostream out(OutputFileName, Code);
	M->print(out, nullptr);
	out.close();
	return 0;
}

static Function *CreateSpecialAddFunction(Module *M, LLVMContext &Context) {
    // Create the Special Add function which takes two int parameters and returns an int.
    FunctionType *SpecAddTy = FunctionType::get(Type::getInt32Ty(Context), 
                {Type::getInt32Ty(Context), Type::getInt32Ty(Context)}, false);

    Function *SpecAdd = Function::Create(SpecAddTy, Function::ExternalLinkage, "spec_add", M);

    // Add a basic block to the function.
    BasicBlock *BB = BasicBlock::Create(Context, "entry_block", SpecAdd);

    // Get pointer to a constant.
    Value *OneHundred = ConstantInt::get(Type::getInt32Ty(Context), 100);

    // Get pointers to the two integer arguments.
    Argument *OperandX = &*SpecAdd->getArg(0);
    Argument *OperandY = &*SpecAdd->getArg(1);
    OperandX->setName("ope_x");
    OperandY->setName("ope_y");

    // Create "sum = x + y" in the entry_block.
    Value *Sum = BinaryOperator::CreateAdd(OperandX, OperandY, "x_plus_y", BB);

    // Create the block if condition is true or else.
    BasicBlock *SubBB = BasicBlock::Create(Context, "sub_by_100", SpecAdd);
    BasicBlock *NonSubBB = BasicBlock::Create(Context, "no_sub", SpecAdd);

    // Create Branch separated by the Condition "if (x + y > 100) goto SubByOneHundredBB".
    Value *CondInst = new ICmpInst(*BB, ICmpInst::ICMP_SGT, Sum, OneHundred, "cond");
    BranchInst::Create(SubBB, NonSubBB, CondInst, BB);

    // Create "new_sum = x + y - 100" in the SubBB.
    Value *NewSum = BinaryOperator::CreateSub(Sum, OneHundred, "new_sum", SubBB);

    // Create "return new_sum" in SubBB.
    ReturnInst::Create(Context, NewSum, SubBB);

    // Create "return sum" in NonSubBB.
    ReturnInst::Create(Context, Sum, NonSubBB);

    return SpecAdd;
}

void Modify(Module *M, LLVMContext &Context) {
    Function *SpecAdd = CreateSpecialAddFunction(M, Context);

    for (Function &Func: *M) {
        if (Func.getName() == "spec_add") continue;
        for (BasicBlock &BB: Func) {
            for (auto it = BB.begin(); it != BB.end(); it ++) {
                Instruction &Inst = *it;
                if (Inst.getOpcode() == Instruction::Add) {
                    BinaryOperator *old_value = cast<BinaryOperator>(&Inst);
                    CallInst *new_value = CallInst::Create(SpecAdd, {old_value->getOperand(0), old_value->getOperand(1)});
                    ReplaceInstWithInst(old_value->getParent()->getInstList(), it, new_value);
                    old_value->replaceAllUsesWith(new_value);
                }
            }
        }
    }
}
