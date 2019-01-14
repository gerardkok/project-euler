fn largest_prime_factor(number : u64) -> u64 {
    let mut n = number;
    let mut factor: u64 = 2;
    while factor <= n / 2 {
        if n % factor == 0 {
            n /= factor;
        } else {
            factor += 1;
        }
    }
    n
}

fn main() {
    let answer: u64 = largest_prime_factor(600_851_475_143);
    println!("{}", answer);
}

#[cfg(test)]
mod tests {
    #[test]
    fn test_largest_prime_factor() {
        assert_eq!(2, super::largest_prime_factor(4));
        assert_eq!(3, super::largest_prime_factor(9));
        assert_eq!(29, super::largest_prime_factor(13195));
    }
}
