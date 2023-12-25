use std::fs;
mod day1;

fn main() {
    let content = fs::read_to_string("./res/day1.txt")
        .expect("Should have been able to read the file");
    let result = day1::day1(content);
    println!("{result}")
}
