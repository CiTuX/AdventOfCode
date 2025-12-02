module Day02

part1(input::Array) = handleInput(input, validateTwice)
part2(input::Array) = handleInput(input, validateMany)

function handleInput(input::Array, validationFunction::Function)
    result = 0
    ranges = split(input[1], ',')
    for range in ranges
        result += validate(range, validationFunction)
    end
    result
end

parseRange(range::AbstractString) = replace(range, "-" => ":") |> Meta.parse |> eval

function validate(range::AbstractString, validationFunction::Function)
    invalidRanges = 0
    productIds = parseRange(range)
    for productId in productIds
        invalidRanges += validationFunction(productId)
    end
    invalidRanges
end

function validateTwice(productId::Int)
    len = length("$productId")
    if len % 2 == 0
        base = 10^(length("$productId") / 2)
        left = productId ÷ base
        right = productId % base
        if left == right
            return productId
        end
    end
    return 0
end

function validateMany(productId::Int)
    len = length("$productId")
    for iteration in range(1, len ÷ 2)
        if len % iteration == 0
            parts = len ÷ iteration
            base = 10^(len - iteration)
            number = productId ÷ base
            repeated = 0

            for _ in range(; stop=parts)
                repeated = (repeated * 10^iteration) + number
            end

            if repeated == productId
                return productId
            end
        end
    end
    return 0
end

end
