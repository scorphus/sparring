use std::collections::HashMap;

fn used_to_be_invalid_code() {
    let text = "Rusty rust rust";
    let mut freq = HashMap::new();
    for word in text.split_whitespace() {
        match freq.get_mut(word) {
            Some(val) => *val += 1,
            None => {
                freq.insert(word, 1);
            }
        };
    }
    println!("Word freq: {:#?}", freq);
}

fn a_better_way_to_code_it() {
    let text = "Rusty rust rust";
    let mut freq = HashMap::new();
    for word in text.split_whitespace() {
        *freq.entry(word).or_insert(0) += 1;
    }
    println!("Word freq: {:#?}", freq);
}

fn main() {
    used_to_be_invalid_code();
    much_better_way_to_code_it();
}
