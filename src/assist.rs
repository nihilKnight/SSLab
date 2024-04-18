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

// the function compiling the asssit program to `_tmp_some` executable.
pub fn compile_assist_program(some_path: Vec<&String>, assist_type: AssistProgram) -> Result<(), String> {
    let _argus: String = some_path.iter().map(|s| &***s).collect::<Vec<_>>().join(" ");

    // get the llvm config lib of the current environment.
    let llvm_cxx_lib = String::from_utf8(Command::new("llvm-config")
            .arg("--cxxflags")
            .arg("--libs")
            .output().unwrap().stdout).unwrap()
            .replace("\n", " ")
            .split(" ")
            .map(|s| s.replace(" ", ""))
            .filter(|s| !s.is_empty())
            .collect::<Vec<_>>();

    // complie the assist program through clang++.
    let cmd_res = Command::new("clang++")
            .arg(_argus)
            .arg(&llvm_cxx_lib[0])
            .arg(&llvm_cxx_lib[llvm_cxx_lib.len()-1])
            .arg("-o")
            .arg(match assist_type {
                AssistProgram::Instrumentation => _TMP_INS,
                AssistProgram::Callgraph => _TMP_CG,
                AssistProgram::PathSensitive => _TMP_PS
            }).output().unwrap();

    if !cmd_res.stderr.is_empty() {
        Err(String::from_utf8(cmd_res.stderr).unwrap())
    } else {
        Ok(())
    }

    // Ok(())
    
}

// pub fn instrumentation(input_path: Vec<&String>, output_path: &String) {
//     ()
// }

    // Command::new("clang++")
    //     .arg("-S")
    //     .arg("-emit-llvm")
    //     .arg(arg)
    //     .arg("-o")
    //     .arg("_tmp.ll").output().unwrap();
