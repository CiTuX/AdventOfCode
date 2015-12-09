package main

import (
	"fmt"
	"../advent"
)

const north, south, east, west = '^', 'v', '>', '<'

type Position struct {
	x, y int
}

func main() {
	input := advent.ReadInput("day3")
	part1(input)
}

func part1(input string) {
	presents := make(map[Position]int)

	x := 0
	y := 0

	presents[Position{x, y}] = 1

	for _, char := range input {

		switch char {
		case north:
			y++
			break
		case south:
			y--
			break
		case east:
			x--
			break
		case west:
			x++
			break
		}

		presents[Position{x, y}]++
		fmt.Print(x, "|", y, "=", presents[Position{x, y}], "\n")
	}
	fmt.Print("\n\n", len(presents))
}