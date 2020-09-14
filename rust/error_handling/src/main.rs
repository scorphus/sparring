use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
struct Project {
    name: String,
}

fn main() {
    let rust = serde_json::from_str::<Project>(r#"{"name": "Rust"}"#);
    println!("{:?}", rust);
    let servo = serde_json::from_str::<Project>(r#"{"name": "Servo",}"#);
    println!("{:?}", servo);

    let xz = vec![3, 5, 9];
    println!("Last element of xz: {:?}", xz.last());

    let xz: Vec<i32> = vec![];
    println!("Last element of xz: {:?}", xz.last());
}
