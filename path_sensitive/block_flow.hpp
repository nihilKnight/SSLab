#pragma once

#include <llvm/IR/BasicBlock.h>
#include <string>
#include <sstream>
#include <vector>
#include <map>

class PartialFlow {
public:

    void addLine(unsigned int line);
    void addLine(std::vector<unsigned int> lines);
    // returns 0 if no line was added.
    unsigned int getLastLine();
    void setNextBlocks(llvm::BasicBlock *next);
    void setNextBlocks(std::vector<llvm::BasicBlock*> nexts);
    std::string toString();

// private:
    std::vector<unsigned int> lines_;
    // stores the blocks' first line which might be targeted to. Empty means terminator block.
    std::vector<llvm::BasicBlock*> nextBlocks_;
};

class PartialFlowCache {
public:

    // return false if `newFlow` has no line added.
    void addPartialFlow(llvm::BasicBlock *BB, PartialFlow *newFlow);
    PartialFlow *getPartialFlow(llvm::BasicBlock *BB);

// private:
    // map the first line of partial flow to its pointer.
    std::map<llvm::BasicBlock*, PartialFlow*> cached_;
    PartialFlow *beginPartialFlow_;

    friend class PartialFlow;
};

typedef std::vector<PartialFlow*> WholeFlow;
