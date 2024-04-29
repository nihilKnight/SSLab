#include "block_flow.hpp"

using namespace std;
using namespace llvm;
using namespace z3;

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

void PartialFlow::addJumpCondition(BasicBlock *next, expr expression) {
    conditions_.insert(pair<BasicBlock*, expr>(next, expression));
}

expr PartialFlow::getJumpCondition(BasicBlock *next) {
    return conditions_.at(next);
}

string PartialFlow::toString() {
    stringstream buffer;
    for (auto it = lines_.begin(); it != lines_.end(); it ++ ) {
        buffer << *it << (it == lines_.end()-1 ? "" : "->");
    }

    return buffer.str();
}


PartialFlowCache::PartialFlowCache(string funcName, config &cfg) {
    funcName_ = funcName;
    beginPartialFlow_ = nullptr;
    context_ = make_shared<context>(cfg);
    solver_ = make_unique<solver>(*context_);
}

void PartialFlowCache::addPartialFlow(BasicBlock *BB, PartialFlow *newFlow) {
    if (cached_.empty()) {
        beginPartialFlow_ = newFlow;
    }
    cached_.insert(pair<BasicBlock*, PartialFlow*>(BB, newFlow));
}

bool PartialFlowCache::havePartialFlow(BasicBlock *BB) {
    return cached_.count(BB) >= 1;
}

PartialFlow *PartialFlowCache::getPartialFlow(BasicBlock *BB) {
    return cached_.at(BB);
}

void PartialFlowCache::addBasicCondition(expr expression) {
    solver_->add(expression);
}

void PartialFlowCache::popBasicCondition() {
    solver_->pop();
}

bool PartialFlowCache::calcCondition() {
    return solver_->check() == sat;
}

void PartialFlowCache::traverseFlow() {
    if (! beginPartialFlow_) return;

    WholeFlow wf = vector<PartialFlow*>();
    std::function<void(PartialFlow*)> traverse;
    traverse = [wf, this, &traverse](PartialFlow *pf)mutable {
        wf.push_back(pf);
        if (pf->nextBlocks_.empty()) {
            totalFlows_.push_back(wf);
            if (this->calcCondition()) {
                reachableFlows_.push_back(wf);
            }
        } else {
            for (auto nextBlock: pf->nextBlocks_) {
                expr cond = pf->getJumpCondition(nextBlock);
                this->addBasicCondition(cond);
                traverse(this->getPartialFlow(nextBlock));
                this->popBasicCondition();
            }
        }
        wf.pop_back();
    };
    traverse(beginPartialFlow_);

}

void PartialFlowCache::printFlow() {
    if (! beginPartialFlow_) return;
    if (totalFlows_.empty()) {
        this->traverseFlow();
    }
    cout << "[+] Function Name: " << funcName_ << endl;
    cout << "[+] Total paths: " << totalFlows_.size() << endl;
    for (WholeFlow wf: totalFlows_) {
        for (auto it = wf.begin(); it != wf.end(); it ++) {
            cout << (*it)->toString() << (it == wf.end()-1 ? "" : "->");
        }
        cout << endl;
    }

    cout << "[+] Reachable path: " << reachableFlows_.size() << endl;
    for (WholeFlow wf: reachableFlows_) {
        for (auto it = wf.begin(); it != wf.end(); it ++) {
            cout << (*it)->toString() << (it == wf.end()-1 ? "" : "->");
        }
        cout << endl;
    }

    cout << endl;
}


