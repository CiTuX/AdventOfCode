defmodule Day4 do
  def start(_type, _args) do
    input = __ENV__.file |> Path.dirname() |> Path.join("input.txt") |> File.read!()

    Day4.Part1.word_search(input) |> IO.puts()
    Day4.Part2.word_search(input) |> IO.puts()

    {:ok, self()}
  end

  def find_vectors(matrix, vectors) do
    matrix_size = Enum.count(matrix)
    window_size = Enum.count(hd(vectors))
    index_size = matrix_size - window_size

    for y <- 0..index_size do
      for x <- 0..index_size do
        window = window(matrix, x, y, window_size)
        count_diagonal(window, vectors)
      end
    end
  end

  defp window(matrix, x, y, size),
    do: matrix |> Enum.slice(y, size) |> Enum.map(&Enum.slice(&1, x, size))

  def count(window, vectors),
    do: window |> Enum.count(&Enum.member?(vectors, &1))

  def count_diagonal(window, vectors),
    do: [map_diagonal(window), map_diagonal(Enum.reverse(window))] |> count(vectors)

  defp map_diagonal(window) do
    index_size = Enum.count(window) - 1

    for i <- 0..index_size do
      Enum.at(window, i) |> Enum.at(i)
    end
  end

  def word_vectors(word),
    do: word |> String.codepoints() |> then(&[&1, Enum.reverse(&1)])
end
