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

pub fn compile_assist_program(_some_path: Vec<&String>, _assist_type: AssistProgram) {
    let _argus: String = _some_path.iter().map(|s| &***s).collect::<Vec<_>>().join(" ");

    let llvm_cxx_lib = String::from_utf8(Command::new("llvm-config")
            .arg("--cxxflags")
            .arg("--libs")
            .output().unwrap().stdout).unwrap()
            .replace("\n", " ")
            .split(" ")
            .map(|s| s.replace(" ", ""))
            .filter(|s| !s.is_empty())
            .collect::<Vec<_>>();

    // println!("llvm cxx lib: {:?}", llvm_cxx_lib);

    Command::new("clang++")
            .arg(_argus)
            .arg(&llvm_cxx_lib[0])
            .arg(&llvm_cxx_lib[llvm_cxx_lib.len()-1])
            .arg("-o")
            .arg(match _assist_type {
                AssistProgram::Instrumentation => _TMP_INS,
                AssistProgram::Callgraph => _TMP_CG,
                AssistProgram::PathSensitive => _TMP_PS
            }).output().unwrap();

    // println!("command of clang++: {:?}", clangxx);
    // println!("err of clang++: {}", String::from_utf8(clangxx.output().unwrap().stderr).unwrap());
    
}

    // Command::new("clang++")
    //     .arg("-S")
    //     .arg("-emit-llvm")
    //     .arg(arg)
    //     .arg("-o")
    //     .arg("_tmp.ll").output().unwrap();
