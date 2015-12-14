package advent

import (
	"io/ioutil"
	"runtime"
	"path"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func getFile() string {
	_, file, _, ok := runtime.Caller(2)
	if (ok) {
		dir, _ := path.Split(file)
		return dir + "input.txt"
	}
	return ""
}

func readInput(file string) string {
	dat, err := ioutil.ReadFile(file)
	check(err)
	return string(dat)
}

func ReadInput() string {
	return readInput(getFile())
}

func ReadLines() []string {
	return ParseLines(readInput(getFile()))
}

func ParseLines(input string) []string {
	var lines []string
	for _, line := range strings.Split(input, "\n") {
		if line = strings.TrimSpace(line); len(line) > 1 {
			lines = append(lines, line)
		}
	}
	return lines
}