defmodule Day6.Test do
  use ExUnit.Case

  test "example part1" do
    input = TestHelper.read_input(__ENV__)
    result = Day6.count_distinct_positions(input)
    assert result == 41
  end
end
