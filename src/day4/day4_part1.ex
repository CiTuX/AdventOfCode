defmodule Day4.Part1 do
  import Day4

  def word(), do: "XMAS"

  def word_vectors(), do: word_vectors(word())

  @spec word_search(binary()) :: number()
  def word_search(input) do
    matrix = input |> String.split() |> Enum.map(&String.codepoints(&1))
    find_word(matrix)
  end

  def find_word(matrix) do
    window_size = String.length(word())

    vertical = find_word_vertically(matrix, window_size)
    horizontal = find_word_horizontally(matrix, window_size)
    diagonal = find_word_diagonally(matrix, word_vectors())

    vertical + horizontal + diagonal
  end

  def find_word_vertically(matrix, window_size),
    do:
      matrix
      |> Enum.chunk_every(window_size, 1, :discard)
      |> Enum.map(&count_vertical/1)
      |> Enum.sum()

  def find_word_horizontally(matrix, window_size),
    do:
      matrix
      |> Enum.map(&Enum.chunk_every(&1, window_size, 1, :discard))
      |> Enum.map(&count_horizontal/1)
      |> Enum.sum()

  defp find_word_diagonally(matrix, vectors),
    do:
      find_vectors(matrix, vectors)
      |> Enum.map(&Enum.sum(&1))
      |> Enum.sum()

  def count_horizontal(window),
    do: window |> count(word_vectors())

  def count_vertical(window),
    do: window |> map_vertical() |> count(word_vectors())

  defp map_vertical(window) do
    index_size = Enum.count(hd(window)) - 1

    for y <- 0..index_size do
      Enum.map(window, &Enum.at(&1, y))
    end
  end
end
