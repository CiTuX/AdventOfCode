package main

import (
	"fmt"
	"strings"

	"../advent"
)

var lines []string
var vowels = []string{"a", "e", "i", "o", "u"}
var blacklist = []string{"ab", "cd", "pq", "xy"}

func main() {
	lines = advent.ReadLines()
	part1()
	fmt.Print("\n\n")
	part2()
}

func part1() {
	var count int
	for _, line := range lines {
		if checkWordSimpel(line) {
			count++
		}
	}
	fmt.Print("Part1: ", count)
}

func part2() {
	var count int
	for _, line := range lines {
		if checkWordKomplex(line) {
			count++
		}
	}
	fmt.Print("Part2: ", count)
}

func checkWordKomplex(word string) bool {
	if (checkContainsPairTwice(word)) {
		if checkRepeatLetter(word) {
			return true
		}
	}
	return false
}

func checkContainsPairTwice(word string) (ok bool) {
	pairs := parsePairs(word)
	if pairs != nil {
		return hasDuplicates(pairs)
	}
	return false
}

func parsePairs(word string) (pairs []string) {
	wordLen := len(word)
	pairs = make([]string, wordLen)
	for i := 0; i < wordLen - 1; i++ {
		pairs[i] = word[i : i + 2]
	}
	return
}

func checkRepeatLetter(word string) bool {
	wordLen := len(word)
	for i := 0; i < wordLen - 3; i++ {
		if word[i] == word[i + 2] {
			return true
		}
	}
	return false
}

func hasDuplicates(elements []string) bool {
	for i := 0; i < len(elements); i++ {
		// Scan slice for a previous element of the same value.
		for v := 0; v < i; v++ {
			if elements[v] == elements[i] {
				if (i - v != 1) {
					return true
				}
			}
		}
	}
	return false
}

func checkWordSimpel(word string) (nice bool) {
	nice = false
	if countVowels(word) >= 3 {
		if letterTwiceInRow(word) {
			if checkBlacklist(word) {
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
		if letter == lastLetter {
			return true
		}
		lastLetter = letter
	}
	return false
}

func checkBlacklist(word string) (ok bool) {
	for _, entry := range blacklist {
		if strings.Contains(word, entry) {
			return false
		}
	}
	return true
}
