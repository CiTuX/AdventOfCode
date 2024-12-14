defmodule Day4.Part2 do
  @spec word_search(binary()) :: number()
  def word_search(input) do
    matrix = input |> String.split() |> Enum.map(&String.codepoints(&1))
    matrix |> Enum.count()
  end
end
