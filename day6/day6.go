package main

import (
	"../advent"
	"strings"
	"strconv"
	"fmt"
)

const turn, on, off, toggle, through, separator = "turn", "on", "off", "toggle", "through", ","

var theGrid [1000][1000]bool

type Index struct {
	x, y int
}

type Coords struct {
	from, to Index
}

func main() {
	input := advent.ReadInput()
	part1(input)
}

func part1(input string) {
	for _, line := range strings.Split(input, "\n") {
		if (line != "") {
			coords := parseCoords(line)
			state := parseState(line)
			toogle := parseToggle(line)

			setLight(coords, state, toogle)
		}
	}

	var counter int
	for x := 0; x < 1000; x++ {
		for y := 0; y < 1000; y++ {
			if (theGrid[x][y]) {
				counter++
			}
		}
	}
	fmt.Print("Part 1: ", counter)
}

func setLight(coords Coords, state, toggle bool) {
	for x := coords.from.x; x <= coords.to.x; x++ {
		for y := coords.from.y; y <= coords.to.y; y++ {
			if (toggle) {
				theGrid[x][y] = !theGrid[x][y]
			}else {
				theGrid[x][y] = state
			}
		}
	}
}

func parseState(word string) bool {
	if (strings.HasPrefix(word, turn)) {
		switch word[5:7] {
		case on:
			return true
		case off:
			return false
		}
	}
	return false
}

func parseToggle(word string) bool {
	return strings.HasPrefix(word, toggle)
}

func parseCoords(line string) Coords {
	coords := Coords{}
	var indexes []Index

	for _, word := range strings.Split(line, " ") {
		if (strings.Contains(word, separator)) {
			separated := strings.Split(word, separator)
			indexes = append(indexes, parseIndex(separated))
		}
	}

	if (len(indexes) == 2) {
		coords.from = indexes[0]
		coords.to = indexes[1]
	}

	return coords
}

func parseIndex(indexes []string) Index {
	if (len(indexes) == 2) {
		x, _ := strconv.Atoi(indexes[0])
		y, _ := strconv.Atoi(indexes[1])
		return Index{x, y}
	}
	return Index{}
}
