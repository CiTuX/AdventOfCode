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
	part2(input)
}

func part1(input string) {
	presents := make(map[Position]int)

	x := 0
	y := 0

	presents[Position{x, y}] = 1

	for _, char := range input {

		x, y = changePosition(char, x, y)

		presents[Position{x, y}]++
	}
	fmt.Print("Part 1: ", len(presents))
}

func part2(input string) {
	presents := make(map[Position]int)

	//Santa
	sX := 0
	sY := 0

	//Robo
	rX := 0
	rY := 0

	//Init
	presents[Position{sX, sY}] = 1
	presents[Position{rX, rY}] = 1


	for index, char := range input {
		switch index % 2 {
		case 0:
			rX, rY = changePosition(char, rX, rY) //Robo
			presents[Position{rX, rY}]++
		case 1:
			sX, sY = changePosition(char, sX, sY) //Santa
			presents[Position{sX, sY}]++
		}
	}

	fmt.Print("\nPart 2: ", len(presents))
}

func changePosition(char rune, x, y int) (int, int) {
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
	return x, y
}