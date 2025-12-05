module AdventOfCode

export main, prefix

const prefix = "Day"
const days = readdir(@__DIR__) |> filter(file -> startswith(file, prefix))

for day in days
    include(day)
end

function (@main)(args)
    suffix = if length(args) == 0
        ""
    elseif length(args) == 1
        lpad(args[1], 2, "0")
    end

    days = names(AdventOfCode, all=true) |> filter(name -> startswith("$name", prefix * suffix))

    for day in days
        input = readlines("res/$(lowercase("$day")).txt")
        modul = eval(day)
        println("$day Part1: $(modul.part1(input))")
        println("$day Part2: $(modul.part2(input))")
    end
end

end
