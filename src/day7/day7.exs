input = __ENV__.file |> Path.dirname() |> Path.join("input.txt") |> File.read!()
Day7.total_calibration_result(input) |> IO.puts()
