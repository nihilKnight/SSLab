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
#include <llvm/IR/Value.h>
#include <llvm/IR/DebugLoc.h>
#include <llvm/IR/DebugInfoMetadata.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>
#include "llvm/Analysis/TargetLibraryInfo.h"
#include <llvm/IR/IRBuilder.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>

#include <iostream>
#include "block_flow.hpp"

using namespace z3;
using namespace llvm;
using namespace std;

void TraverseFunc(Module *M);
expr ConvertOperandToExpr(Value* operand, context& c);
expr LLVMInstructionToZ3Expr(Instruction* inst, context& c);

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
	config cfg;
    vector<PartialFlowCache*> pfcs;

    for (Function &Func: *M) {
		PartialFlowCache *pfc = new PartialFlowCache(string(Func.getName().data()), cfg);
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
                expr cond = LLVMInstructionToZ3Expr(&Inst, *pfc->context_);
                pfc->addBasicCondition(cond);
			}

			// append successing blocks.
			Instruction *lastInst = BB.getTerminator();
			if (lastInst->getOpcode() == Instruction::Br) {
				BranchInst *brInst = dyn_cast<BranchInst>(lastInst);
				if (brInst->isConditional()) {
					expr cond = ConvertOperandToExpr(brInst->getCondition(), *(pfc->context_));
					pf->addJumpCondition(brInst->getSuccessor(0), cond == 1);
					pf->addJumpCondition(brInst->getSuccessor(1), cond == 0);
					pf->setNextBlocks({brInst->getSuccessor(0), brInst->getSuccessor(1)});
				} else {
					pf->addJumpCondition(brInst->getSuccessor(0), pfc->context_->bool_val(true));
					pf->setNextBlocks(brInst->getSuccessor(0));
				}
			} else if (lastInst->getOpcode() == Instruction::Switch) {
				SwitchInst *swiInst = dyn_cast<SwitchInst>(lastInst);
				expr cond = ConvertOperandToExpr(swiInst->getCondition(), *(pfc->context_));
				pf->addJumpCondition(swiInst->getDefaultDest(), pfc->context_->bool_val(true));
				for (auto caseInst: swiInst->cases()) {
					expr caseCond = (cond == pfc->context_->bv_val(caseInst.getCaseValue()->getSExtValue(), cond.get_sort()));
                	pf->addJumpCondition(caseInst.getCaseSuccessor(), caseCond);
					pf->setNextBlocks(caseInst.getCaseSuccessor());
				}
			}

		    pfcs.push_back(pfc);

        }
    }

    for (PartialFlowCache *pfc: pfcs) {
        pfc->printFlow();
    }

}

expr ConvertOperandToExpr(Value* operand, z3::context &c) {
    // 检查操作数是否为常量
    if (ConstantInt* constInt = dyn_cast<ConstantInt>(operand)) {
        // cout << "const: " << constInt->getValue().getSExtValue() << " -> " << c.bv_val(constInt->getValue().getSExtValue(), 64) << endl;
        return c.bv_val(constInt->getValue().getSExtValue(), 64);
    } else {
        string str;
        raw_string_ostream stream(str);
        stream << operand;
        stream.flush();
        // cout << "variable: " << str.c_str() << endl;
        return c.bv_const(str.c_str(), 64);
    }
}

