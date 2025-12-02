module Day02

part1(input::Array) = handleInput(input)
part2(input::Array) = length(input)

function handleInput(input::Array)
    result = 0
    ranges = split(input[1], ',')
    for range in ranges
        result += parseRange(range) |> validateRange
    end
    result
end

parseRange(range) = replace(range, "-" => ":") |> Meta.parse |> eval

function validateRange(productIds::AbstractRange)
    invalidRanges = 0
    for productId in productIds
        len = length("$productId")
        if len % 2 == 0
            base = 10^(length("$productId") / 2)
            left = productId ÷ base
            right = productId % base
            if left == right
                invalidRanges += productId
            end
        end
    end
    invalidRanges
end

end
