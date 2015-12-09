package main

import (
	"fmt"
	"../advent"
)

var up, down rune = '(', ')'

func main() {

	input := advent.ReadInput("day1")

	var floor int

	for index, char := range input {

		switch char {
		case up:
			floor++
			break
		case down:
			floor--
			break
		}

		if floor == -1 {
			fmt.Printf("Position %d - Floor %d\n", index + 1, floor)
		}
	}

	fmt.Print("\nFloor: ", floor)
}
