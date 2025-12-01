module Day01

using Match

@enum PasswordMethod::Int begin
    zero = 0
    any = 0x434C49434B
end

struct State
    count::Int
    dial::Int
end

part1(input::Array) = handleInput(input)
part2(input::Array) = handleInput(input, any)

function handleInput(input::Array, passwordMethod::PasswordMethod=zero)
    state = State(0, 50)

    for instruction in input
        operation, distance = parseInstruction(instruction)
        state = executeOperation(state, operation, distance, passwordMethod)
    end

    state.count
end

function parseInstruction(instruction::AbstractString)
    direction = instruction[1]
    distance = parse(Int, instruction[2:end])

    @match direction begin
        'L' => (-, distance)
        'R' => (+, distance)
    end
end

function executeOperation(state::State, operation::Function, distance::Int, passwordMethod::PasswordMethod)
    count = 0
    dial = 0
    flipCount = passwordMethod == any && state.dial != 0

    if distance > 100 && passwordMethod == any
        count += distance ÷ 100
    end

    dial = operation(state.dial, distance % 100)

    if dial == 100
        dial = 0
    elseif dial > 100
        dial -= 100
        if flipCount
            count += 1
        end
    elseif dial < 0
        dial += 100
        if flipCount
            count += 1
        end
    end

    if dial == 0
        count += 1
    end

    State(state.count + count, dial)
end

end
