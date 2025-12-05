using AdventOfCode.Day05

const input = split("""
3-5
10-14
16-20
12-18

1
5
8
11
17
32""", '\n')

@testset "Day05 Tests" begin
    @test Day05.part1(input) == 3
end
