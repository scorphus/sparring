fn main() {
    let s = String::from("book");
    println!("I have one {}, you have two {}.", s, pluralize(&s));
}

fn pluralize(s: &str) -> String {
    s.to_owned() + "s"
}
