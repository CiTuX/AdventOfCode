module Day03

const orderedJolts = map(string, 9:-1:1)

part1(input::Array) = handleInput(input)
part2(input::Array) = length(input)

function handleInput(banks::Array)
    total = 0
    for bank in banks
        total += calculateMaxJoltage(bank)
    end
    total
end

function calculateMaxJoltage(bank::AbstractString)
    firstIndex = findHighestJolt(bank)
    secondIndex = findHighestJolt(bank, firstIndex + 1)
    joltage = bank[firstIndex] * bank[secondIndex]
    parse(Int, joltage)
end

function findHighestJolt(bank::AbstractString, nextIndex::Integer=1)
    for jolt in orderedJolts
        index = findnext(jolt, bank, nextIndex)
        if index !== nothing && (nextIndex != 1 || length(bank) > index[1])
            return index[1]
        end
    end
    0
end

end
