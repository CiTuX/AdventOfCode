defmodule Day7.Test do
  use ExUnit.Case

  defp input(), do: TestHelper.read_input(__ENV__)

  test "example part1" do
    result = Day7.part1(input())
    assert result == 3749
  end

  test "example part2" do
    result = Day7.part2(input())
    assert result == 11387
  end
end
