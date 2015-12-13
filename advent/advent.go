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
	lines := strings.Split(input, "\n")
	for index, line := range lines {
		lines[index] = strings.TrimSpace(line)
	}
	return lines
}