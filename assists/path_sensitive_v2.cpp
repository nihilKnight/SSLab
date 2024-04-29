#include <llvm/ADT/SmallVector.h>
#include <llvm/ADT/Twine.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DebugLoc.h>
#include <llvm/IR/InstrTypes.h>
#include <llvm/IR/IntrinsicInst.h>
#include <llvm/IR/Value.h>
#include <llvm/Support/Casting.h>
#include <llvm/Pass.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/Verifier.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Bitcode/BitcodeWriter.h>
#include <llvm/Bitcode/BitcodeReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>
#include <iostream>
#include <string>
#include <vector>
#include <set>
#include <z3++.h>

using namespace llvm;
using namespace z3;
using std::vector;
using std::set;

int auto_var_cnt = 0;
int allPathCnt = 1;
int reachablePathCnt = 0;
vector<vector<Instruction*>> allPaths;
vector<vector<Instruction*>> reachablePaths;
vector<expr> constraints;


// converting LLVM value into z3 expression
expr convertToZ3(Value* value, context& ctx) {
    // outs() << "Converting value: " << *value << "\n";
    if (ConstantInt* const_int = dyn_cast<ConstantInt>(value)) {
        return ctx.bv_val(const_int->getValue().getSExtValue(), 64);
    }
    else if (LoadInst* li = dyn_cast<LoadInst>(value)) {
        // outs() << "LoadInst: " << li->getName() << "\n";
        return convertToZ3(li->getPointerOperand(), ctx);
    } 
    else if (AllocaInst* ai = dyn_cast<AllocaInst>(value)) {
        // outs() << "AllocaInst: " << ai->getName().str() << "\n";
        return ctx.bv_const(ai->getName().str().c_str(), 64);
    }
    else if (ZExtInst* zextOp = dyn_cast<ZExtInst>(value)) {
        return convertToZ3(zextOp->getOperand(0), ctx);
    }
    else if (BitCastInst* bc = dyn_cast<BitCastInst>(value)) {
        return convertToZ3(bc->getOperand(0), ctx);
    }
    else if (GetElementPtrInst* gep = dyn_cast<GetElementPtrInst>(value)) {
        Value* basePtr = gep->getPointerOperand();
        // outs() << "GetElementPtrBase: " << *basePtr << "\n";
        expr basePtrExpr = convertToZ3(basePtr, ctx);
        // std::cout << "GetElementPtrBaseExpr: " << basePtrExpr << "\n";
        for (Value* index : gep->indices()) {
            // outs() << "Index: " << *index << "\n";
            if (ConstantInt* indexValue = dyn_cast<ConstantInt>(index)) {
                std::string indexStr = std::to_string(indexValue->getValue().getSExtValue());
                basePtrExpr = basePtrExpr +ctx.bv_const("*.", 64) + ctx.bv_const(indexStr.c_str(), 64);
            }
            else {
                convertToZ3(index, ctx);
            }
            
            // std::cout << "Expr: " << basePtrExpr << "\n";
        }
        return basePtrExpr;
    }
    else if (BinaryOperator* bin_op = dyn_cast<BinaryOperator>(value)) {
        expr lhs = convertToZ3(bin_op->getOperand(0), ctx);
        expr rhs = convertToZ3(bin_op->getOperand(1), ctx);
        // std::cout << lhs << " " << rhs << "\n";
        switch (bin_op->getOpcode()) {
            case Instruction::Add:
                return lhs + rhs;
            case Instruction::Sub:
                return lhs - rhs;
            case Instruction::Mul:
                return lhs * rhs;
            case Instruction::SDiv:
                return lhs / rhs;
            case Instruction::UDiv:
                return udiv(lhs, rhs);
            case Instruction::SRem:
                return lhs % rhs;
            case Instruction::URem:
                return urem(lhs, rhs);
            case Instruction::Shl:
                return shl(lhs, rhs);
            case Instruction::LShr:
                return lshr(lhs, rhs);
            case Instruction::AShr:
                return ashr(lhs, rhs);
            case Instruction::And:
                return lhs & rhs;
            case Instruction::Or:
                return lhs | rhs;
            default:
                //throw std::runtime_error("Unsupported binary operator.");
                break;
        }
    }
    else if (ICmpInst* cmp_inst = dyn_cast<ICmpInst>(value)) {
        CmpInst::Predicate predicate = cmp_inst->getPredicate();
        expr lhs = convertToZ3(cmp_inst->getOperand(0), ctx);
        expr rhs = convertToZ3(cmp_inst->getOperand(1), ctx);
        // std::cout << lhs.to_string() << " " << rhs.to_string() << "\n";
        // outs() << "Converted expression types:\n" << "LHS: " << lhs.get_sort().to_string() << "\n"<< "RHS: " << rhs.get_sort().to_string() << "\n";
        switch (predicate) {
            case CmpInst::ICMP_EQ:
                return lhs == rhs;
            case CmpInst::ICMP_NE:
                return lhs != rhs;
            case CmpInst::ICMP_UGT:
                return ugt(lhs, rhs);
            case CmpInst::ICMP_ULT:
                return ult(lhs, rhs);
            case CmpInst::ICMP_UGE:
                return uge(lhs, rhs);
            case CmpInst::ICMP_ULE:
                return ule(lhs, rhs);
            case CmpInst::ICMP_SGT:
                return sgt(lhs, rhs);
            case CmpInst::ICMP_SLT:
                return slt(lhs, rhs);
            case CmpInst::ICMP_SGE:
                return sge(lhs, rhs);
            case CmpInst::ICMP_SLE:
                return sle(lhs, rhs);
            default:
                // throw std::runtime_error("Unsupported comparison predicate.");
                break;
        }
    }

    return ctx.bool_val(true);
}

