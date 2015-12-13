package main

import (
	"fmt"
	"../advent"
	"strings"
	"strconv"
	"sort"
)

func main() {
	var totalPaper, totalRibbon int

	for _, entry := range advent.ReadLines() {
		values := strings.Split(entry, "x")
		if (len(values) == 3) {
			paper, ribbon := calcEntry(values)
			totalPaper += paper
			totalRibbon += ribbon
		}
	}

	fmt.Print("Paper: ", totalPaper, "\nRibbon: ", totalRibbon)
}

func calcEntry(values []string) (paper, ribbon int) {
	l, err := strconv.Atoi(values[0])
	w, err := strconv.Atoi(values[1])
	h, err := strconv.Atoi(values[2])

	if (err == nil) {
		dimensions := []int{l, w, h}
		sort.Ints(dimensions)
		smallest := dimensions[0] * dimensions[1]

		paper := ((2 * l * w) + (2 * w * h) + (2 * h * l) + smallest)
		ribbon := (2 * dimensions[0]) + (2 * dimensions[1]) + (l * w * h)

		return paper, ribbon
	}
	return 0, 0
}