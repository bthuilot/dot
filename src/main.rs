use clap::{Parser, Subcommand};

use crate::preinstall::install_requirements;

mod common;
mod install;
mod preinstall;

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Cli {
    /// Turn debugging information on
    #[arg(short, long, action = clap::ArgAction::Count)]
    debug: u8,

    #[command(subcommand)]
    command: Option<Commands>,
}

#[derive(Subcommand)]
enum Commands {
    /// Install necessary dependecies for install
    PreInstall {},
    /// Installs the dotfiles repostiory and configurations
    Install {},
    /// TODO(rename to verify)
    Backup {},
}

fn main() {
    let cli = Cli::parse();

    // You can see how many times a particular flag or argument occurred
    // Note, only flags can have multiple occurrences
    match cli.debug {
        0 => println!("Debug mode is off"),
        1 => println!("Debug mode is kind of on"),
        2 => println!("Debug mode is on"),
        _ => println!("Don't be crazy"),
    }

    // You can check for the existence of subcommands, and if found use their
    // matches just as you would the top level cmd
    match &cli.command {
        Some(Commands::Install {}) => {
            println!("installing...");
            println!("complete!");
        }
        Some(Commands::Backup {}) => {
            println!("backing up...");
            println!("complete!");
        }
        Some(Commands::PreInstall {}) => {
            println!("running pre-install command");
            match install_requirements() {
                Ok(_) => {
                    println!("complete!");
                    println!(
                        "be sure to configure 1password CLI before running `dotfiles install`"
                    );
                }
                Err(s) => {
                    println!("error: {}", s)
                }
            }
        }
        None => {}
    }
}
