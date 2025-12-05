module Day05

part1(input::Array) = handleInput(input)
part2(input::Array) = handleInput(input, countAllFreshIngredients)

function handleInput(input::Array, action::Function=countAvailableFreshIngredients)
    splitIndex = findfirst(isempty, input)
    freshRanges = input[1:splitIndex-1]
    ingredientIds = input[splitIndex+1:end]

    action(freshRanges, ingredientIds)
end

function countAvailableFreshIngredients(freshRanges::Array, ingredientIds::Array)
    ranges = map(parseRange, freshRanges)
    ids = ingredientIds |> parseIngredients
    freshIds = 0
    for id in ids
        for range in ranges
            if id in range
                freshIds += 1
                break
            end
        end
    end
    freshIds
end

function countAllFreshIngredients(freshRanges::Array, _::Array)
    ranges = map(parseTuple, freshRanges) |> sort
    merged = []
    for range in ranges
        if isempty(merged) || range[1] > merged[end][2] + 1
            push!(merged, range)
        else
            merged[end] = (merged[end][1], max(merged[end][2], range[2]))
        end
    end
    mergedRanges = [u:v for (u, v) in merged]
    map(length, mergedRanges) |> sum
end


parseRange(range::AbstractString) = replace(range, "-" => ":") |> Meta.parse |> eval
parseTuple(range::AbstractString) = "($(replace(range, "-" => ",")))" |> Meta.parse |> eval
parseIngredients(ingredients::Array) = map(ingredient -> parse(Int, ingredient), ingredients)

end