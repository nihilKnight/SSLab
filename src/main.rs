use clap::Arg;

fn main() {
    let mycc = clap::Command::new("mycc")
        .disable_help_flag(false)
        .arg(Arg::new("config").short('c').long("config"))
        .arg(Arg::new("input").short('i').long("input"));

    let matches = mycc.try_get_matches().unwrap_or_else(|e| e.exit());

}
