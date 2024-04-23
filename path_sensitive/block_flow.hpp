#pragma once

#include <llvm/IR/BasicBlock.h>
#include <functional>
#include <string>
#include <sstream>
#include <iostream>
#include <vector>
#include <map>

#include "z3++.h"

class PartialFlow {
public:

    void addLine(unsigned int line);
    void addLine(std::vector<unsigned int> lines);
    // returns 0 if no line was added.
    unsigned int getLastLine();
    void setNextBlocks(llvm::BasicBlock *next);
    void setNextBlocks(std::vector<llvm::BasicBlock*> nexts);
    void addCondition();
    std::string toString();

// private:
    std::vector<unsigned int> lines_;
    // stores the blocks' first line which might be targeted to. Empty means terminator block.
    std::vector<llvm::BasicBlock*> nextBlocks_;
    // stores the conditions leading to other blocks.
    std::map<llvm::BasicBlock*, z3::expr> conditions_;
};

class PartialFlowCache {
public:

    // return false if `newFlow` has no line added.
    PartialFlowCache();
    PartialFlowCache(std::string funcName);
    void addPartialFlow(llvm::BasicBlock *BB, PartialFlow *newFlow);
    PartialFlow *getPartialFlow(llvm::BasicBlock *BB);
    void traverseFlow();
    void printFlow();

// private:
    // map the first line of partial flow to its pointer.
    std::map<llvm::BasicBlock*, PartialFlow*> cached_;
    PartialFlow *beginPartialFlow_;
    std::string funcName_;
    std::vector<std::vector<PartialFlow*>> wholeFlows_;

    friend class PartialFlow;
};

typedef std::vector<PartialFlow*> WholeFlow;
