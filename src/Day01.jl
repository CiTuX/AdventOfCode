module Day01

using Match
export part1

dial = 50
counter = 0

function part1(input::Array)
    for instruction in input
        operation, distance = parseInstruction(instruction)
        executeOperation(operation, distance)
    end

    counter
end

function parseInstruction(instruction::AbstractString)
    direction = instruction[1]
    distance = parse(Int, instruction[2:end])

    @match direction begin
        'L' => (-, distance)
        'R' => (+, distance)
    end
end

function executeOperation(operation::Function, distance::Int)
    global dial = operation(dial, distance) % 100

    if 0 < dial < 100
        return
    elseif dial < 0
        dial += 100
    elseif dial >= 100
        dial -= 100
    end

    if dial == 0
        global counter += 1
    end
end

end
