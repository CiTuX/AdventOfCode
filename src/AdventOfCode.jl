module AdventOfCode

export main

include("Day01.jl")

function (@main)(args)
    prefix = if length(args) == 0
        ""
    elseif length(args) == 1
        lpad(args[1], 2, "0")
    end

    days = names(AdventOfCode, all=true) |> filter(name -> startswith("$name", "Day$prefix"))
    
    for day in days
        input = readlines("res/$(lowercase("$day")).txt")
        modul = eval(day)
        println("$day Part1: $(modul.part1(input))")
        println("$day Part2: $(modul.part2(input))")
    end
end

end
