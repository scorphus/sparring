use serde::{Deserialize, Serialize};
use std::env;

#[derive(Serialize, Deserialize, Debug)]
struct Project {
    name: String,
}

fn main() {
    let name = "My Project".to_string();
    let my_project = Project { name };
    println!("{:?}", my_project);

    let rust = serde_json::from_str::<Project>(r#"{"name": "Rust"}"#);
    println!("{:?}", rust);
    let servo = serde_json::from_str::<Project>(r#"{"name": "Servo",}"#);
    println!("{:?}", servo);

    let rust_name = match rust {
        Ok(rust) => rust.name,
        Err(_) => String::from("?"),
    };
    println!("rust project name: {}", rust_name);
    let servo_name = match servo {
        Ok(servo) => servo.name,
        Err(_) => String::from("?"),
    };
    println!("servo project name: {}", servo_name);

    let xz = vec![3, 5, 9];
    println!("Last element of xz: {:?}", xz.last());
    let xz: Vec<i32> = vec![];
    println!("Last element of xz: {:?}", xz.last());

    let num: i32 = "10".parse().expect("expected a number");
    println!("Parsed number: {}", num);

    let first_arg = env::args().nth(1).expect("need at least one argument");
    let message = match first_arg.parse::<i32>() {
        Ok(n) if n <= 0 => "Oi, give me a natural number!",
        Ok(n) if n < 42 => "That's too small a number...",
        Ok(n) if n > 42 => "That's too big a number...",
        Ok(_) => "YAY! You got it!",
        Err(_) => "Oi, give me a number!",
    };
    println!("{}", message);
}
