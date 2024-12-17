defmodule Day6 do
  alias Day6.Day6.Directions

  def count_distinct_positions(input) do
    map = String.split(input) |> Enum.map(&String.codepoints/1)
    map_size = length(map)
    guard = find_guard(map)
    obstructions = find_obstructions(map)
    direction = Directions.initial()
    visited = navigate_guard(guard, direction, map_size, obstructions)
    MapSet.size(visited)
  end

  defp find_guard(map, guard_indicator \\ "^") do
    y = Enum.find_index(map, &Enum.member?(&1, guard_indicator))
    row = Enum.at(map, y)
    x = Enum.find_index(row, &(&1 == guard_indicator))

    {x, y}
  end

  defp find_obstructions(map) do
    indexed_map(map) |> Enum.flat_map(&row_obstructions/1)
  end

  defp row_obstructions({row, y}, obstruction_indicator \\ "#"),
    do:
      row
      |> Enum.filter(&(elem(&1, 0) == obstruction_indicator))
      |> Enum.map(&{elem(&1, 1), y})

  defp indexed_map(map),
    do:
      map
      |> Enum.map(&Enum.with_index/1)
      |> Enum.with_index()

  defp navigate_guard(position, direction, map_size, obstructions, visited \\ %MapSet{}) do
    if check_bounds(position, map_size) do
      MapSet.put(visited, position)
      visited = MapSet.put(visited, position)
      direction = next_direction(direction, position, obstructions)
      position = navigate(position, direction)
      navigate_guard(position, direction, map_size, obstructions, visited)
    else
      visited
    end
  end

  defp check_bounds({x, y}, map_size),
    do: x >= 0 && x < map_size && y >= 0 && y < map_size

  defp next_direction(direction, position, obstructions) do
    next_position = navigate(position, direction)

    if Enum.member?(obstructions, next_position) do
      Directions.next(direction)
    else
      direction
    end
  end

  defp navigate({position_x, position_y}, {direction_x, direction_y}),
    do: {position_x + direction_x, position_y + direction_y}

  defmodule Day6.Directions do
    @north {0, -1}
    @east {1, 0}
    @south {0, 1}
    @west {-1, 0}

    def initial(), do: @north

    def next(direction) do
      case direction do
        @north -> @east
        @east -> @south
        @south -> @west
        @west -> @north
      end
    end
  end
end
