defmodule Day4.Test do
  use ExUnit.Case

  test "example part1" do
    input = TestHelper.read_input(__ENV__)
    result = Day4.Part1.word_search(input)
    assert result == 18
  end

  test "example part2" do
    input = TestHelper.read_input(__ENV__)
    result = Day4.Part2.word_search(input)
    assert result == 9
  end

  test "count_horizontal" do
    window = [
      ["X", "M", "A", "S"],
      ["A", "A", "M", "X"],
      ["S", "M", "M", "X"],
      ["S", "A", "M", "X"]
    ]

    result = Day4.Part1.count_horizontal(window)
    assert result == 2
  end

  test "count_vertical" do
    window = [
      ["X", "X", "A", "S"],
      ["S", "M", "M", "A"],
      ["S", "A", "M", "M"],
      ["S", "S", "M", "X"]
    ]

    result = Day4.Part1.count_vertical(window)
    assert result == 2
  end

  test "count_diagonal normal" do
    window = [
      ["X", "X", "A", "S"],
      ["S", "M", "A", "A"],
      ["S", "M", "A", "M"],
      ["X", "S", "M", "S"]
    ]

    result = Day4.count_diagonal(window, Day4.Part1.word_vectors())
    assert result == 2
  end

  test "count_diagonal reverse" do
    window = [
      ["S", "X", "A", "X"],
      ["S", "A", "M", "A"],
      ["S", "A", "M", "M"],
      ["S", "S", "M", "X"]
    ]

    result = Day4.count_diagonal(window, Day4.Part1.word_vectors())
    assert result == 2
  end
end
