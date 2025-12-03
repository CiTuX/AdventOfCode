using AdventOfCode.Day03

const input = split("""
987654321111111
811111111111119
234234234234278
818181911112111""", '\n')

@testset "Day03 Tests" begin
    @test Day03.part1(input) == 357
end
