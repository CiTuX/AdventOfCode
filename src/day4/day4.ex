defmodule Day4 do
  defp word(), do: "XMAS"

  def start(_type, _args) do
    path = __ENV__.file |> Path.dirname() |> Path.join("input.txt")
    input = File.read!(path)
    day1 = word_search(input)

    IO.puts("#{day1}")

    {:ok, self()}
  end

  @spec word_search(binary()) :: number()
  def word_search(input) do
    matrix = input |> String.split() |> Enum.map(&String.codepoints(&1))
    find_word(matrix)
  end

  def find_word(matrix) do
    window_size = String.length(word())

    vertical = find_word_vertically(matrix, window_size)
    horizontal = find_word_horizontally(matrix, window_size)
    diagonal = find_word_diagonally(matrix, window_size)

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

  def find_word_diagonally(matrix, window_size) do
    matrix_size = Enum.count(matrix)
    index_size = matrix_size - window_size

    find_word_diagonally(matrix, index_size, window_size) |> Enum.map(&Enum.sum(&1)) |> Enum.sum()
  end

  defp find_word_diagonally(matrix, index_size, window_size) do
    for y <- 0..index_size do
      for x <- 0..index_size do
        window = window(matrix, x, y, window_size)
        count_diagonal(window)
      end
    end
  end

  def count(window, vectors \\ word_vectors()),
    do: window |> Enum.count(&Enum.member?(vectors, &1))

  def count_horizontal(window),
    do: window |> count()

  def count_vertical(window),
    do: window |> map_vertical() |> count()

  def count_diagonal(window),
    do: [map_diagonal(window), map_diagonal(Enum.reverse(window))] |> count()

  defp word_vectors(),
    do: word() |> String.codepoints() |> then(&[&1, Enum.reverse(&1)])

  defp window(matrix, x, y, size),
    do: matrix |> Enum.slice(y, size) |> Enum.map(&Enum.slice(&1, x, size))

  defp map_vertical(window) do
    index_size = Enum.count(hd(window)) - 1

    for y <- 0..index_size do
      Enum.map(window, &Enum.at(&1, y))
    end
  end

  defp map_diagonal(window) do
    index_size = Enum.count(window) - 1

    for i <- 0..index_size do
      Enum.at(window, i) |> Enum.at(i)
    end
  end
end
