use std::{ffi::OsStr, process::Command};

/// install_brew_packages will the brew package names
/// given. Its ideal to pass in the full package name, include tap.
pub fn install_brew_packages<T: AsRef<OsStr>, I: Iterator<Item = T>>(
    packages: I,
) -> Result<(), String> {
    match Command::new("brew").arg("install").args(packages).status() {
        Ok(_) => Ok(()),
        Err(_) => Err(String::from("unable to install pacakges")),
    }
}

/// get_1pass_value will return the value of the 1password item
pub fn get_1pass_value<T: AsRef<OsStr>>(key: T, field: T) -> Result<String, String> {
    // spawn a child process op get item wait for it to complete with success code, then return the STDOUT as a string
    match Command::new("op")
        .arg("get")
        .arg("item")
        .arg(key)
        .arg("--fields")
        .arg(field)
        .output()
    {
        Ok(output) => {
            if output.status.success() {
                // if the command was successful, return the stdout as a string, if not return an error
                match String::from_utf8(output.stdout) {
                    Ok(s) => Ok(s),
                    Err(_) => Err(String::from("unable to get 1password value")),
                }
            } else {
                Err(String::from("unable to get 1password value"))
            }
        }
        Err(_) => Err(String::from("unable to get 1password value")),
    }
}

pub fn execute_command<T: AsRef<OsStr>>(command: T, args: &[T]) -> Result<(), String> {
    match Command::new(command).args(args).status() {
        Err(e) => Err(format!("unable to execute command: {}", e)),
        // If successfull, check the status code
        Ok(status) => {
            if status.success() {
                Ok(())
            } else {
                Err(format!("command failed with status: {}", status))
            }
        }
    }
}
