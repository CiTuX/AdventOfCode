using AdventOfCode.Day01

const input = split("""
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82""", '\n')

@testset "Day01 Tests" begin
    @test Day01.part1(input) == 3
    @test Day01.part2(input) == 6
end
