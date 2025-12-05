module Day05

part1(input::Array) = handleInput(input)
part2(input::Array) = length(input)

function handleInput(input::Array)
    splitIndex = findfirst(isempty, input)
    freshRanges = input[1:splitIndex-1] |> parseRanges
    ingredientIds = input[splitIndex+1:end] |> parseIngredients

    freshIds = 0
    for ingredientId in ingredientIds
        for range in freshRanges
            if ingredientId in range
                freshIds+=1
                break
            end
        end
    end
    freshIds
end

parseRanges(ranges::Array) = map(parseRange, ranges)
parseRange(range::AbstractString) = replace(range, "-" => ":") |> Meta.parse |> eval
parseIngredients(ingredients::Array) = map(ingredient -> parse(Int, ingredient), ingredients)

end