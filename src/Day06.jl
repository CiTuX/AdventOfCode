module Day06

part1(input::Array) = handleInput(input)
part2(input::Array) = handleInput(input)

function handleInput(input::Array)
    input = map(split, input)
    operations = parseOperations(pop!(input))
    numbers = parseNumbers(input)
    numbers = vcat(numbers'...)'
    results = []
    for (i, row) in enumerate(eachrow(numbers))
        push!(results, reduce(operations[i], row))
    end
    sum(results)
end

parseOperations(operations::Array) = map(operation -> operation |> Meta.parse |> eval, operations)
parseNumbers(input::Array) = map(parseInts, input)
parseInts(row::Array) = parse.(Int, row)

end
