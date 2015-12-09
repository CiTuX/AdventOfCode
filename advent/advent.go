package advent

import (
	"io/ioutil"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func ReadInput(day string) (string) {
	dat, err := ioutil.ReadFile(day + "/input.txt")
	check(err)

	input := string(dat)

	return input
}
