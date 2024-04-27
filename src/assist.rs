use std::io::Write;
use std::process::Command;
use std::path::Path;
use std::fs::File;

const _ASSIST_DIR: &str = "assists/";
const _TMP_INS: &str = "_instrumentation";
const _TMP_CG: &str = "_callgraph";
const _TMP_PS: &str = "_path_sensitive";
const _LINKED_LL: &str = "_linked_ll.ll";

pub enum AssistProgram {
    Instrumentation,
    Callgraph,
    PathSensitive
}

// the function compiling the asssit program to `_tmp_some` executable.
pub fn compile_assist_program(some_path: Vec<&String>, assist_type: AssistProgram) -> Result<(), String> {

    // get the llvm config lib of the current environment.
    let llvm_cxx_lib = match Command::new("llvm-config").arg("--cxxflags").arg("--libs").output() {
        Ok(output) => {
            if !output.stderr.is_empty() {
                return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
            }
            match String::from_utf8(output.stdout) {
                Ok(output_str) => output_str
                                            .replace("\n", " ")
                                            .split(" ")
                                            .map(|s| s.replace(" ", ""))
                                            .filter(|s| !s.is_empty())
                                            .collect::<Vec<_>>(),
                Err(e) => return Err(e.to_string())
            }
        },
        Err(e) => return Err(e.to_string())
    };
            
    if llvm_cxx_lib.len() == 0 {
        return Err(String::from("LLVM configuration is not set."))
    }

    // println!("{:?}", llvm_cxx_lib);

    // compile the assist program through clang++.
    match Command::new("clang++")
        .args(some_path)
        .args(&llvm_cxx_lib)
        .arg("-o")
        .arg(match assist_type {
            AssistProgram::Instrumentation => _ASSIST_DIR.to_owned() + _TMP_INS,
            AssistProgram::Callgraph => _ASSIST_DIR.to_owned() +_TMP_CG,
            AssistProgram::PathSensitive => _ASSIST_DIR.to_owned() +_TMP_PS
        }).output() {
            Ok(output) => {
                if !output.stderr.is_empty() {
                    return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                }; 
                Ok(())
            },
            Err(e) => Err(e.to_string())
        }
    
}

// check whether or not the assist file exists.
pub fn exist_assist_file(assist_type: AssistProgram) -> Result<bool, String> {
    match Command::new("ls").arg(_ASSIST_DIR).output() {
        Ok(output) => {
            if !output.stderr.is_empty() {
                return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
            }
            match String::from_utf8(output.stdout) {
                Ok(output_str) => match assist_type {
                    AssistProgram::Instrumentation => Ok(output_str.contains(&_TMP_INS)),
                    AssistProgram::Callgraph => Ok(output_str.contains(&_TMP_CG)),
                    AssistProgram::PathSensitive => Ok(output_str.contains(&_TMP_PS))
                },
                Err(e) => Err(e.to_string())
            }
        },
        Err(e) => Err(e.to_string())
    }
}

// auto-instrumentation
pub fn instrumentation(input_path: Vec<&str>, output_path: &str, cxx_flag: bool) -> Result<(), String> {

    // use c or cxx compiler.
    let clang_compiler = if cxx_flag { "clang++" } else { "clang" };

    // the IR code files before instrumentation.
    let mut tmp_ir_paths: Vec<String> = vec![];
    // the IR code files after instrumentation.
    let mut tmp_ir_paths_: Vec<String> = vec![];
    // the object code files after instrumentation.
    let mut tmp_obj_paths: Vec<String> = vec![];

    for input in input_path.iter() {
        let path = Path::new(input);
        let input_name = match path.file_stem() {
            Some(stem) => match stem.to_str() {
                Some(stem_str) => stem_str,
                None => return Err(String::from("Failed to convert &OsStr to &str."))
            }
            None => return Err(String::from("Failed to split the input assist file path."))
        };
        let input_parent = match path.parent() {
            Some(parent) => parent,
            None => return Err(String::from("Failed to get the parent dirs of input assist file path."))
        };
        let tmp_ir = input_parent.join(input_name.to_owned() + ".ll");
        let tmp_ir_ = input_parent.join("_".to_owned() + input_name + ".ll");
        let tmp_obj = input_parent.join("_".to_owned() + input_name + ".o");
        
        // compile all input files into IR code.
        match Command::new(clang_compiler)
            .arg("-S")
            .arg("-emit-llvm")
            .arg(input)
            .arg("-o")
            .arg(tmp_ir.clone()).output() {
                Ok(output) => {
                    if !output.stderr.is_empty() {
                        return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                    }; 
                },
                Err(e) => return Err(e.to_string())
            };

        // perform instrumentation on all IR codes.
        match Command::new(_ASSIST_DIR.to_owned() + _TMP_INS)
            .arg(tmp_ir.clone())
            .arg(tmp_ir_.clone()).output() {
                Ok(output) => {
                    if !output.stderr.is_empty() {
                        return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                    }; 
                },
                Err(e) => return Err(e.to_string())
            }

        // assemble input files to object code.
        match Command::new(clang_compiler)
            .arg("-c")
            .arg(tmp_ir_.clone())
            .arg("-o")
            .arg(tmp_obj.clone()).output() {
                Ok(output) => {
                    if !output.stderr.is_empty() {
                        return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                    }; 
                },
                Err(e) => return Err(e.to_string())
            }

        tmp_ir_paths.push(match tmp_ir.to_str() { Some(str) => str.to_string(), None => return Err(String::from("Failed to convert PathBuf to &str.")) });
        tmp_ir_paths_.push(match tmp_ir_.to_str() { Some(str) => str.to_string(), None => return Err(String::from("Failed to convert PathBuf to &str.")) });
        tmp_obj_paths.push(match tmp_obj.to_str() { Some(str) => str.to_string(), None => return Err(String::from("Failed to convert PathBuf to &str.")) });
    }

    // link object files into executable.
    match Command::new(clang_compiler)
        .args(&tmp_obj_paths)
        .arg("-o")
        .arg(output_path).output() {
            Ok(output) => {
                if !output.stderr.is_empty() {
                    return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                }; 
                match rm_temp_files(tmp_ir_paths) { Ok(_) => (), Err(e) => return Err(e.to_string()) };
                match rm_temp_files(tmp_ir_paths_) { Ok(_) => (), Err(e) => return Err(e.to_string()) };
                match rm_temp_files(tmp_obj_paths) { Ok(_) => (), Err(e) => return Err(e.to_string()) };
                Ok(())
            },
            Err(e) => Err(e.to_string())
        }
}

