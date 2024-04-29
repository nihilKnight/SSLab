# Mycc(rust)

## Intro

[`mycc`](https://github.com/nihilKnight/SSLab/tree/mycc)是一个用于自动化插桩、函数调用分析、流敏感与路径敏感分析的工具。

## Quickstart 

```
$ ./mycc -h 

Usage: mycc [OPTIONS] --input-files-path <in_path>... --output-file-path [<out_path>...]

Options:
  -I, --instrumentation-program-path [<ins_path>...]  
  -C, --callgraph-program-path [<cg_path>...]         
  -P, --path-sensitive-program-path [<ps_path>...]    
  -m, --use-make                                      
  -c, --use-cached-assist-programs                    
  -x, --use-cxx-compiler                              
  -i, --input-files-path <in_path>...                 
  -o, --output-file-path [<out_path>...]              
  -h, --help                                          Print help
```

- `-I`：插桩；
- `-C`：（过程内）函数调用图分析；
- `-P`：（过程内）路径敏感分析；
- `-m`：使用makefile（待实现）；
- `-c`：使用已编译的分析工具；
- `-x`：对待分析文件使用CXX编译器（默认为C编译器）；
- `-i`：待分析文件路径列表；
- `-o`：输出文件路径；
- `-h`：帮助；

## Examples

1. 对`inputs/test.cpp`文件进行插桩，插桩程序为`assists/instrumentation.cpp`：
```
$ cargo run -- -I assists/instrumentation.cpp -x -i inputs/test.cpp -o outputs/test
    Finished dev [unoptimized + debuginfo] target(s) in 0.02s
     Running `target/debug/mycc -I assists/instrumentation.cpp -x -i inputs/test.cpp -o outputs/test`

$ outputs/test
a is: 100
b is: 50
a + b is: 50

// 再次进行插桩时，可以通过`-c`参数使用上一次插桩的已编译程序的缓存。
$ cargo run -- I -c -x -i inputs/test_p.cpp outputs/test_p
  Finished dev [unoptimized + debuginfo] target(s) in 0.02s
     Running `target/debug/mycc -I -c -x -i inputs/test.cpp -o outputs/test_p`

$ outputs/test_p
a is: 120
b is: 60
a + b is: 80
```

2. 对`inputs/callgraph/`文件夹中的程序进行函数调用分析，函数调用分析程序位于`assists/callgraph/`：
```
$ cargo run -- -C assists/callgraph/callgraph.cpp assists/callgraph/callgraph.cpp \
> -i inputs/callgraph/complex.c inputs/callgraph/fft.c inputs/callgraph/test.c \
> -o outputs/callgraph.txt
    Finished dev [unoptimized + debuginfo] target(s) in 0.02s
     Running `target/debug/mycc -C assists/callgraph/callgraph.cpp assists/callgraph/func_tree.cpp -i inputs/callgraph/complex.c inputs/callgraph/fft.c inputs/callgraph/test.c -o outputs/callgraph.txt`

$ cat outputs/callgraph.txt

> The call tree of the function `main` for traversing: 

(...)

-->main
---->malloc
---->FFT_CooleyTukey
------>malloc
------>DFT_naive
-------->malloc
-------->conv_from_polar
---------->cos
---------->sin
-------->multiply
-------->add
------>conv_from_polar
-------->cos
-------->sin
------>multiply
------>free
---->FFT_GoodThomas
------>malloc
------>DFT_naive
-------->malloc
-------->conv_from_polar
---------->cos
---------->sin
-------->multiply
-------->add
------>free
---->printf
```

3. 对`inputs/path_sensitive/`文件夹中的各`sample`文件进行路径敏感分析，路径敏感分析程序为`assists/path_sensitive_v2.cpp`：
```
$ cargo run -- -P assists/path_sensitive_v2.cpp -i inputs/path_sensitive/sample5.c -o outputs/sample5.txt
    Finished dev [unoptimized + debuginfo] target(s) in 0.03s
     Running `target/debug/mycc -P assists/path_sensitive_v2.cpp -i inputs/path_sensitive/sample5.c -o outputs/sample5.txt`

$ cat outputs/sample5.txt 
=== xls_isRecordTooSmall ===
Number of total path: 16
Number of reachable path: 16
Reachable Path:
Path 1: 46 -> 48 -> 91
Path 2: 46 -> 50 -> 91
Path 3: 46 -> 52 -> 91
Path 4: 46 -> 54 -> 91
Path 5: 46 -> 56 -> 91
Path 6: 46 -> 58 -> 59 -> 91
Path 7: 46 -> 58 -> 61 -> 91
Path 8: 46 -> 64 -> 91
Path 9: 46 -> 64 -> 91
Path 10: 46 -> 66 -> 91
Path 11: 46 -> 74 -> 75 -> 76 -> 91
Path 12: 46 -> 74 -> 75 -> 78 -> 79 -> 91
Path 13: 46 -> 74 -> 75 -> 78 -> 81 -> 91
Path 14: 46 -> 74 -> 75 -> 78 -> 81 -> 82 -> 91
Path 15: 46 -> 86 -> 91
Path 16: 46 -> 88 -> 90 -> 91
```
