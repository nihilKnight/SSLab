use std::process::Command;
use std::path::Path;

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
    
    if llvm_cxx_lib.len() == 0 {
        return Err(String::from("LLVM configuration is not set."))
    }

    // compile the assist program through clang++.
    let compile_res = Command::new("clang++")
            .arg(_argus)
            .arg(&llvm_cxx_lib[0])
            .arg(&llvm_cxx_lib[llvm_cxx_lib.len()-1])
            .arg("-o")
            .arg(match assist_type {
                AssistProgram::Instrumentation => _TMP_INS,
                AssistProgram::Callgraph => _TMP_CG,
                AssistProgram::PathSensitive => _TMP_PS
            }).output().unwrap();

    if !compile_res.stderr.is_empty() {
        Err(String::from_utf8(compile_res.stderr).unwrap())
    } else {
        Ok(())
    }
    
}

pub fn instrumentation(input_path: Vec<&str>, _output_path: &str) -> Result<(), String>{

    for input in input_path.iter() {
        let path = Path::new(input);
        let input_name = path.file_stem().unwrap().to_str().unwrap();
        let input_parent = path.parent().unwrap();
        
        // compile all input files into IR code.
        let compile_res = Command::new("clang++")
            .arg("-S")
            .arg("-emit-llvm")
            .arg(input)
            .arg("-o")
            .arg(input_parent.join(input_name.to_owned() + ".ll")).output().unwrap();

        // perform instrumentation on all IR codes.
        let instrumentation_res = Command::new(_TMP_INS)
            .arg(input_parent.join(input_name.to_owned() + ".ll"))
            .arg(input_parent.join("_".to_owned() + input_name + ".ll")).output().unwrap();

        // assemble input files to object code.
        let assemble_res = Command::new("clang++")
            .arg("-c")
            .arg(input_parent.join("_".to_owned() + input_name + ".ll"))
            .arg(input_parent.join("_".to_owned() + input_name + ".o")).output().unwrap();

        if !compile_res.stderr.is_empty() || !instrumentation_res.stderr.is_empty() || !assemble_res.stderr.is_empty() {
            // remove all temp files.
            return Err(String::from_utf8(compile_res.stderr).unwrap())
        }

    }

    let _tmp_object = input_path.iter().map(|s| Path::new(*s).parent().unwrap().join(Path::new(*s).file_stem().unwrap().to_str().unwrap().to_owned() + ".o")).collect::<Vec<_>>();


    Ok(())
}
