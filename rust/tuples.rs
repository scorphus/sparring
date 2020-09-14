fn main() {
    let a_tuple_of_tuples = ((179, 359),);
    println!("{:#?}", a_tuple_of_tuples);
    println!("{:#?}", a_tuple_of_tuples.0);
    println!("{:#?}", a_tuple_of_tuples.0.1);
}
