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
end
