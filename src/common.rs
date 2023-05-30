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
