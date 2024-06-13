clang++ -shared -fPIC -o InstrumentPass.so `llvm-config --cxxflags --ldflags --system-libs --libs core` src/instrument_pass.cpp
opt -load ./InstrumentPass.so -S -o ir/instrumented.ll ir/p18_datarace.ll
clang++ -shared -fPIC -o RuntimeLog.so src/runtime_log.cpp
clang++ -o instrumented ir/p18_datarace.ll RuntimeLog.so

# rm -rf *.so

