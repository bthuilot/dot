use crate::common::install_brew_packages;
use std::io::ErrorKind;
use std::process::Command;
use std::result::Result;
use std::{thread, time};

/// install_requirements will install requirements for
/// the `dotfiles install` command. After this command
/// run, the 1password installation will need to be
/// configured manually.
pub fn install_requirements() -> Result<(), String> {
    println!("installing xcode-select");
    if let Err(s) = install_xcode_select() {
        return Err(format!("error while installing xcode-select: {}", s));
    }
    println!("installing homebrew");
    if let Err(s) = install_homebrew() {
        return Err(format!("error while installing homebrew: {}", s));
    }
    println!("install 1password");
    if let Err(s) =
        install_brew_packages(["homebrew/cask/1password", "homebrew/cask/1password-cli"].iter())
    {
        return Err(format!("error install 1password: {}", s));
    }
    return Ok(());
}

/// Installs xcode-select tooling if is not already installed
fn install_xcode_select() -> Result<(), String> {
    // first check for pre-exisiting installation
    let mut exists = match Command::new("xcode-select").arg("-p").output() {
        Ok(o) => o.status.success(),
        Err(_) => return Err(String::from("xcode-select could not be executed")),
    };
    if exists {
        // if it already is installed, skip the rest
        println!("already installed!");
        return Ok(());
    }

    // at this point we know its not installed, so we
    // execute `xcode-select --install` which will spawn
    // a window to install the xcode tooling
    println!("running install window");
    if let Err(_) = Command::new("xcode-select").arg("--install").status() {
        // If there was an error, exit
        return Err(String::from("unable to run xcode-select --install"));
    }

    // TODO(add max timeout)
    // Now we continually check the path to see when it updates
    // command prints path -> xcode-select is installed
    while !exists {
        let is_installed = Command::new("xcode-select").arg("-p").output();
        exists = match is_installed {
            Ok(output) => output.status.success(),
            Err(_) => return Err(String::from("xcode-select could not be executed")),
        };
        // sleep 5 second between each call
        thread::sleep(time::Duration::from_secs(5));
    }

    return Ok(());
}

/// installs homebrew for user if the `brew` command does not
/// yet exist in PATH.
fn install_homebrew() -> Result<(), String> {
    if let Err(e) = Command::new("brew").arg("-v").status() {
        if ErrorKind::NotFound == e.kind() {
            return match Command::new("/bin/bash")
                    .arg("-c")
                    .arg("$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")
                    .status()
                {
                    Ok(_) => Ok(()),
                    Err(_) => Err(String::from("unable to run homebrew installed")),
                };
        } else {
            return Err(String::from("unable to run brew command"));
        }
    };
    return Ok(());
}
