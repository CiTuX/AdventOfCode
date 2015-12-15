package main

import (
	"fmt"
	"../advent"
)

var lines []string

func part1() {
	fmt.Print(lines)
}

func part2() {
}

func main() {
	lines = advent.ReadLines()
	part1()
	fmt.Print("\n\n")
	part2()
}