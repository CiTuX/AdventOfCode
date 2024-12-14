defmodule Day4 do
  def start(_type, _args) do
    input = __ENV__.file |> Path.dirname() |> Path.join("input.txt") |> File.read!()

    Day4.Part1.word_search(input) |> IO.puts()
    Day4.Part2.word_search(input) |> IO.puts()

    {:ok, self()}
  end
end
