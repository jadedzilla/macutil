use std::fs;
use std::process::Command;
use std::io::{self, Write};

fn main() {
    loop {
        match select_and_run_script() {
            Ok(should_exit) => {
                if should_exit {
                    println!("Exiting the program.");
                    break;
                }
            },
            Err(e) => {
                eprintln!("Error: {}", e);
                // Optionally break or continue here, depending on how you want to handle errors
            },
        }
    }
}

fn select_and_run_script() -> io::Result<bool> {
    // Read the contents of the scripts directory
    let entries = fs::read_dir("scripts")?;
    let mut scripts: Vec<String> = Vec::new();

    // Collect script names
    for entry in entries {
        let entry = entry?;
        if let Some(file_name) = entry.file_name().to_str() {
            if file_name.ends_with(".sh") {
                scripts.push(file_name.to_string());
            }
        }
    }

    // Display available scripts
    println!("\nAvailable scripts:");
    for (i, script) in scripts.iter().enumerate() {
        println!("{}. {}", i + 1, script);
    }
    println!("0. Exit");

    // Get user input
    print!("Enter the number of the script to run (or 0 to exit): ");
    io::stdout().flush()?;
    let mut input = String::new();
    io::stdin().read_line(&mut input)?;

    // Parse user input
    let choice: usize = input.trim().parse().map_err(|_| io::Error::new(io::ErrorKind::InvalidInput, "Invalid input"))?;

    if choice == 0 {
        return Ok(true); // Signal to exit the program
    }

    if choice > scripts.len() {
        return Err(io::Error::new(io::ErrorKind::InvalidInput, "Invalid script number"));
    }

    // Run the selected script
    let script_path = format!("scripts/{}", scripts[choice - 1]);
    let output = Command::new("sh")
        .current_dir("scripts")  // Set the working directory to "scripts"
        .arg(&scripts[choice - 1])  // Use just the script name, not the full path
        .output()?;

    // Print the script output
    io::stdout().write_all(&output.stdout)?;
    io::stderr().write_all(&output.stderr)?;

    println!("Script execution completed.");
    Ok(false) // Signal to continue the loop
}
