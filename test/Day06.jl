using AdventOfCode.Day06

const input = split("""
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  """, '\n')

@testset "Day06 Tests" begin
    @test Day06.part1(input) == 4277556
    @test Day06.part2(input) == 3263827
end
