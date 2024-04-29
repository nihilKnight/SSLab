#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>
#include <vector>
#include "z3++.h"
#include <fstream>
#include <iostream>
#include <map>
#include <set>

using namespace llvm;
using namespace std;
using namespace z3;

uint reachablePathCount = 0;
uint unReachablePathCount = 0;

// Structure for the path
typedef struct {
    vector<uint> pathLine;
} PathInfo;

PathInfo createPath();  // new empty path
void HandleFunction(Function* func, context& c);
void HandleBlock(BasicBlock* bb, PathInfo path, context& c, solver s);
void AddBlockInPath(BasicBlock* bb, PathInfo& path, context& c, solver& s);
void PrintPath(PathInfo path);
void GetSuccFromInst(Instruction* last_inst, vector<pair<BasicBlock*, expr>>& bb_cond_vec, context& c);
expr LLVMInstructionToZ3Expr(Instruction* inst, context& c);

expr ConvertOperandToExpr(Value* operand, context& c);
void printInst(Instruction *inst);
void printLoad(Instruction *inst);

int main(int argc, char** argv) {
    if (argc != 2) {
        cerr << "usage: " << argv[0]
             << " [inputFileName]" << endl;
        exit(0);
    }

    cout << "Analysing..." << endl;
    SMDiagnostic Err;
    LLVMContext Context;
    StringRef InputFileName(argv[1]);
    unique_ptr<Module> M = parseIRFile(InputFileName, Err, Context);
    if (!M)
        return Err.print(argv[0], errs()), 1;

    for (auto& fun : *M) {
        reachablePathCount = 0;
        unReachablePathCount = 0;
        cout << "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv" << endl;
        if (fun.isDeclaration()) {
            cout << fun.getName().str()<< ", a function just being declared. No path. "  << endl;
            cout << "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^" << endl;
            cout << "\n\n";
            continue;
        }
        context c;
        HandleFunction(&fun, c);
        cout << "- - - - - - - - - - - - - - - - - - - - " << endl;
        cout << "Total Paths Count is : " << reachablePathCount + unReachablePathCount << endl;
        cout << "Reachable path count is : " << reachablePathCount << endl;
        cout << "Unreachable path count is : " << unReachablePathCount << endl;
        cout << "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^" << endl;
        cout << "\n\n";
    }

    return 0;
}

PathInfo createPath() {
    PathInfo PathInfoStore = {};
    return PathInfoStore;
}

void HandleFunction(Function* func, context& c) {
    cout << func->getName().str() << endl;
    cout << "------------------------------------------------------------" << endl;
    BasicBlock& entry_bb = func->getEntryBlock();
    solver s(c);
    PathInfo path = createPath();
    HandleBlock(&entry_bb, path, c, s);
}

void HandleBlock(BasicBlock* bb, PathInfo path, context& c, solver s) {
    AddBlockInPath(bb, path, c, s);
    Instruction* last_inst = bb->getTerminator();

    if (ReturnInst *retInst = dyn_cast<ReturnInst>(last_inst)) {
        if (s.check() == sat) {
            cout << "Reachable path: ";
            reachablePathCount ++;
        } else {
            cout << "Unreachable path: ";
            unReachablePathCount ++;
        }

        PrintPath(path);
        return;
    }
    vector<pair<BasicBlock*, expr>> bb_cond_vec;
    GetSuccFromInst(last_inst, bb_cond_vec, c);

    for (int i = 0; i < bb_cond_vec.size(); i++) {
        BasicBlock* suc_bb = bb_cond_vec[i].first;
        s.add(bb_cond_vec[i].second);
        // cout << bb_cond_vec[i].second << endl;
        HandleBlock(suc_bb, path, c, s);
        s.pop();
    }
}

void AddBlockInPath(BasicBlock* bb, PathInfo& path, context& c, solver& s) {
    uint last_line = 0;
    for (Instruction& inst : *bb) {
        // printInst(&inst);
        DILocation* debugLoc = inst.getDebugLoc();
        if (debugLoc) {
            if (last_line != debugLoc->getLine()) {
                path.pathLine.push_back(debugLoc->getLine());
                last_line = debugLoc->getLine();
            }
            expr constraint = LLVMInstructionToZ3Expr(&inst, c);
            // cout << constraint << endl;
            s.add(constraint);
        }
    }
    // cout << endl;
}

void PrintPath(PathInfo path) {
    for (int i=0; i<path.pathLine.size(); i++) {
        if (i>0) {
            cout << "->";
        }
        cout << path.pathLine[i];
    }
    cout << endl;
}

