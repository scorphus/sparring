use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize, Debug)]
struct Project {
    name: String,
}

fn main() {
    let rust = serde_json::from_str::<Project>(r#"{"name": "Rust"}"#);
    println!("{:?}", rust);
    let servo = serde_json::from_str::<Project>(r#"{"name": "Servo",}"#);
    println!("{:?}", servo);
}
