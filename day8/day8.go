package main

import (
	"fmt"
	"../advent"
	"strconv"
)

var input string

func part1() {
	var chars []rune
	var totalNumber int

	for _, char := range input {
		if (char != '\n') {
			chars = append(chars, char)
		}else {
			if line, err := strconv.Unquote(string(chars)); err == nil {
				code := len(chars)
				memory := len(line)
				totalNumber += code - memory
			}
			chars = []rune{} //Reset
		}
	}

	fmt.Print("Part 1: ", totalNumber)
}

func part2() {
	var chars []rune
	var totalNumber int

	for _, char := range input {
		if (char != '\n') {
			chars = append(chars, char)
		}else {
			memory := len(strconv.Quote(string(chars)))
			code := len(chars)
			totalNumber += memory - code
			chars = []rune{} //Reset
		}
	}

	fmt.Print("Part 2: ", totalNumber)
}

func main() {
	input = advent.ReadInput()
	part1()
	fmt.Print("\n\n")
	part2()
}