input = __ENV__.file |> Path.dirname() |> Path.join("input.txt") |> File.read!()
Day5.validated_middle_page_sum(input) |> IO.puts()
