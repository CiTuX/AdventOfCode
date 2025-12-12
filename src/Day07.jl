module Day07

const startmarker = 'S'
const splittermarker = '^'

part1(input::Array) = count_splits(input)
part2(input::Array) = count_timelines(input)

function count_splits(input::Array)
    tachyons = BitMatrix(undef, 1, length(input[1]))
    counter = 0
    startIndex = findfirst(startmarker, input[1])
    tachyons[startIndex] = true
    for line in input
        counter += collision_detection!(tachyons, line)
    end
    counter
end

function count_timelines(input::Array)
    rows = length(input)
    cols = length(input[1])
    timelines = zeros(Int, rows, cols)
    startIndex = findfirst(startmarker, input[1])
    timelines[1, startIndex] = 1

    for row in 2:rows
        for col in 1:cols
            if input[row][col] == splittermarker
                if col > 1
                    timelines[row, col-1] += timelines[row-1, col]
                end
                if col < cols
                    timelines[row, col+1] += timelines[row-1, col]
                end
            else
                timelines[row, col] += timelines[row-1, col]
            end
        end
    end
    sum(timelines[end, :])
end

function collision_detection!(tachyons::BitMatrix, line::AbstractString)
    counter = 0
    if contains(line, splittermarker)
        splitters = findall(splittermarker, line)
        for splitter in splitters
            if tachyons[splitter]
                tachyons[splitter] = false
                tachyons[splitter-1] = true
                tachyons[splitter+1] = true
                counter += 1
            end
        end
    end
    counter
end

end
