defmodule Day4Test do
  use ExUnit.Case

  test "example part1" do
    input = TestHelper.read_input(__ENV__)
    result = Day4.run(input)
    assert result == 18
  end
end
