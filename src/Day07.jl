module Day07

const startmarker = 'S'
const splittermarker = '^'

part1(input::Array) = handle_input(input)
part2(input::Array) = handle_input(input)

function handle_input(input::Array)
    tachyons = BitMatrix(undef, 1, length(input[1]))
    counter = 0
    for line in input
        if sum(tachyons) == 0
            startIndex = findfirst(startmarker, line)
            tachyons[startIndex] = true
        else
            counter += collision_detection!(tachyons, line)
        end
    end
    counter
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
