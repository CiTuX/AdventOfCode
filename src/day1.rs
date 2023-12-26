use regex::Regex;
use substring::Substring;

const DIGIT: &str = r"\d|one|two|three|four|five|six|seven|eight|nine";

pub fn day1(content: String) -> u32 {
    let lines = content.lines();
    let mut result = 0;
    for line in lines {
        let start_digit = search_start_digit(DIGIT.parse().unwrap(), line);
        let end_digit = search_end_digit(DIGIT.parse().unwrap(), line);
        let number = start_digit * 10 + end_digit;
        result += number;
    }
    return result;
}

fn search_start_digit(regex: Regex, content: &str) -> u32 {
    for i in 1..=content.len() {
        let haystack = content.substring(0, i);
        let captures = regex.captures(haystack);
        if captures.is_none() {
            continue;
        } else {
            return map_number(&captures.unwrap()[0]);
        };
    }
    0
}

fn search_end_digit(regex: Regex, content: &str) -> u32 {
    let len = content.len();
    for i in 1..=len {
        let haystack = content.substring(len - i, len);
        let captures = regex.captures(haystack);
        if captures.is_none() {
            continue;
        } else {
            return map_number(&captures.unwrap()[0]);
        };
    }
    0
}


fn map_number(number: &str) -> u32 {
    return match number {
        "one" => 1,
        "two" => 2,
        "three" => 3,
        "four" => 4,
        "five" => 5,
        "six" => 6,
        "seven" => 7,
        "eight" => 8,
        "nine" => 9,
        _ => number.parse().unwrap_or(0)
    };
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

    #[test]
    fn part2() {
        let content = "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
1sixfivefivesix7f7twonel
7pqrstsixteen".to_string();
        let result = day1(content);
        assert_eq!(292, result);
    }
}