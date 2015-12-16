package main

import (
	"fmt"
	"regexp"
	"strconv"
	"../advent"
)

type BitOperation struct {
	sign  string
	regex *regexp.Regexp
}

const (
	REGEX_START = "^(\\w*) "
	REGEX_MIDDLE = " (\\w*) "
	REGEX_END = " (\\w*)$"
)

const (
	SET = "->"
	AND = "AND"
	OR = "OR"
	LSHIFT = "LSHIFT"
	RSHIFT = "RSHIFT"
	NOT = "NOT"
)

var lines []string
var signals = make(map[string]uint16, 100)
var commands = make(map[int]BitOperation)

var operations = []BitOperation{
	BitOperation{SET, initRegex(REGEX_START)},
	BitOperation{AND, initRegex(REGEX_START + AND + REGEX_MIDDLE)},
	BitOperation{OR, initRegex(REGEX_START + OR + REGEX_MIDDLE)},
	BitOperation{LSHIFT, initRegex(REGEX_START + LSHIFT + REGEX_MIDDLE) },
	BitOperation{RSHIFT, initRegex(REGEX_START + RSHIFT + REGEX_MIDDLE) },
	BitOperation{NOT, initRegex(NOT + REGEX_MIDDLE) },
}

func (bitOp BitOperation) Execute(input string) bool {
	switch bitOp.sign {
	case SET:
		if found := findString(bitOp.regex, input); found != nil {
			if number, err := strconv.Atoi(found[0]); err == nil {
				signals[found[1]] = uint16(number)
				return true
			}else {
				if x, ok := signals[found[0]]; ok {
					signals[found[1]] = x
				}
			}
		}
	case AND:
		if found := findString(bitOp.regex, input); found != nil {
			if x, ok := signals[found[0]]; ok {
				if y, ok := signals[found[1]]; ok {
					signals[found[2]] = x & y
					return true
				}
			}else if number, err := strconv.Atoi(found[0]); err == nil {
				if y, ok := signals[found[1]]; ok {
					signals[found[2]] = uint16(number) & y
					return true
				}
			}
		}
	case OR:
		if found := findString(bitOp.regex, input); found != nil {
			if x, ok := signals[found[0]]; ok {
				if y, ok := signals[found[1]]; ok {
					signals[found[2]] = x | y
					return true
				}
			}
		}
	case LSHIFT:
		if found := findString(bitOp.regex, input); found != nil {
			if x, ok := signals[found[0]]; ok {
				if number, err := strconv.Atoi(found[1]); err == nil {
					signals[found[2]] = x << uint16(number)
					return true
				}
			}
		}
	case RSHIFT:
		if found := findString(bitOp.regex, input); found != nil {
			if x, ok := signals[found[0]]; ok {
				if number, err := strconv.Atoi(found[1]); err == nil {
					signals[found[2]] = x >> uint16(number)
					return true
				}
			}
		}
	case NOT:
		if found := findString(bitOp.regex, input); found != nil {
			if x, ok := signals[found[0]]; ok {
				signals[found[1]] = ^x
				return true
			}
		}
	}
	return false
}

func findString(regex *regexp.Regexp, input string) []string {
	found := regex.FindStringSubmatch(input)
	return found[1:len(found)]
}

func initRegex(pattern string) *regexp.Regexp {
	regex, err := regexp.Compile(pattern + SET + REGEX_END)
	if (err != nil) {
		panic(err)
	}
	return regex
}

func parseLine(input string) BitOperation {
	for _, operation := range operations {
		if (operation.regex.MatchString(input)) {
			return operation
		}
	}
	panic(input)
}

func part1() {
	for index, line := range lines {
		operation := parseLine(line)
		commands[index] = operation
	}

	var success = make(map[int]bool)
	for len(success) < len(commands) - 1 {
		for index, operation := range commands {
			if (!success[index]) {
				if (operation.Execute(lines[index])) {
					success[index] = true
				}
			}
		}
	}
	fmt.Print("Part 1: ", signals["a"])
}

func part2() {
	a := signals["a"]
	signals = make(map[string]uint16, 100)
	signals["b"] = a

	var success = make(map[int]bool)
	for len(success) < len(commands) - 1 {
		for index, operation := range commands {
			if (!success[index]) {
				if (operation.Execute(lines[index])) {
					success[index] = true
				}
			}
		}
	}
	fmt.Print("Part 2: ", signals["a"])
}

func main() {
	lines = advent.ReadLines()
	part1()
	fmt.Print("\n\n")
	part2()
}