module AdventOfCode

export main, Day01

include("Day01.jl")

function (@main)(args)
    input = readlines("res/day01.txt")
    println("Part1: $(Day01.part1(input))")
    println("Part2: $(Day01.part2(input))")
end

end
