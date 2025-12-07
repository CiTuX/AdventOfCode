module Day06

const operators = ['+', '*']

part1(input::Array) = handleInput(input)
part2(input::Array) = handleInput(input, rtlColumns)

function handleInput(input::Array, parseProblems::Function=transposeNumbers)
    input = copy(input)
    operations = pop!(input)
    problems = parseProblems(input, operations)
    operations = parseOperations(operations)
    results = Int[]
    for (i, row) in enumerate(eachrow(problems))
        push!(results, reduce(operations[i], filter(!isnothing, row)))
    end
    sum(results)
end

function rtlColumns(input::Array, operations::AbstractString)
    indices = reduce(vcat, findall.(operators, operations)) |> sort
    push!(indices, length(operations) + 2)
    numberRanges = map(i -> indices[i]:indices[i+1]-2, 1:(length(indices)-1))
    columns = map(line -> [SubString(line, first(r), last(r)) for r in numberRanges], input)
    columns = permutedims(hcat(columns...))
    numbers = Vector{Array{Union{Nothing, Int}}}()
    for column in eachcol(columns)
        maxDigits = maximum(length, column)
        colNumbers = Union{Nothing, Int}[]
        for position in maxDigits:-1:1
            digits = Char[]
            for number in column
                push!(digits, number[position])
            end
            push!(colNumbers, parse(Int, join(digits)))
        end
        if maxDigits < length(column)
            for _ in maxDigits:length(column) -1
                push!(colNumbers, nothing)
            end
        end
        push!(numbers, colNumbers)
    end
    permutedims(hcat(numbers...))
end

parseOperations(operations::AbstractString) = eval.(Meta.parse.(split(operations)))
transposeNumbers(problems::Array, _::AbstractString) = vcat(parseNumbers(problems)'...)'
parseNumbers(input::Array) = parseInts.(split.(input))
parseInts(row::Array) = parse.(Int, row)

end
