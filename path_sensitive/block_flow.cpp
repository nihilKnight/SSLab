#include "block_flow.hpp"

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
        buffer << *it << (it == lines_.end()-1 ? "" : "->");
    }

    return buffer.str();
}


PartialFlowCache::PartialFlowCache() {
    return;
}

PartialFlowCache::PartialFlowCache(std::string funcName) {
    funcName_ = funcName;
    beginPartialFlow_ = nullptr;
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

void PartialFlowCache::traverseFlow() {
    if (! beginPartialFlow_) return;

    WholeFlow wf = vector<PartialFlow*>();
    function<void(PartialFlow*)> traverse;
    traverse = [wf, this, &traverse](PartialFlow *pf)mutable {
        wf.push_back(pf);
        if (pf->nextBlocks_.empty()) {
            wholeFlows_.push_back(wf);
        } else {
            for (auto nextBlock: pf->nextBlocks_) {
                traverse(this->getPartialFlow(nextBlock));
            }
        }
        wf.pop_back();
    };
    traverse(beginPartialFlow_);

}

void PartialFlowCache::printFlow() {
    if (! beginPartialFlow_) return;
    if (wholeFlows_.empty()) {
        this->traverseFlow();
    }
    cout << "[+] Function Name: " << funcName_ << endl;
    cout << "[+] Total paths: " << wholeFlows_.size() << endl;
    for (WholeFlow wf: wholeFlows_) {
        for (auto it = wf.begin(); it != wf.end(); it ++) {
            cout << (*it)->toString() << (it == wf.end()-1 ? "" : "->");
        }
        cout << endl;
    }
    cout << endl;
}