expr LLVMInstructionToZ3Expr(Instruction* inst, z3::context &c) {
    // printInst(inst);
    expr result = c.bool_val(true);
    expr lhs = c.bool_val(true);
    expr rhs1 = c.bool_val(true);
    expr rhs2 = c.bool_val(true);
    LoadInst *LI;

    // 根据不同的指令类型进行转换
    switch (inst->getOpcode()) {
        case Instruction::BinaryOps::Add:
        case Instruction::BinaryOps::Sub:
        case Instruction::BinaryOps::Mul:
        case Instruction::BinaryOps::UDiv:
        case Instruction::BinaryOps::SDiv:
        case Instruction::BinaryOps::URem:
        case Instruction::BinaryOps::SRem:
        case Instruction::BinaryOps::And:
        case Instruction::BinaryOps::Or:
        case Instruction::BinaryOps::Xor:
            // cout << "################## BinaryOperator ##################" << endl;
            // 二元运算

            lhs = ConvertOperandToExpr(inst, c);
            rhs1 = ConvertOperandToExpr(inst->getOperand(0), c);
            rhs2 = ConvertOperandToExpr(inst->getOperand(1), c);

            switch (inst->getOpcode()) {
                case Instruction::BinaryOps::Add:
                    // result = (lhs == (rhs1 + rhs2));
                    // break;
                    return (lhs == (rhs1 + rhs2));
                case Instruction::BinaryOps::Sub:
                    // result = (lhs == (rhs1 - rhs2));
                    // break;
                    return (lhs == (rhs1 - rhs2));
                case Instruction::BinaryOps::Mul:
                    // result = (lhs == (rhs1 * rhs2));
                    // break;
                    return rhs1 * rhs2;
                case Instruction::BinaryOps::UDiv:
                    // result = (lhs == (rhs1 / rhs2));
                    // break;
                    return udiv(rhs1, rhs2);
                case Instruction::BinaryOps::SDiv:
                    // result = (lhs == (rhs1 / rhs2)); // 需要考虑符号扩展
                    // break;
                    return rhs1 / rhs2;
                case Instruction::BinaryOps::URem:
                    // result = (lhs == (rhs1 % rhs2));
                    // break;
                    return urem(rhs1, rhs2);
                case Instruction::BinaryOps::SRem:
                    // result = (lhs == (rhs1 % rhs2)); // 需要考虑符号扩展
                    // break;
                    return rhs1 % rhs2;
                case Instruction::BinaryOps::And:
                    // result = (lhs == (rhs1 && rhs2));
                    // break;
                    return rhs1 & rhs2;
                case Instruction::BinaryOps::Or:
                    // result = (lhs == (rhs1 || rhs2));
                    // break;
                    return rhs1 | rhs2;
                case Instruction::BinaryOps::Xor:
                    // result = (lhs == (rhs1 ^ rhs2));
                    // break;
                    return rhs1 ^ rhs2;
                default:
                    // 其他算术运算根据需要添加
                    break;
            }
            break;
        case Instruction::ICmp:
            // cout << "################## ICmp ##################" << endl;
            // 比较运算
            lhs = ConvertOperandToExpr(inst, c);
            rhs1 = ConvertOperandToExpr(inst->getOperand(0), c);
            rhs2 = ConvertOperandToExpr(inst->getOperand(1), c);
            switch (cast<ICmpInst>(inst)->getPredicate()) {
                case ICmpInst::Predicate::ICMP_EQ:
                    // result = (lhs == (rhs1 == rhs2));
                    // break;
                    return rhs1 == rhs2;
                case ICmpInst::Predicate::ICMP_NE:
                    // result = (lhs == (rhs1 != rhs2));
                    // break;
                    return rhs1 != rhs2;
                case ICmpInst::Predicate::ICMP_SGT:
                    // result = (lhs == (rhs1 > rhs2));
                    // break;
                    return sgt(rhs1, rhs2);
                case ICmpInst::Predicate::ICMP_SGE:
                    // result = (lhs == (rhs1 >= rhs2));
                    // break;
                    return sge(rhs1, rhs2);
                case ICmpInst::Predicate::ICMP_SLT:
                    // result = (lhs == (rhs1 < rhs2));
                    // break;
                    return slt(rhs1, rhs2);
                case ICmpInst::Predicate::ICMP_SLE:
                    // result = (lhs == (rhs1 <= rhs2));
                    // break;
                    return sle(rhs1, rhs2);
                default:
                    // 其他比较运算根据需要添加
                    break;
            }
            break;
        case Instruction::Load:
            // printLoad(inst);

        default:
            // cout << "Unhandled instruction type: " << inst->getOpcodeName() << endl;
            break;
    }

    return result;
}
