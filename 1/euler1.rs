fn main() {
    let answer: u32 = (1..1000).filter(|x| x % 3 == 0 || x % 5 == 0).sum();
    println!("{}", answer);
}
