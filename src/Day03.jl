module Day03

const orderedJolts = map(string, 9:-1:1)

part1(input::Array) = handleInput(input)
part2(input::Array) = handleInput(input, 12)

function handleInput(banks::Array, batteries::Int=2)
    total = 0
    for bank in banks
        total += calculateMaxJoltage(bank, batteries)
    end
    total
end

function calculateMaxJoltage(bank::AbstractString, batteries::Integer)
    bankLength = length(bank)
    joltage = 0
    start = 1
    remaining = batteries

    while remaining > 0
        endpos = bankLength - (remaining - 1)
        bestDigit = -1
        bestPosition = start

        for position in start:endpos
            digit = parse(Int, bank[position])
            if digit > bestDigit
                bestDigit = digit
                bestPosition = position
                if bestDigit == 9
                    break
                end
            end
        end

        joltage = joltage * 10 + bestDigit
        start = bestPosition + 1
        remaining -= 1
    end
    joltage
end

end
