using Test

import AdventOfCode

@testset "AdventOfCode Tests" begin
    for day in readdir(@__DIR__) |> filter(file -> startswith(file, AdventOfCode.prefix))
        include(day)
    end
end