pub fn callgraph(input_path: Vec<&str>, output_path: &str, cxx_flag: bool) -> Result<(), String> {
    let clang_compiler = if cxx_flag { "clang++" } else { "clang" };

    // IR code files.
    let mut tmp_ir_paths: Vec<String> = vec![];

    for input in input_path.iter() {
        let path = Path::new(input);
        let input_name = match path.file_stem() {
            Some(stem) => match stem.to_str() {
                Some(stem_str) => stem_str,
                None => return Err(String::from("Failed to convert &OsStr to &str."))
            }
            None => return Err(String::from("Failed to split the input assist file path."))
        };
        let input_parent = match path.parent() {
            Some(parent) => parent,
            None => return Err(String::from("Failed to get the parent dirs of input assist file path."))
        };
        let tmp_ir = input_parent.join(input_name.to_owned() + ".ll");
        
        // compile all input files into IR code.
        match Command::new(clang_compiler)
            .arg("-S")
            .arg("-emit-llvm")
            .arg(input)
            .arg("-o")
            .arg(tmp_ir.clone()).output() {
                Ok(output) => {
                    if !output.stderr.is_empty() {
                        return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                    }
                },
                Err(e) => return Err(e.to_string())
            }

        tmp_ir_paths.push(match tmp_ir.to_str() { Some(str) => str.to_string(), None => return Err(String::from("Failed to convert PathBuf to &str.")) });
    }

    // link IR code files together.
    match Command::new("llvm-link")
        .arg("-S")
        .args(&tmp_ir_paths)
        .arg("-o")
        .arg(_LINKED_LL).output() {
            Ok(output) => {
                if !output.stderr.is_empty() {
                    return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                }; 
            },
            Err(e) => return Err(e.to_string())
        }
    
    match Command::new(_ASSIST_DIR.to_owned() + _TMP_CG)
        .arg(_LINKED_LL).output() {
            Ok(output) => {
                if !output.stderr.is_empty() {
                    return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                } else {
                    match File::create(output_path) {
                        Ok(mut file) => match file.write_all(&output.stdout) {
                            Ok(_) => (),
                            Err(e) => return Err(e.to_string())
                        },
                        Err(e) => return Err(e.to_string())
                    }
                } 
            },
            Err(e) => return Err(e.to_string())
        }

    match rm_temp_files(tmp_ir_paths) {
            Ok(_) => (),
            Err(e) => return Err(e.to_string())
        }

    match Command::new("rm").arg("-f").arg(_LINKED_LL).output() {
            Ok(output) => {
                if !output.stderr.is_empty() {
                    return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                }; 
                Ok(())
            },
            Err(e) => Err(e.to_string())
        }

}

pub fn path_sensitive(input_path: Vec<&str>, output_path: &str, cxx_flag: bool) -> Result<(), String> {
    unimplemented!("unimplemented callgraph, {}, {}, {}", input_path.join(" "), output_path, cxx_flag);
}

fn rm_temp_files(tmp_files: Vec<String>) -> Result<(), String> {
    for tmp_file in tmp_files {
        match Command::new("rm").arg("-f").arg(tmp_file).output() {
            Ok(output) => {
                if !output.stderr.is_empty() {
                    return Err(match String::from_utf8(output.stderr) { Ok(err_msg) => err_msg, Err(e) => e.to_string() })
                }; 
            },
            Err(e) => return Err(e.to_string())
        }
    }

    Ok(())
}

