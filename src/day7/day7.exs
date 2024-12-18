input = __ENV__.file |> Path.dirname() |> Path.join("input.txt") |> File.read!()
Day7.part1(input) |> IO.puts()
Day7.part2(input) |> IO.puts()
