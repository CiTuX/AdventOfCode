package main
import (
	"fmt"
	"strconv"
	"strings"
	"crypto/md5"
	"encoding/hex"
)

const input = "ckczppom"

var inputBytes = []byte(input)

func main() {
	part1()
	fmt.Print("\n\n")
	part2()
}

func part1() {
	fmt.Print("Part 1")
	findHash("00000")
}

func part2() {
	fmt.Print("Part 2")
	findHash("000000")
}

func findHash(requirement string) {
	var hash string

	count := int64(0)
	hasher := md5.New()
	for (!strings.HasPrefix(hash, requirement)) {
		count++
		hasher.Reset()
		hasher.Write(strconv.AppendInt(inputBytes, count, 10))
		hash = hex.EncodeToString(hasher.Sum(nil))
	}
	fmt.Printf("\nCount: %d\nHash: %s", count, hash)
}