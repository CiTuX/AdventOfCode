defmodule Day4.Part2 do
  import Day4

  def word(), do: "MAS"
  def word_vectors(), do: word_vectors(word())

  @spec word_search(binary()) :: number()
  def word_search(input) do
    matrix = input |> String.split() |> Enum.map(&String.codepoints(&1))

    find_word_diagonally(matrix, word_vectors())
  end

  defp find_word_diagonally(matrix, vectors) do
    result = find_vectors(matrix, vectors)
    Enum.reduce(result, 0, &reduce_x_mas/2)
  end

  defp reduce_x_mas(x, acc), do: Enum.count(x, &match_x_mas/1) + acc

  defp match_x_mas(element), do: element == 2
end
