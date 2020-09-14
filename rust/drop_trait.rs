#[derive(Debug)]
struct NoisyStruct {
    id: i32,
}

impl NoisyStruct {
    fn new(id: i32) -> Self {
        NoisyStruct { id: id }
    }
}

impl Drop for NoisyStruct {
    fn drop(&mut self) {
        println!("Hey, hey! NoisyStruct {} here, going outta scope!", self.id);
    }
}

fn main() {
    let noisy_struct = NoisyStruct::new(359);
    println!("{:?}", noisy_struct);
}
