input = __ENV__.file |> Path.dirname() |> Path.join("input.txt") |> File.read!()
Day6.count_distinct_positions(input) |> IO.puts()
Day6.count_possible_obstructions(input) |> IO.puts()