void PathInfo(vector<Instruction*> path, raw_fd_ostream &outputFile){
    set<int> lineNumbers;
    for(int i = 0; i<path.size(); i++){
        DebugLoc debugLoc = path[i]->getDebugLoc();
        unsigned line = debugLoc.getLine();
            // 将行号加入结果集合
        lineNumbers.insert(line);
    }

    auto line = lineNumbers.begin();
    while(line != lineNumbers.end()){
        if (line == lineNumbers.begin()) {
            outputFile << *line;
        } else {
            outputFile << " -> " << *line;
        }
        line++;
    }
}


void AddBlockInPath(BasicBlock *bb, vector<Instruction *> *path){
    //outs() << *bb << "\n";
    for(auto &inst: *bb){
        //outs() << inst << "\n";
        if (AllocaInst* ai = dyn_cast<AllocaInst>(&inst)) {
            // 为 AllocaInst 分配一个自动名称
            ai->setName("auto_var_" + std::to_string(auto_var_cnt++));
        }
        if(auto dbg_declare = dyn_cast<DbgDeclareInst>(&inst)) // 如果是调试信息则跳过
            continue;
        if(auto debugLoc = inst.getDebugLoc()){
            path->push_back(&inst);
        }
    }
}


void GetSuccFromInst(Instruction *inst, vector<BasicBlock *> &bb_vec, vector<Instruction *> path, vector<expr> &currentConditions, context &ctx, solver &solver) {
    if(auto *br = dyn_cast<BranchInst>(inst)){
        if (br->isConditional()) {
            allPathCnt += 1;
            auto *Condition = br->getCondition();
            
            BasicBlock *TrueSuccessor = br->getSuccessor(0);
            BasicBlock *FalseSuccessor = br->getSuccessor(1);
            // 处理条件分支的后继基本块...
            bb_vec.push_back(TrueSuccessor);
            bb_vec.push_back(FalseSuccessor);
            // 按顺序添加分支条件
            currentConditions.push_back(convertToZ3(Condition, ctx));
            currentConditions.push_back(!(convertToZ3(Condition, ctx)));
        } else {
            BasicBlock *UnconditionalSuccessor = br->getSuccessor(0);
            // 处理无条件分支的后继基本块...
            bb_vec.push_back(UnconditionalSuccessor);
        } 
    }
    else if (auto *swc = dyn_cast<SwitchInst>(inst)) {
        allPathCnt += swc->getNumCases();
        // swc->getPrevNode()->print(outs());
        auto *Condition = swc->getPrevNode();
        expr z3Condition = convertToZ3(Condition, ctx);

        for (auto &Case : swc->cases()) {
            auto* caseValue = Case.getCaseValue();
            expr z3CaseValue = convertToZ3(caseValue, ctx);
            // std::cout << "caseValue: " << z3CaseValue << "\n";
            currentConditions.push_back(z3Condition == z3CaseValue);

            BasicBlock *CaseSuccessor = Case.getCaseSuccessor();
            // 处理case分支的后继基本块...
            bb_vec.push_back(CaseSuccessor);
        }

        expr z3DefaultValue = currentConditions[0];
        for(int i = 1; i < currentConditions.size(); i++){
            z3DefaultValue = z3DefaultValue && currentConditions[i];
        }
        // std::cout << "default: " << z3DefaultValue << "\n";
        currentConditions.push_back(!z3DefaultValue);
        bb_vec.push_back(swc->getDefaultDest());
    }
    else if (auto *ret = dyn_cast<ReturnInst>(inst)) {
        // for(int i = 0; i < constraints.size(); i++){
        //     std::cout << constraints[i].to_string() << "\n";
        // }
        check_result result = solver.check();
        if(result == check_result::sat){
            reachablePathCnt ++;
            model model = solver.get_model();
            // std::cout << "SAT\n";
            // for(int i = 0; i < constraints.size(); i++){
            //     std::cout << constraints[i].to_string() << ": " << model.eval(constraints[i]).to_string() << "\n";
            // }
            reachablePaths.push_back(path);
        }
        //  std::cout << "\n";
    }
}


