defmodule Day7.Test do
  use ExUnit.Case

  defp input(), do: TestHelper.read_input(__ENV__)

  test "example part1" do
    result = Day7.total_calibration_result(input())
    assert result == 3749
  end
end
