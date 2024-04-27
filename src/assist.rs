use std::process::Command;
use std::path::Path;

const _ASSIST_DIR: &str = "assists/";
const _TMP_INS: &str = "_instrumentation";
const _TMP_CG: &str = "_callgraph";
const _TMP_PS: &str = "_path_sensitive";

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
                AssistProgram::Instrumentation => _ASSIST_DIR.to_owned() + _TMP_INS,
                AssistProgram::Callgraph => _ASSIST_DIR.to_owned() +_TMP_CG,
                AssistProgram::PathSensitive => _ASSIST_DIR.to_owned() +_TMP_PS
            }).output().unwrap();

    if !compile_res.stderr.is_empty() {
        Err(String::from_utf8(compile_res.stderr).unwrap())
    } else {
        Ok(())
    }
    
}

pub fn exist_assist_file(assist_type: AssistProgram) -> Result<bool, String> {
    let ls_res = Command::new("ls").arg(_ASSIST_DIR).output().unwrap();
    if !ls_res.stderr.is_empty() {
        Err(String::from_utf8(ls_res.stderr).unwrap())
    } else {
        let file_list = String::from_utf8(ls_res.stdout).unwrap();
        match assist_type {
            AssistProgram::Instrumentation => Ok(file_list.contains(&_TMP_INS)),
            AssistProgram::Callgraph => Ok(file_list.contains(&_TMP_CG)),
            AssistProgram::PathSensitive => Ok(file_list.contains(&_TMP_PS))
        }
    }
}

// auto-instrumentation
pub fn instrumentation(input_path: Vec<&str>, output_path: &str) -> Result<(), String> {

    // The IR code files before instrumentation.
    let mut tmp_ir_paths: Vec<String> = vec![];
    // The IR code files after instrumentation.
    let mut tmp_ir_paths_: Vec<String> = vec![];
    // The object code files after instrumentation.
    let mut tmp_obj_paths: Vec<String> = vec![];

    for input in input_path.iter() {
        let path = Path::new(input);
        let input_name = path.file_stem().unwrap().to_str().unwrap();
        let input_parent = path.parent().unwrap();
        let tmp_ir = input_parent.join(input_name.to_owned() + ".ll");
        let tmp_ir_ = input_parent.join("_".to_owned() + input_name + ".ll");
        let tmp_obj = input_parent.join("_".to_owned() + input_name + ".o");
        
        // compile all input files into IR code.
        let compile_res = Command::new("clang++")
            .arg("-S")
            .arg("-emit-llvm")
            .arg(input)
            .arg("-o")
            .arg(tmp_ir.clone()).output().unwrap();

        // perform instrumentation on all IR codes.
        let instrumentation_res = Command::new(_ASSIST_DIR.to_owned() + _TMP_INS)
            .arg(tmp_ir.clone())
            .arg(tmp_ir_.clone()).output().unwrap();

        // assemble input files to object code.
        let assemble_res = Command::new("clang++")
            .arg("-c")
            .arg(tmp_ir_.clone())
            .arg("-o")
            .arg(tmp_obj.clone()).output().unwrap();

        if !compile_res.stderr.is_empty() {
            // remove all temp files.
            return Err(String::from_utf8(compile_res.stderr).unwrap());
        } else if !instrumentation_res.stderr.is_empty() {
            return Err(String::from_utf8(instrumentation_res.stderr).unwrap());
        } else if !assemble_res.stderr.is_empty() {
            return Err(String::from_utf8(assemble_res.stderr).unwrap());
        }
        
        tmp_ir_paths.push(tmp_ir.to_str().unwrap().to_string());
        tmp_ir_paths_.push(tmp_ir_.to_str().unwrap().to_string());
        tmp_obj_paths.push(tmp_obj.to_str().unwrap().to_string());
    }

    let link_res = Command::new("clang++")
        .arg(tmp_obj_paths.join(" "))
        .arg("-o")
        .arg(output_path).output().unwrap();

    if !link_res.stderr.is_empty() {
        Err(String::from_utf8(link_res.stderr).unwrap())
    } else {
        rm_temp_files(tmp_ir_paths).unwrap();
        rm_temp_files(tmp_ir_paths_).unwrap();
        rm_temp_files(tmp_obj_paths).unwrap();
        Ok(())
    }

}

fn rm_temp_files(tmp_files: Vec<String>) -> Result<(), String> {
    for tmp_file in tmp_files {
        let rm_res = Command::new("rm").arg("-f").arg(tmp_file).output().unwrap();
        if !rm_res.stderr.is_empty() {
            return Err(String::from_utf8(rm_res.stderr).unwrap());
        }
    }

    Ok(())
}

