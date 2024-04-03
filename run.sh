read -p "Enter starting file type ('cpp', 'i', 'll', 's', 'o') : " type

# echo "The content of test.cpp is:"
# echo ""
# cat test.cpp
# echo ""

if [ $type = "cpp" ]
then 

    echo "=============================Start from .cpp============================="

    echo "clang++ .cpp to .elf, the output is:"
    clang++ test.cpp -o clang_cpp_to_elf
    ./clang_cpp_to_elf
    echo ""

    echo "mycc .cpp to .i, then clang++ .i to .elf, the output is:"
    python3 mycc.py -E test.cpp -o mycc_cpp_to_i.i
    clang++ mycc_cpp_to_i.i -o clang_i_to_elf
    ./clang_i_to_elf
    echo ""

    echo "mycc .cpp to .ll, then clang++ .ll to .elf, the output is:"
    python3 mycc.py -S -emit-llvm test.cpp -o mycc_cpp_to_ll.ll
    clang++ mycc_cpp_to_ll.ll -o clang_ll_to_elf
    ./clang_ll_to_elf
    echo ""

    echo "mycc .cpp to .s, then clang++ .s to .elf, the output is:"
    python3 mycc.py -S test.cpp -o mycc_cpp_to_s.s
    clang++ mycc_cpp_to_s.s -o clang_s_to_elf
    ./clang_s_to_elf
    echo ""

    echo "mycc .cpp to .o, then clang++ .o to .elf, the output is:"
    python3 mycc.py -c test.cpp -o mycc_cpp_to_o.o
    clang++ mycc_cpp_to_o.o -o clang_o_to_elf
    ./clang_o_to_elf
    echo ""

    echo "mycc .cpp to .elf, the output is:"
    python3 mycc.py test.cpp -o mycc_cpp_to_elf
    ./mycc_cpp_to_elf
    echo ""

    rm mycc_* clang_* _*

elif [ $type = "i" ]
then 

    echo "=============================Start from .i==============================="

    echo "clang++ .cpp to .elf, the output is:"
    clang++ test.cpp -o clang_cpp_to_elf
    ./clang_cpp_to_elf
    echo ""

    clang++ -E test.cpp -o test.i

    echo "mycc .i to .ll, then clang++ .ll to .elf, the output is:"
    python3 mycc.py -S -emit-llvm test.i -o mycc_i_to_ll.ll
    clang++ mycc_i_to_ll.ll -o clang_ll_to_elf
    ./clang_ll_to_elf
    echo ""

    echo "mycc .i to .s, then clang++ .s to .elf, the output is:"
    python3 mycc.py -S test.i -o mycc_i_to_s.s
    clang++ mycc_i_to_s.s -o clang_s_to_elf
    ./clang_s_to_elf
    echo ""

    echo "mycc .i to .o, then clang++ .o to .elf, the output is:"
    python3 mycc.py -c test.i -o mycc_i_to_o.o
    clang++ mycc_i_to_o.o -o clang_o_to_elf
    ./clang_o_to_elf
    echo ""

    echo "mycc .i to .elf, the output is:"
    python3 mycc.py test.i -o mycc_i_to_elf
    ./mycc_i_to_elf
    echo ""

    rm mycc_* clang_* test.i _*

elif [ $type = "ll" ]
then 

    echo "=============================Start from .ll==============================="

    echo "clang++ .cpp to .elf, the output is:"
    clang++ test.cpp -o clang_cpp_to_elf
    ./clang_cpp_to_elf
    echo ""

    clang++ -S -emit-llvm test.cpp -o test.ll

    echo "mycc .ll to .s, then clang++ .s to .elf, the output is:"
    python3 mycc.py -S test.ll -o mycc_ll_to_s.s
    clang++ mycc_ll_to_s.s -o clang_s_to_elf
    ./clang_s_to_elf
    echo ""

    echo "mycc .ll to .o, then clang++ .o to .elf, the output is:"
    python3 mycc.py -c test.ll -o mycc_ll_to_o.o
    clang++ mycc_ll_to_o.o -o clang_o_to_elf
    ./clang_o_to_elf
    echo ""

    echo "mycc .ll to .elf, the output is:"
    python3 mycc.py test.ll -o mycc_ll_to_elf
    ./mycc_ll_to_elf
    echo ""

    rm mycc_* clang_* *.ll 

elif [ $type = "s" ]
then 

    echo "=============================Start from .s==============================="

    echo "clang++ .cpp to .elf, the output is:"
    clang++ test.cpp -o clang_cpp_to_elf
    ./clang_cpp_to_elf
    echo ""

    clang++ -S test.cpp -o test.s

    echo "mycc .s to .o, then clang++ .o to .elf, the output is:"
    python3 mycc.py -c test.s -o mycc_s_to_o.o
    clang++ mycc_s_to_o.o -o clang_o_to_elf
    ./clang_o_to_elf
    echo ""

    echo "mycc .s to .elf, the output is:"
    python3 mycc.py test.s -o mycc_s_to_elf
    ./mycc_s_to_elf
    echo ""

    rm mycc_* clang_* test.s

elif [ $type = "o" ]
then 

    echo "=============================Start from .o==============================="

    echo "clang++ .cpp to .elf, the output is:"
    clang++ test.cpp -o clang_cpp_to_elf
    ./clang_cpp_to_elf
    echo ""

    clang++ -c test.cpp -o test.o

    echo "mycc .o to .elf, the output is:"
    python3 mycc.py test.o -o mycc_o_to_elf
    ./mycc_o_to_elf
    echo ""

    rm mycc_* clang_* test.o

fi

