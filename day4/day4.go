package main
import (
	"fmt"
	"strconv"
	"strings"
	"crypto/md5"
	"encoding/hex"
)

const input = "ckczppom"
const requirement = "00000"

var inputBytes = []byte(input)

func main() {
	part1()
}

func part1() {
	var hash string

	count := int64(0)
	hasher := md5.New()
	for (!strings.HasPrefix(hash, requirement)) {
		count++
		hasher.Reset()
		hasher.Write(strconv.AppendInt(inputBytes, count, 10))
		hash = hex.EncodeToString(hasher.Sum(nil))
	}
	fmt.Print(count, "\n", hash)
}