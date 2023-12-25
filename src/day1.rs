pub fn day1(content: String) -> u32 {
    let lines = content.lines();
    let mut result = 0;
    for line in lines {
        let mut first_digit = 0;
        let mut last_digit = 0;
        for char in line.chars() {
            if char.is_digit(10) {
                let digit = char.to_digit(10).unwrap();
                if first_digit == 0 {
                    first_digit = digit;
                }
                last_digit = digit;
            }
        }
        let number: u32 = first_digit * 10 + last_digit;
        result += number;
    }
    return result;
}

#[cfg(test)]
mod tests {
    use crate::day1::day1;

    #[test]
    fn part1() {
        let content = "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet".to_string();
        let result = day1(content);
        assert_eq!(142, result);
    }
}