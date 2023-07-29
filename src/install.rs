use std::process::Command;
use std::{env, fs, path::Path};

use crate::common::execute_command;

pub fn install_dotfiles() -> Result<(), String> {
    if let Err(e) = create_filesystem() {
        return Err(format!("error in filesystem creation: {}", e));
    }

    if let Err(e) = setup_git(USER_EMAIL, USER_NAME) {
        return Err(format!("error setting up git: {}", e));
    }

    // TODO(clone dot dir)
    // TODO(add pgp)
    // TODO(add SSH)
    // TODO(ln emacs)
    // TODO(ln .zshrc)
    // TODO(extras: background, scroll direction)
    return Ok(());
}

const USER_EMAIL: &str = "bryce@thuilot.io";
const USER_NAME: &str = "Bryce Thuilot";

fn setup_git(email: &str, name: &str) -> Result<(), String> {
    if let Err(e) = execute_command("git", &["config", "--global", "user.email", email]) {
        return Err(format!("could not set git email: {}", e));
    }

    if let Err(e) = execute_command("git", &["config", "--global", "user.name", name]) {
        return Err(format!("could not set git name: {}", e));
    }

    return Ok(());
}

fn create_filesystem() -> Result<(), String> {
    let homeDirectory = match env::var("HOME") {
        Ok(s) => s,
        Err(_) => String::from("."),
    };

    if let Err(msg) = create_dir(format!("{}/github", homeDirectory)) {
        return Err(msg);
    }

    if let Err(msg) = create_dir(format!("{}/build", homeDirectory)) {
        return Err(msg);
    }

    return Ok(());
}

fn create_dir(path: String) -> Result<(), String> {
    let p = Path::new(&path);

    if !p.is_dir() {
        if let Err(_) = fs::create_dir_all(p) {
            return Err(String::from(format!("could not create directroy {}", path)));
        }
    }
    return Ok(());
}
