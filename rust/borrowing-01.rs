fn main() {
    let mut list = vec![3, 5, 9];
    let last = list.last();
    let first = list.first();
    println!(
        "The first element is {:?} and the last is {:?}",
        first, last
    );
    let first = *list.first_mut().expect("list was empty") + 1;
    println!("The first element is now {:?}", first);
}
