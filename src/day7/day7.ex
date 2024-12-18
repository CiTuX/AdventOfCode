defmodule Day7 do
  def part1(input), do: total_calibration_result(input, [&+/2, &*/2])
  def part2(input), do: total_calibration_result(input, [&+/2, &*/2, &concat/2])

  def total_calibration_result(input, operations) do
    parse_input(input)
    |> Enum.map(fn {expected, equation} -> evaluate_equation(equation, expected, operations) end)
    |> Enum.sum()
  end

  defp parse_input(input, separator \\ ":") do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, separator))
    |> Enum.group_by(&Enum.at(&1, 0), &(Enum.at(&1, 1) |> String.split()))
    |> Enum.map(&map_input/1)
  end

  defp map_input({key, value}) do
    {
      key |> String.to_integer(),
      value |> Enum.at(0) |> Enum.map(&String.to_integer/1)
    }
  end

  defp evaluate_equation(equation, expected, operations) do
    permutations = permutations(operations, length(equation) - 1)
    results = evaluate_equation_permutations(equation, expected, permutations)
    Enum.find(results, 0, &(&1 == expected))
  end

  defp evaluate_equation_permutations(equation, expected, permutations) do
    for operations <- permutations do
      Enum.reduce_while(
        1..length(operations),
        hd(equation),
        &evaluate_equation_permutations(&1, &2, equation, expected, operations)
      )
    end
  end

  defp evaluate_equation_permutations(index, acc, equation, expected, operations) do
    if acc <= expected do
      number = Enum.at(equation, index)
      operation = Enum.at(operations, index - 1)
      {:cont, apply(operation, [acc, number])}
    else
      {:halt, 0}
    end
  end

  defp permutations(_list, 0), do: [[]]

  defp permutations(list, count) do
    for(item <- list, rest <- permutations(list, count - 1), do: [item | rest])
  end

  def concat(left, right) do
    exponent = right |> Integer.digits() |> length()
    left * Integer.pow(10, exponent) + right
  end
end
