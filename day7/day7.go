package main

import (
	"fmt"
	"../advent"
)

var lines []string

func main() {
	lines = advent.ReadLines()
	part1()
	fmt.Print("\n\n")
	part2()
}

func part1() {
	for _, line := range lines {
		fmt.Print(line, "\n")
	}
}

func part2() {
}

