package main

import (
	"fmt"
	"../advent"
	"strings"
)

var vowels = []string{"a", "e", "i", "o", "u"}
var blacklist = []string{"ab", "cd", "pq", "xy"}

func main() {
	input := advent.ReadInput()
	part1(input)
}

func part1(input string) {
	var count int
	for _, line := range strings.Split(input, "\n") {
		if (checkWord(line)) {
			count++
		}
	}
	fmt.Print("Count: ", count)
}

func checkWord(word string) (nice bool) {
	nice = false
	if (countVowels(word) >= 3) {
		if (letterTwiceInRow(word)) {
			if (checkBlacklist(word)) {
				nice = true
			}
		}
	}
	return
}

func countVowels(word string) (count int) {
	for _, vowel := range vowels {
		count += strings.Count(word, vowel)
	}
	return count
}

func letterTwiceInRow(word string) (twice bool) {
	var lastLetter rune
	for _, letter := range word {
		if (letter == lastLetter) {
			return true
		}
		lastLetter = letter
	}
	return false
}

func checkBlacklist(word string) (ok bool) {
	for _, entry := range blacklist {
		if (strings.Contains(word, entry)) {
			return false
		}
	}
	return true
}