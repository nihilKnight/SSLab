mod assist;

use assist::{AssistProgram, compile_assist_program, instrumentation};
use clap::{Arg, ArgAction};

use crate::assist::exist_assist_file;

// const MAX_FILE_ARGS_NUM: usize = 5;

fn main() {
    let mycc = clap::Command::new("mycc")
        .disable_help_flag(false)
        .arg(Arg::new("ins_path").short('I').long("instrumentation-program-path").num_args(0..))
        .arg(Arg::new("cg_path").short('C').long("callgraph-program-path").num_args(0..))
        .arg(Arg::new("ps_path").short('P').long("path-sensitive-program-path").num_args(0..))
        .arg(Arg::new("cached").short('c').long("cached-assist-programs").action(ArgAction::SetTrue))
        .arg(Arg::new("in_path").short('i').long("input-files-path").required(true).num_args(1..))
        .arg(Arg::new("out_path").short('o').long("output-file-path").required(true).num_args(0..));

    let matches = mycc.try_get_matches().unwrap_or_else(|e| e.exit());

    let cached_flag = matches.get_flag("cached");
    let in_path = matches.get_many::<String>("in_path").unwrap().collect::<Vec<_>>().iter().map(|s| (**s).as_str()).collect::<Vec<_>>();
    let out_path = matches.get_one::<String>("out_path").map(|s| (*s).as_str()).unwrap();

    if let Some(ins_path) = matches.get_many::<String>("ins_path") {
        // the assist program is `instrumentation`.

        match exist_assist_file(AssistProgram::Instrumentation) {
            Ok(founded)  => {
                if !(cached_flag && founded) {
                    match compile_assist_program(ins_path.clone().collect::<Vec<_>>(),AssistProgram::Instrumentation)
                    { Err(err_msg) => println!("Failed to compile assist program: {}.", err_msg), Ok(_) => () }
                }
                match instrumentation(in_path.clone(), out_path)
                { Err(err_msg) => println!("Failed to perform instrumentation: {}.", err_msg), Ok(_) => () }
            },
            Err(err_msg) => println!("Failed to locate assist file: {}", err_msg),
        }

        // println!("The Instrumentation program path is: {:?}.", ins_path.collect::<Vec<_>>());

    } else if let Some(cg_path) = matches.get_many::<String>("cg_path") {
        // the assist program is `callgraph`.

        match compile_assist_program(
            cg_path.clone().collect::<Vec<_>>(),
            AssistProgram::Callgraph
        ){
            Err(err_msg) => println!("Failed to compile assist program: {}.", err_msg),
            Ok(_) => (),
        }
        // println!("The Call graph analyzing program path is: {:?}.", cg_path.collect::<Vec<_>>());

    } else if let Some(ps_path) = matches.get_many::<String>("ps_path") {
        // the assist program is `path sensitive`.

        match compile_assist_program(
            ps_path.clone().collect::<Vec<_>>(),
            AssistProgram::PathSensitive
        ){
            Err(err_msg) => println!("Failed to compile assist program: {}.", err_msg),
            Ok(_) => (),
        }
        // println!("The Path sensitive analyzing program path is: {:?}.", ps_path.collect::<Vec<_>>());

    }

}

