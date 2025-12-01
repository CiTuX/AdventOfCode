module AdventOfCode

export main, Day01

include("Day01.jl")

function (@main)(args)
    input = readlines("res/day01.txt")
    result = Day01.part1(input)
    println("Part1: $result")
end

end