void HandleBlock(BasicBlock *bb, vector<Instruction *> path, vector<Instruction *> pathConditions, context &ctx, solver &solver) {
    AddBlockInPath(bb, &path); // 遍历和处理指令
    Instruction *last_inst = bb->getTerminator();
    outs() << *last_inst << "\n";
    vector<BasicBlock *> bb_vec;
    vector<expr> currentConditions; 
    GetSuccFromInst(last_inst, bb_vec, path, currentConditions, ctx, solver); // 得到后继基本块集合
    // 处理每个后继基本块
    for (int i = 0; i < bb_vec.size(); i++) {
        BasicBlock *suc_bb = bb_vec[i];
        //outs() << *suc_bb << "\n";
        
        if (!currentConditions.empty()) {
            // outs() << currentConditions.size() << "\n";
            constraints.push_back(currentConditions[i]);
            solver.push();
            solver.add(currentConditions[i]);
        }
        
        HandleBlock(suc_bb, path, pathConditions, ctx, solver); // 递归函数调用
        
        if (!currentConditions.empty()){
            constraints.pop_back();
            solver.pop();
        }
    }
}

void HandleFunc(Function *func) {
    BasicBlock &entry_bb = func->getEntryBlock(); // 得到入口基本块
    vector<Instruction* > path; // 创建代码路径
    vector<Instruction*> pathConditions;
    // outs() << *func << "1\n";
    context z3Ctx; // 创建Z3上下文
    solver solver(z3Ctx);
    HandleBlock(&entry_bb, path, pathConditions, z3Ctx, solver);
}



void HandleBcFile(StringRef bc_file, StringRef new_bc_file){
    // 初始化LLVM
    LLVMContext LLVMCtx;
    SMDiagnostic err;

    std::unique_ptr<Module> mod_ptr = parseIRFile(bc_file, err, LLVMCtx);
    if(!mod_ptr){
            err.print("IR parsing failed", errs());
            return ;
    }

    Module *mod = mod_ptr.get();
    if(!mod){
            std::cout << "NLL Pointer\n";
    }

    std::error_code ec;
    raw_fd_ostream out(new_bc_file, ec);
	if(ec){
		errs() << "Error opening file: " << ec.message() << "\n";
		return;
	}

    for(auto &F: *mod){
        if (F.isDeclaration())
            continue; // 如果是外部函数则跳过

        allPathCnt = 1; 
        reachablePathCnt = 0;
        allPaths.clear();
        reachablePaths.clear();
        
        out << "=== " << F.getName() << " ===\n";

        HandleFunc(&F);
        
        out << "Number of total path: " << allPathCnt << "\n";
        out << "Number of reachable path: " << reachablePathCnt << "\n";
        out << "Reachable Path:\n";

        for(int i = 1; i <= reachablePathCnt; i++){
            out << "Path " << i << ": ";
            PathInfo(reachablePaths[i-1], out);
            out << "\n";
        }

        out << "\n";
    }


}

int main(int argc, char* argv[]){
        if (argc < 3) {
                std::cerr << "Usage: " << argv[0] << " <input_file> <output_file>\n";
                return 1;
        }

        StringRef InputFileName(argv[1]);
        StringRef OutputFileName(argv[2]);

        HandleBcFile(InputFileName, OutputFileName);

        return 0;


}
