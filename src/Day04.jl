module Day04

using DSP

const searchKernel = [
    1 1 1;
    1 0 1;
    1 1 1
]

part1(input::Array) = handleInput(input)
part2(input::Array) = length(input)

function handleInput(input::Array)
    gridSize = length(input)
    grid = parseInput(input)
    convolution = conv(grid, searchKernel)
    neighbors = convolution[2:gridSize+1, 2:gridSize+1]
    maskedNeighbors = neighbors .* grid
    filtered = map(x -> 0 < x < 4, maskedNeighbors)
    sum(filtered)
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