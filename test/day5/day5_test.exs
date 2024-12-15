defmodule Day5.Test do
  use ExUnit.Case

  test "example part1" do
    input = TestHelper.read_input(__ENV__)
    result = Day5.validated_middle_page_sum(input)
    assert result == 143
  end
end