void GetSuccFromInst(Instruction* last_inst, vector<pair<BasicBlock*, expr>>& bb_cond_vec, context& c) {
    unsigned op_code = last_inst->getOpcode();
    switch (op_code) {
        case Instruction::Br: {
            // 如果是分支指令 (Branch)，获取所有可能的后继基本块
            BranchInst* brInst = dyn_cast<BranchInst>(last_inst);
            if (brInst->isConditional()) {
                // 条件分支指令，有两个后继基本块
                expr cond = ConvertOperandToExpr(brInst->getCondition(), c);
                // cout << (cond == 1) << endl;
                bb_cond_vec.emplace_back(brInst->getSuccessor(0), cond == 1); // 添加第一个后继基本块及条件
                bb_cond_vec.emplace_back(brInst->getSuccessor(1), cond == 0); // 添加第二个后继基本块及条件
            } else {
                // 无条件分支指令，只有一个后继基本块
                bb_cond_vec.emplace_back(brInst->getSuccessor(0), c.bool_val(true)); // 添加后继基本块及条件为真
            }
            break;
        }
        case Instruction::Switch: {
            // 如果是 Switch 指令，获取所有可能的后继基本块
            SwitchInst* switchInst = dyn_cast<SwitchInst>(last_inst);
            expr cond = ConvertOperandToExpr(switchInst->getCondition(), c);
            // 添加默认后继基本块及条件
            bb_cond_vec.emplace_back(switchInst->getDefaultDest(), c.bool_val(true));
            // 添加其他 case 后继基本块及条件
            for (auto &caseInst : switchInst->cases()) {
                expr caseCond = (cond == c.bv_val(caseInst.getCaseValue()->getSExtValue(), cond.get_sort()));
                bb_cond_vec.emplace_back(caseInst.getCaseSuccessor(), caseCond);
            }
            break;
        }
        default:
            // 如果不是分支指令、Switch 指令，不添加任何后继基本块
            break;
    }
}



// 将操作数转换为 Z3 表达式的函数
expr ConvertOperandToExpr(Value* operand, context& c) {
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

void printInst(Instruction* inst) {
    string str;
    raw_string_ostream ss(str); // 使用 print 方法将指令输出到流中
    ss << *inst;
    // cout << inst->getOpcodeName() << " instruction: " << ss.str() << "\n";
}

void printLoad(Instruction *inst){
    LoadInst* loadInst = dyn_cast<LoadInst>(inst);
    // cout << "左侧标识符: " << loadInst << endl;
    // cout << "指向的地址: " << loadInst->getOperand(0) << endl;
    string str;
    raw_string_ostream stream(str);
    stream << loadInst;
    stream.flush();
    // cout << str << endl;
}

expr LLVMInstructionToZ3Expr(Instruction* inst, context& c) {
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
                    result = (lhs == (rhs1 + rhs2));
                    break;
                case Instruction::BinaryOps::Sub:
                    result = (lhs == (rhs1 - rhs2));
                    break;
                case Instruction::BinaryOps::Mul:
                    result = (lhs == (rhs1 * rhs2));
                    break;
                case Instruction::BinaryOps::UDiv:
                    result = (lhs == (rhs1 / rhs2));
                    break;
                case Instruction::BinaryOps::SDiv:
                    result = (lhs == (rhs1 / rhs2)); // 需要考虑符号扩展
                    break;
                case Instruction::BinaryOps::URem:
                    result = (lhs == (rhs1 % rhs2));
                    break;
                case Instruction::BinaryOps::SRem:
                    result = (lhs == (rhs1 % rhs2)); // 需要考虑符号扩展
                    break;
                case Instruction::BinaryOps::And:
                    result = (lhs == (rhs1 && rhs2));
                    break;
                case Instruction::BinaryOps::Or:
                    result = (lhs == (rhs1 || rhs2));
                    break;
                case Instruction::BinaryOps::Xor:
                    result = (lhs == (rhs1 ^ rhs2));
                    break;
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
                    result = (lhs == (rhs1 == rhs2));
                    break;
                case ICmpInst::Predicate::ICMP_NE:
                    result = (lhs == (rhs1 != rhs2));
                    break;
                case ICmpInst::Predicate::ICMP_SGT:
                    result = (lhs == (rhs1 > rhs2));
                    break;
                case ICmpInst::Predicate::ICMP_SGE:
                    result = (lhs == (rhs1 >= rhs2));
                    break;
                case ICmpInst::Predicate::ICMP_SLT:
                    result = (lhs == (rhs1 < rhs2));
                    break;
                case ICmpInst::Predicate::ICMP_SLE:
                    result = (lhs == (rhs1 <= rhs2));
                    break;
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
    printInst(inst);
    // cout << "result = " << result << endl;
    return result;
}
