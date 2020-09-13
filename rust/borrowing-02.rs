#[derive(Debug)]
struct Player {
    score: i32,
}

impl Player {
    fn set_score(&mut self, new_score: i32) {
        self.score = new_score;
    }

    fn score(&self) -> i32 {
        self.score
    }

    fn new() -> Self {
        Player { score: 0 }
    }
}

fn main() {
    let mut player1 = Player::new();
    player1.set_score(player1.score() + 1);
    println!("{:?}", player1);
}
