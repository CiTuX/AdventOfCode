module Day08

part1(input::Array) = handle_input(input)
part2(input::Array) = handle_input(input)

function handle_input(input::Array)
    input = parse_input(input)
    display(input)
end

parse_input(input::Array) = parse_ints.(split.(input,','))
parse_ints(row::Array) = parse.(Int, row)

end
