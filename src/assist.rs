use std::process::Command;

const _TMP_INS: &str = "_tmp_ins";
const _TMP_CG: &str = "_tmp_cg";
const _TMP_PS: &str = "_tmp_ps";
const _TMP_LL: &str = "_tmp_ll.ll";

pub enum AssistProgram {
    Instrumentation,
    Callgraph,
    PathSensitive
}

pub fn compile_assist_program(some_path: Vec<&String>, assist_type: AssistProgram) {
    let argus: String = some_path.iter().map(|s| &***s).collect::<Vec<_>>().join(" ");
    let mut clang_llvm = Command::new("clang++");
            clang_llvm
            .arg("$(llvm-config --cxxflags --libs)")
            .arg(argus)
            .arg("-o")
            .arg(match assist_type {
                AssistProgram::Instrumentation => _TMP_INS,
                AssistProgram::Callgraph => _TMP_CG,
                AssistProgram::PathSensitive => _TMP_PS
            });
    
    println!("{:?}", clang_llvm);
    let output = String::from_utf8(clang_llvm.output().unwrap().stderr).unwrap();
    println!("{}", output);
    // let ll = Command::new("ls").arg("-l").arg("|").arg("grep").arg("\"_tmp\"").output().unwrap();
    // println!("{}", String::from_utf8(ll.stdout).unwrap());
}

    // Command::new("clang++")
    //     .arg("-S")
    //     .arg("-emit-llvm")
    //     .arg(arg)
    //     .arg("-o")
    //     .arg("_tmp.ll").output().unwrap();
