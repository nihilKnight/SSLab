# Call Graph maker

## Quickstart 

Run:
```
$ clang++ $(llvm-config --cxxflags --libs) call_graph_maker.cpp func_tree.cpp -o call_graph_maker
$ ./call_graph_maker test_ll/test.ll > output.txt
```


