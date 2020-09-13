pub fn say(s: String) {
    println!("You know what? {}!", s)
}

fn main() {
    let a = String::from("Bananas");
    say(a.clone());
    println!("Damn right! {}!", a)
}
