use clap::Arg;
// use std::process::Command;

fn main() {
    let max_file_args_num = 5;
    let mycc = clap::Command::new("mycc")
        .disable_help_flag(false)
        .arg(Arg::new("ins_path").short('I').long("instrumentation_program_path").num_args(1..=max_file_args_num))
        .arg(Arg::new("cg_path").short('C').long("callgraph_program_path").num_args(1..=max_file_args_num))
        .arg(Arg::new("ps_path").short('P').long("path_sensitive_program_path").num_args(1..=max_file_args_num))
        .arg(Arg::new("in_path").short('i').long("input_file_path").required(true).num_args(1..=max_file_args_num))
        .arg(Arg::new("out_path").short('o').long("output_file_path").required(true));

    let matches = mycc.try_get_matches().unwrap_or_else(|e| e.exit());

    if let Some(ins_path) = matches.get_many::<String>("ins_path") {
        println!("The Instrumental program path is: {:?}.", ins_path.collect::<Vec<_>>());
    } else if let Some(cg_path) = matches.get_many::<String>("cg_path") {
        println!("The Call graph analyzing program path is: {:?}.", cg_path.collect::<Vec<_>>());
    } else if let Some(ps_path) = matches.get_many::<String>("ps_path") {
        println!("The Path sensitive analyzing program path is: {:?}.", ps_path.collect::<Vec<_>>());
    }

    let in_path = matches.get_many::<String>("in_path").unwrap().collect::<Vec<_>>();
    let out_path = matches.get_one::<String>("out_path").map(|s| s.as_str()).unwrap();

    println!("The input and output file path is: {:?} & {}.", in_path, out_path);

}
