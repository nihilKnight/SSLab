#pragma once

#include <llvm/IR/BasicBlock.h>
#include <functional>
#include <string>
#include <sstream>
#include <iostream>
#include <vector>
#include <map>

#include "z3++.h"

// path flow of a basic block.
class PartialFlow {
public:

    void addLine(unsigned int line);
    void addLine(std::vector<unsigned int> lines);
    // returns 0 if no line was added.
    unsigned int getLastLine();
    void setNextBlocks(llvm::BasicBlock *next);
    void setNextBlocks(std::vector<llvm::BasicBlock*> nexts);
    void addJumpCondition(llvm::BasicBlock *next, z3::expr expression);
    z3::expr getJumpCondition(llvm::BasicBlock *next);
    std::string toString();

// private:
    std::vector<unsigned int> lines_;
    // stores the blocks' first line which might be targeted to. Empty means terminator block.
    std::vector<llvm::BasicBlock*> nextBlocks_;
    // stores the conditions leading to other blocks.
    std::map<llvm::BasicBlock*, z3::expr> conditions_;
};

// path flow of a whole function.
class PartialFlowCache {
public:

    PartialFlowCache(std::string funcName, z3::config &cfg);
    void addPartialFlow(llvm::BasicBlock *BB, PartialFlow *newFlow);
    bool havePartialFlow(llvm::BasicBlock *BB);
    PartialFlow *getPartialFlow(llvm::BasicBlock *BB);
    void addBasicCondition(z3::expr expression);
    void popBasicCondition();
    bool calcCondition();
    void traverseFlow();
    void printFlow();

// private:
    // map the first line of partial flow to its pointer.
    std::map<llvm::BasicBlock*, PartialFlow*> cached_;
    PartialFlow *beginPartialFlow_;
    std::string funcName_;
    std::vector<std::vector<PartialFlow*>> totalFlows_;
    std::vector<std::vector<PartialFlow*>> reachableFlows_;
    std::shared_ptr<z3::context> context_;
    std::unique_ptr<z3::solver> solver_;

    friend class PartialFlow;
};

typedef std::vector<PartialFlow*> WholeFlow;
