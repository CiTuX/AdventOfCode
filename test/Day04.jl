using AdventOfCode.Day04

const input = split("""
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.""", '\n')

@testset "Day04 Tests" begin
    @test Day04.part1(input) == 13
    @test Day04.part2(input) == 43
end
