module Day04

using DSP

const searchKernel = [
    1 1 1
    1 0 1
    1 1 1
]

part1(input::Array) = handleInput(input)
part2(input::Array) = handleInput(input, 1000)

function handleInput(input::Array, iterations::Int=1)
    total = 0
    grid = parseInput(input)
    for _ in 1:iterations
        removed, grid = removeRolls(grid)
        if removed == 0
            break
        end
        total += removed
    end
    total
end

function removeRolls(grid::AbstractArray)
    gridSize = size(grid, 1)
    convolution = conv(grid, searchKernel)
    neighbors = convolution[2:gridSize+1, 2:gridSize+1]
    filtered = map((active, neighbor) -> active == 1 && neighbor < 4, grid, neighbors)
    count = sum(filtered)
    (count, grid - filtered)
end

function parseInput(input::Array)
    rows = []
    for row in input
        push!(rows, parseRow(row))
    end

    hcat(rows[:, 1]...)'
end

parseRow(row::AbstractString) = map(char -> char == '@', collect(row))

end