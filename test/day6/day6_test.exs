defmodule Day6.Test do
  use ExUnit.Case

  defp input(), do: TestHelper.read_input(__ENV__)

  test "example part1" do
    result = Day6.count_distinct_positions(input())
    assert result == 41
  end

  test "example part2" do
    result = Day6.count_possible_obstructions(input())
    assert result == 6
  end
end
