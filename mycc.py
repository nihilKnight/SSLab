import subprocess
import argparse


    #########################################################################################
    #                                                                                       #
    #    Only the behaviors below need construmentation:                                    #
    #    1. some.cpp  -->  some.ll/some.s/some.o/some.elf (-S -emit-llvm, -S, -c, (none))   #
    #    2. some.i  -->  some.ll/some.s/some.o/some.elf (-S -emit-llvm, -S, -c, (none))     #
    #    3. some.ll  -->  some.s/some.o/some.elf (-S, -c, (none))                           #
    #                                                                                       #
    #########################################################################################


def Instrumentation(input_file: list, some_arguments: list, output_file: str, is_link: bool):
    input_type = input_file[0].split('.')[1]
    def ConductOneTime(file: str, tmp_name: str, new_tmp_name: str):
        if input_type == 'll':
            # Conduct some.ll --> some.ll* --> some.(output_type)
            subprocess.run(["./convert_add/convert_add", file, new_tmp_name])
        else:
            # Conduct some.cpp/some.i --> some.ll --> some.ll* --> some.(output_type)
            subprocess.run(["clang++", "-S", "-emit-llvm", file, "-o", tmp_name])
            subprocess.run(["./convert_add/convert_add", tmp_name, new_tmp_name])

    if not is_link:
        ConductOneTime(input_file[0], "tmp.ll", "new_tmp.ll")
        subprocess.run(["clang++"] + some_arguments + ["new_tmp.ll"] + ([] if not output_file else ["-o", output_file]))
        subprocess.run(["rm", "-f", "tmp.ll", "new_tmp.ll"])
    else:
        input_names = [file.split('.')[0] for file in input_file]
        [ConductOneTime(name + '.' + input_type, f"_{name}.ll", f"__{name}.ll") for name in input_names]
        subprocess.run(["clang++"] + [f"__{name}.ll" for name in input_names] + ([] if not output_file else ["-o", output_file]))
        subprocess.run(["rm", "-rf", "_*"])


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Wrapper for instrumentation which converts normal add to special add.")
    parser.add_argument('infile', nargs='+', type=argparse.FileType('r'))                   # Variadic input file(s) (.cpp .i .ll .s .o).
    parser.add_argument('-E', '--preprocess', action="store_true")                          # Preprocess flag (input .cpp file, output .i file).
    parser.add_argument('-emit-llvm', '--llvm_representation', action='store_true')         # LLVM representation flag
                                                                                            #                 (input .cpp/.i file, output .ll file).
    parser.add_argument('-S', '--preprocess_and_compile', action='store_true')              # Preprocess and complie flag
                                                                                            #                 (input .cpp/.i/.ll file, output .s file).
    parser.add_argument('-c', '--preprocess_compile_and_assemble', action='store_true')     # Preprocess, compile and assemble flag
                                                                                            #                 (input .cpp/.i/.ll/.s file, output .o file).
    parser.add_argument('-o', '--output_file')                                              # None of the above flag is set indicates link flag
                                                                                            #                 (input .cpp/.i/.ll/.s/.o file, output .elf file).

    args = parser.parse_args()
    files = [file.name for file in args.infile]
    # Assuming the input files share the same type.
    file_type = args.infile[0].name.split('.')[1]

    if file_type in ["cpp", "i", "ll"]:
        if not (args.preprocess or args.llvm_representation or args.preprocess_and_compile or args.preprocess_compile_and_assemble):
            # Link flag.
            Instrumentation(files, None, args.output_file, True)
        else:
            some_arguments = ["-c"] if args.preprocess_compile_and_assemble else (
                (["-S"] + (["-emit-llvm"] if args.llvm_representation else [])) if args.preprocess_and_compile else []
            )
            if some_arguments:
                Instrumentation(files, some_arguments, args.output_file, False)
            elif args.preprocess:
                subprocess.run(["clang++", "-E"] + files + ([] if not args.output_file else ["-o", args.output_file]))
    elif file_type in ["s", "o"]:
        subprocess.run(["clang++"] + (["-c"] if args.preprocess_compile_and_assemble else []) + files + ([] if not args.output_file else ["-o", args.output_file]))
