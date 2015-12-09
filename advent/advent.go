package advent

import (
	"io/ioutil"
	"runtime"
	"path"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func ReadInput() (input string) {
	_, file, _, ok := runtime.Caller(1)
	if (ok) {
		dir, _ := path.Split(file)
		dat, err := ioutil.ReadFile(dir + "input.txt")

		check(err)
		input = string(dat)
	}
	return
}
