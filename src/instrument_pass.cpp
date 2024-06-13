#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
struct InstrumentPass : public FunctionPass {
    static char ID;
    InstrumentPass() : FunctionPass(ID) {}

    bool runOnFunction(Function &F) override {
        LLVMContext &Context = F.getContext();
        IRBuilder<> Builder(Context);

        // Declare the runtime functions to call for instrumentation
        FunctionCallee MemAccessFunc = F.getParent()->getOrInsertFunction(
            "logMemoryAccess", Type::getVoidTy(Context), Type::getInt8PtrTy(Context), Type::getInt32Ty(Context));

        FunctionCallee LockFunc = F.getParent()->getOrInsertFunction(
            "logLock", Type::getVoidTy(Context), Type::getInt8PtrTy(Context));

        FunctionCallee UnlockFunc = F.getParent()->getOrInsertFunction(
            "logUnlock", Type::getVoidTy(Context), Type::getInt8PtrTy(Context));

        for (BasicBlock &BB : F) {
            for (Instruction &I : BB) {

                if (isa<LoadInst>(&I) || isa<StoreInst>(&I)) {
                    // Instrument memory accesses
                    Value *Addr = isa<LoadInst>(&I) ? cast<LoadInst>(&I)->getPointerOperand()
                                                    : cast<StoreInst>(&I)->getPointerOperand();
                    Builder.SetInsertPoint(&I);
                    Builder.CreateCall(MemAccessFunc, {Builder.CreateBitCast(Addr, Type::getInt8PtrTy(Context)),
                                                        Builder.getInt32(isa<LoadInst>(&I) ? 0 : 1)});

                } else if (CallInst *CI = dyn_cast<CallInst>(&I)) {
                    Function *CalledFunc = CI->getCalledFunction();

                    if (CalledFunc && CalledFunc->getName() == "pthread_mutex_lock") {
                        // Instrument lock operations
                        Builder.SetInsertPoint(CI);
                        Value *LockPtr = CI->getArgOperand(0);
                        Builder.CreateCall(LockFunc, Builder.CreateBitCast(LockPtr, Type::getInt8PtrTy(Context)));

                    } else if (CalledFunc && CalledFunc->getName() == "pthread_mutex_unlock") {
                        // Instrument unlock operations
                        Builder.SetInsertPoint(CI);
                        Value *LockPtr = CI->getArgOperand(0);
                        Builder.CreateCall(UnlockFunc, Builder.CreateBitCast(LockPtr, Type::getInt8PtrTy(Context)));
                    }

                }
            }
        }
        return true;
    }
};

char InstrumentPass::ID = 0;
static RegisterPass<InstrumentPass> X("instrument-pass", "Instrument Memory and Lock Operations", false, false);

} // namespace

