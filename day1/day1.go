package main

import (
	"fmt"
	"../advent"
)

const up, down = '(', ')'

func main() {

	input := advent.ReadInput()

	var floor int

	for index, char := range input {

		switch char {
		case up:
			floor++
		case down:
			floor--
		}

		if floor == -1 {
			fmt.Printf("Position %d - Floor %d\n", index + 1, floor)
		}
	}

	fmt.Print("\nFloor: ", floor)
}
