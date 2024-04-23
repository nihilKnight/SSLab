#include "block_flow.hpp"
#include <iostream>

using namespace std;
using namespace llvm;

void PartialFlow::addLine(unsigned int line) {
    lines_.push_back(line);
}

void PartialFlow::addLine(vector<unsigned int> lines) {
    lines_.insert(lines_.end(), lines.begin(), lines.end());
}

unsigned int PartialFlow::getLastLine() {
    return lines_.empty() ? 0 : *(lines_.end()-1);
}

void PartialFlow::setNextBlocks(BasicBlock *next) {
    nextBlocks_.push_back(next);
}

void PartialFlow::setNextBlocks(vector<BasicBlock*> nexts) {
    nextBlocks_.insert(nextBlocks_.begin(), nexts.begin(), nexts.end());
}

string PartialFlow::toString() {
    stringstream buffer;
    for (auto it = lines_.begin(); it != lines_.end(); it ++ ) {
        buffer << *it << ( it == lines_.end()-1 ? "" : "->");
    }

    return buffer.str();
}


void PartialFlowCache::addPartialFlow(BasicBlock *BB, PartialFlow *newFlow) {
    if (cached_.empty()) {
        beginPartialFlow_ = newFlow;
    }
    cached_.insert(pair<BasicBlock*, PartialFlow*>(BB, newFlow));
}

PartialFlow* PartialFlowCache::getPartialFlow(BasicBlock *BB) {
    return cached_.at(BB);
}
